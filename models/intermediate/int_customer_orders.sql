{{ config(
    materialized='view'
) }}

select

    o.order_id,

    o.customer_id,

    c.customer_unique_id,

    c.city,

    c.state,

    o.order_status,

    o.purchase_timestamp,

    o.approved_at,

    o.delivered_carrier_date,

    o.delivered_customer_date,

    o.estimated_delivery_date

from {{ ref('stg_orders') }} o

left join {{ ref('stg_customers') }} c

    on o.customer_id = c.customer_id