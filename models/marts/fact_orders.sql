{{ config(
    materialized='incremental',
    unique_key=['order_id','order_item_id'],
    incremental_strategy='delete+insert'
) }}

select

    ----------------------------------------------------
    -- Keys
    ----------------------------------------------------
    od.order_id,
    od.order_item_id,
    co.customer_id,
    od.product_id,
    od.seller_id,

    ----------------------------------------------------
    -- Order Information
    ----------------------------------------------------
    co.order_status,
    co.purchase_timestamp,
    co.delivered_customer_date,
    co.estimated_delivery_date,

    ----------------------------------------------------
    -- Sales Metrics
    ----------------------------------------------------
    od.price,
    od.freight_value,
    (od.price + od.freight_value) as total_order_value,

    ----------------------------------------------------
    -- Payment Metrics
    ----------------------------------------------------
    ps.total_payment,
    ps.payment_count,
    ps.max_installments,

    ----------------------------------------------------
    -- Review Metrics
    ----------------------------------------------------
    rs.avg_review_score,

    {{ target.database }}.{{ target.schema }}.review_category(rs.avg_review_score)
        as review_category,

    rs.total_reviews

from {{ ref('int_order_details') }} od

left join {{ ref('int_customer_orders') }} co
    on od.order_id = co.order_id

left join {{ ref('int_payments_summary') }} ps
    on od.order_id = ps.order_id

left join {{ ref('int_reviews_summary') }} rs
    on od.order_id = rs.order_id

{% if is_incremental() %}

where co.purchase_timestamp >= (
    select dateadd(day,-2,max(purchase_timestamp))
    from {{ this }}
)

{% endif %}