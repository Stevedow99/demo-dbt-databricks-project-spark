{{
    config(
        materialized='incremental',
        on_schema_change = 'append_new_columns'
    )
    
}}

select
    *
   

from {{source('sample_data', 'sample_incremental_table')}}

{% if is_incremental() %}

  -- this filter will only be applied on an incremental run
  where time_added_to_table > (select max(time_added_to_table) from {{ this }})

{% endif %}