{{ config(
    materialized='table'
) }}

select
    p.product_id,
    {{ clean_text('p.product_category_name') }} as product_category_name,
    ct.product_category_name_english,
    p.product_weight_g,
    p.product_length_cm,
    p.product_height_cm,
    p.product_width_cm

from {{ ref('stg_products') }} p

left join {{ ref('stg_category_translations') }} ct
    on p.product_category_name = ct.product_category_name
left join {{ ref('category_groups') }} cg
    on ct.product_category_name_english = cg.product_category_name_english