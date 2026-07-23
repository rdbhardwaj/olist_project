{{ config(
    materialized='incremental',
    unique_key='review_id',
    incremental_strategy='delete+insert'
) }}

select

    review_id,
    order_id,
    review_score,
    review_comment_title,
    review_comment_message,
    review_creation_date,
    review_answer_timestamp

from {{ source('raw','reviews') }}

{% if is_incremental() %}

where review_id not in (
    select review_id
    from {{ this }}
)

{% endif %}