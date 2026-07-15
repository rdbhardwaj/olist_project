{{ config(materialized='view') }}

select

    order_id,

    avg(review_score) as avg_review_score,

    count(*) as total_reviews

from {{ ref('stg_reviews') }}

group by order_id