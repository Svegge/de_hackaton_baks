import os
import sys
import pendulum
import pandas as pd
from airflow.operators.bash import BashOperator
from airflow.utils.task_group import TaskGroup
from airflow.operators.python import PythonOperator
from airflow.decorators import dag, task
from airflow.providers.postgres.hooks.postgres import PostgresHook

sys.path.insert(0, '/lessons/project/')
from cfg.funcs import load_yaml
from stg.load_pg_stg import load_pg_stg

postgres_conn_id = 'postgres_baks_project'
file_path = "/lessons/project/files/"
files_to_load = load_yaml('sources').get('files')
bash_commands = load_yaml('bash_commands')

pg_hook = PostgresHook(postgres_conn_id)


@dag(schedule_interval=None,
     start_date=pendulum.parse('2023-03-31')
     )
def clickstream_logs_handling_dag():
    """Обработка логов кликов пользователей"""
    clean_src_files_task = BashOperator(
            task_id=f'clean_loaded_files',
            bash_command=bash_commands.get('clean_src_files_task')
        )
    file_get_tasks = []
    for num, file in enumerate(files_to_load):
        get_src_files_task = BashOperator(
            task_id=f'get_src_file_{num}',
            bash_command=f'wget -P /lessons/project/files/ {file}'
        )
        file_get_tasks.append(get_src_files_task)

    with TaskGroup(group_id='unpack_files') as tg1:
        unpack_gz_files_task = BashOperator(
                task_id=f'unpack_gz_files',
                bash_command=bash_commands.get('unpack_gz_files_task')
            )
        unpack_zip_files_task = BashOperator(
                task_id=f'unpack_zip_files',
                bash_command=bash_commands.get('unpack_zip_files_task')
            )

    load_pg_stg_task = PythonOperator( 
        task_id='load_pg_stg', 
        python_callable=load_pg_stg, 
        op_kwargs={
            'file': os.path.join(file_path, 'events-2022-Sep-30-2134.json'), 
            'table': 'stg_logs', 
            'schema': 'stg',
            'pg_hook': pg_hook,
        } 
    )
    clean_src_files_task >> file_get_tasks >> tg1 >> load_pg_stg_task
    # clean_src_files_task >> file_get_tasks >> tg1


clickstream_logs_handling_dag  = clickstream_logs_handling_dag()