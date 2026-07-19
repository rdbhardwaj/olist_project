-- Business Rule:
-- Every delivered order should have a customer delivery date.
--
-- Note:
-- The Olist dataset contains 8 source records that violate this rule.
-- This test intentionally highlights those source data quality issues.


-- Rule 1: Delivered orders should have order items
select
    'Delivered order has no items' as failed_rule,
    o.order_id,
    o.order_status
from OLIST_DB.STAGING.STG_ORDERS o
left join OLIST_DB.STAGING.STG_ORDER_ITEMS oi
    on o.order_id = oi.order_id
where o.order_status = 'delivered'
  and oi.order_id is null

union all

-- Rule 2: Delivered orders should have delivery date
select
    'Delivered order missing delivery date' as failed_rule,
    order_id,
    order_status
from OLIST_DB.STAGING.STG_ORDERS
where order_status = 'delivered'
  and delivered_customer_date is null

union all

-- Rule 3: Delivery before purchase
select
    'Delivery before purchase' as failed_rule,
    order_id,
    order_status
from OLIST_DB.STAGING.STG_ORDERS
where delivered_customer_date < purchase_timestamp

union all

-- Rule 4: Estimated delivery before purchase
select
    'Estimated delivery before purchase' as failed_rule,
    order_id,
    order_status
from OLIST_DB.STAGING.STG_ORDERS
where estimated_delivery_date < purchase_timestamp