-- Rule 1: Delivered orders should have at least one payment
select
    'Delivered order has no payment' as failed_rule,
    o.order_id,
    o.order_status,
    null::number as payment_value,
    null::number as payment_installments

from {{ ref('stg_orders') }} o

left join {{ ref('stg_payments') }} p
    on o.order_id = p.order_id

where o.order_status = 'delivered'
  and p.order_id is null

union all

-- Rule 2: Payment amount should be positive
select
    'Non-positive payment amount' as failed_rule,
    order_id,
    null as order_status,
    payment_value,
    payment_installments

from {{ ref('stg_payments') }}

where payment_value <= 0

union all

-- Rule 3: Payment installments should be at least 1
select
    'Invalid payment installments' as failed_rule,
    order_id,
    null as order_status,
    payment_value,
    payment_installments

from {{ ref('stg_payments') }}

where payment_installments < 1