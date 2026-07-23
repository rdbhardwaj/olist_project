{{ config(
    materialized='incremental',
    unique_key='product_category_name',
    incremental_strategy='delete+insert'
) }}

select

    product_category_name,
    product_category_name_english

from {{ source('raw','category_translations') }}

{% if is_incremental() %}

where product_category_name not in (
    select product_category_name
    from {{ this }}
)

{% endif %}