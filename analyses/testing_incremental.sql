SELECT 
    *,
    'raw data' as model
FROM steve_d_raw_data.sample_incremental_table 

UNION ALL

SELECT 
    *,
    'incremental model' as model
FROM {{ ref('incremental_model') }}