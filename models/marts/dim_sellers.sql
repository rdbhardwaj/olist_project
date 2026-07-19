{{ config(
    materialized='incremental',
    unique_key='seller_id'
) }}

select
    s.seller_id,
    s.seller_city,
    s.seller_state,
    sm.state_name as seller_state_name

from {{ ref('stg_sellers') }} s

left join {{ ref('state_mapping') }} sm
    on s.seller_state = sm.state_code

{% if is_incremental() %}
where s.seller_id not in (
    select seller_id
    from {{ this }}
)
{% endif %}