{% macro do_schmea_change() -%}

    {% set source_table_query %}

        DESCRIBE QUERY (SELECT * FROM steve_d_raw_data.sample_incremental_table_b)

    {% endset %}


    {% set target_table_query %}

        DESCRIBE QUERY (SELECT * FROM steve_d_raw_data.sample_incremental_table_a)

    {% endset %}


    {% if execute %}

        {% set source_table_results = run_query(source_table_query).columns[0] %}

        {% set target_table_results = run_query(target_table_query) %}


    {% else %}

        {% set source_table_results = [] %}

        {% set target_table_results = [] %}

        {% set was_there_an_execute = '1' %}

    {% endif %}


    {% set something_rand = (source_table_results) %}

    {{ log("LOOOOOOOOOGSS!!!!!!:    " ~ something_rand ) }}
    {{ log("LOOOOOOOOOGSS!!!!!!:    " ~ something_rand ) }}

    SELECT 1

{%- endmacro %}







