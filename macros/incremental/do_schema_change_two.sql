{% macro do_schmea_change_two(source_table) -%}

{# ######################################################################################## #}
{# query to get the schema of the source table #}
{# ######################################################################################## #}

    {% set source_table_query %}

        DESCRIBE QUERY (SELECT * FROM {{ source_table }} LIMIT 10)

    {% endset %}

{# ######################################################################################## #}
{# query to get the schema of the target table #}
{# ######################################################################################## #}


    {% set target_table_query %}

        DESCRIBE QUERY (SELECT * FROM {{ this.schema }}.{{ this.table }}  LIMIT 10)

    {% endset %}

{# ######################################################################################## #}
{# if this get executed, running the queries and continuing the workflow #}
{# ######################################################################################## #}

    {% if execute %}

        {% set source_table_results = run_query(source_table_query) %}

        {% set target_table_results = run_query(target_table_query) %}

        {# ######################################################################################## #}
        {# creating a list that will contain all the net new columns in source but not in target #}
        {# ######################################################################################## #}

        {% set net_new_columns = [] %}

        {# ######################################################################################## #}
        {# looping thru all columns in source table and checking if they are in target table #}
        {# ######################################################################################## #}

        {% for row_entry in source_table_results %}
            
            {# check each column in source to see if it is in target table #}

            {% if row_entry.values()[0] not in target_table_results.columns[0].values() %}

                {# if it is not in target table, we add it to our list #}

                {% do net_new_columns.append((row_entry.values()[0],row_entry.values()[1])) %}

            {% endif %}

        {% endfor %}

        {# #################################################################################################### #}
        {# looping thru all net new columns and adding them to our target table - assuming there is new columns #}
        {# #################################################################################################### #}

        {% if net_new_columns|length > 0 %}

            {% for new_column in net_new_columns %}

                {# creating the alter table statement we are going to pass down to the data warehouse #}

                {% set alter_table_query = "ALTER TABLE " ~ this.schema ~ "." ~ this.table ~ " " ~ "ADD COLUMNS ( " ~ new_column[0] ~ " " ~ new_column[1]~")" %}

                {# passing the alter table statement down to the data warehouse #}

                {% set alter_table_results = run_query(alter_table_query) %}

                {# log_output the result of the alter statement #}

                {{ log("A column mismatch was found between the source and target tables, an alter table statment was passed down to the data warehouse to address this" ) }}
                {{ log("The output from the warehouse alter table statement is the following: " ~ alter_table_results.columns[0].values() ) }}

            {% endfor %}

        {% else %}

            {# no new columns in the source table, no need to update the target table, so we log this#}
            {{ log("Source and Target table have the same schema, no need for alter table statement" ) }}

        {% endif %}

    {% endif %}

{%- endmacro %}