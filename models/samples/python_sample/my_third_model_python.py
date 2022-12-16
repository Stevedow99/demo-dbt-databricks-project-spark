# importing packages
import random
from pyspark.sql.functions import lit

def model(dbt, session):

    # DataFrame representing an upstream model
    upstream_model = dbt.ref("my_second_model")

    # DataFrame representing an upstream source
    new_df = upstream_model.withColumn("random_number", lit(random.randrange(20, 50, 3)))

    # returning the df which will get built
    return new_df