{{ config(
    materialized='incremental',
    unique_key=['order_id','payment_sequential'],
    incremental_strategy='delete+insert'
) }}

select

    order_id,
    payment_sequential,
    payment_type,
    payment_installments,
    payment_value

from {{ source('raw','payments') }}

{% if is_incremental() %}

where order_id not in (
    select distinct order_id
    from {{ this }}
)

{% endif %}