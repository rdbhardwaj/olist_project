{% macro clean_text(column_name) %}

coalesce(
    trim({{ column_name }}),
    'Unknown'
)

{% endmacro %}