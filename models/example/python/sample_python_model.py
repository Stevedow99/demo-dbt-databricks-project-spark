import pandas as pd

def model(dbt, session):
    dbt.config(materialized='table', packages=['pandas'])
    upstream_model = dbt.ref('stg_tpch_customers')
    return upstream_model