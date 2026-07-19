{{ config(materialized='view') }}

select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix as zip_code_prefix,
    {{ clean_text('customer_city') }} as city,
    {{ clean_text('customer_state') }} as state,
from {{ source('raw', 'customers') }}