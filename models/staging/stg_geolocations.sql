{{ config(
    materialized='incremental',
    unique_key=['geolocation_zip_code_prefix','geolocation_lat','geolocation_lng'],
    incremental_strategy='delete+insert'
) }}

select

    geolocation_zip_code_prefix,
    geolocation_lat,
    geolocation_lng,
    geolocation_city,
    geolocation_state

from {{ source('raw','geolocation') }}

{% if is_incremental() %}

where geolocation_zip_code_prefix not in (
    select distinct geolocation_zip_code_prefix
    from {{ this }}
)

{% endif %}