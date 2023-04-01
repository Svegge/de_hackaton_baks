import pandas as pd


def load_pg_stg(file:str, table:str, schema:str, pg_hook)-> None:
    """Loads data from file to stg schema"""
    df = pd.read_json(file)
    engine = pg_hook.get_sqlalchemy_engine() 
    row_count = df.to_sql(table, engine, schema=schema, if_exists='replace', index=False)
