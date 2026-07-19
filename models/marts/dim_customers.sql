{{ config(
    materialized='incremental',
    unique_key='customer_id'
) }}

select
    c.customer_id,
    c.customer_unique_id,
    c.city,
    c.state,
    sm.state_name as customer_state_name

from {{ ref('stg_customers') }} c

left join {{ ref('state_mapping') }} sm
    on c.state = sm.state_code

{% if is_incremental() %}
where c.customer_id not in (
    select customer_id
    from {{ this }}
)
{% endif %}