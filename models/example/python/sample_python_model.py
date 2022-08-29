import pandas as pd
import numpy as np

def model(dbt, session):

    # dbt.config(materialized="table")


    df = pd.DataFrame(np.random.randn(100, 4), columns=list('ABCD'))


    return df