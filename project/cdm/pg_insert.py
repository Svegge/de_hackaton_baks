"""TBD"""
import os
from pathlib import Path

def insert_data(pg_hook, log) -> None:
    """TBD"""
    path_to_scripts = '/lessons/project/cdm/sql'
    files = os.listdir(path_to_scripts)
    file_paths = [Path(path_to_scripts, f) for f in files]
    file_paths.sort(key=lambda x: x.name)

    log.info(f"Found {len(file_paths)} files to apply changes.")

    i = 1
    for file_path in file_paths:
        log.info(f"Iteration {i}. Applying file {file_path.name}")
        script = file_path.read_text()

        with pg_hook.get_conn() as conn:
            with conn.cursor() as cur:
                cur.execute(script)

        log.info(f"Iteration {i}. File {file_path.name} executed successfully.")
        i += 1