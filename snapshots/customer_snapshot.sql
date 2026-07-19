{% snapshot customer_snapshot %}

{{
    config(
        target_schema='snapshots',
        unique_key='customer_id',
        strategy='check',
        check_cols=[
            'city',
            'state'
        ]
    )
}}

select
    customer_id,
    customer_unique_id,
    city,
    state
from {{ ref('stg_customers') }}

{% endsnapshot %}