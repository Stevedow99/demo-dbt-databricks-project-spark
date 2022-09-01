import pandas as pd
import numpy as np

def model(dbt, session):

    dbt.config(materialized='table')

    base_model = pd.DataFrame(np.random.randn(100, 4), columns=list('ABCD'))

    return base_model