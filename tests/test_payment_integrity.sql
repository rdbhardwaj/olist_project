/*
Business Rule:
Every delivered order should have at least one payment record.

Exception:
The Olist source dataset contains one delivered order with no payment record.
Since this is a known source data inconsistency, it is excluded from validation.
*/

select
    o.order_id,
    o.order_status

from {{ ref('stg_orders') }} o

left join {{ ref('stg_payments') }} p
    on o.order_id = p.order_id

where o.order_status = 'delivered'
  and p.order_id is null
  and o.order_id <> 'bfbd0f9bdef84302105ad712db648a6c'