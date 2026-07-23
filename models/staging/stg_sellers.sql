{{ config(
    materialized='incremental',
    unique_key='seller_id',
    incremental_strategy='delete+insert'
) }}

select

    seller_id,
    seller_zip_code_prefix,
    seller_city,
    seller_state

from {{ source('raw','sellers') }}

{% if is_incremental() %}

where seller_id not in (
    select seller_id
    from {{ this }}
)

{% endif %}