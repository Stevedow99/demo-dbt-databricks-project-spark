{% macro add_rows_to_incremental_sample() -%}
    INSERT INTO steve_d_raw_data.sample_incremental_table (
    select
        (rand()*100) as row_id,
        'tst' as system_name,
        current_timestamp() as time_added_to_table,
        1 as a_new_column_one,
        2 as a_new_column_two,
        3 as a_new_column_three,
        4 as a_new_column_four,
        5 as a_new_column_five,
        6 as a_new_column_six
)
{%- endmacro %}