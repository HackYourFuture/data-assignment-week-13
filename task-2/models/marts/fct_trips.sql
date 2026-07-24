{{ config(
    materialized='incremental',
    incremental_strategy='merge',
    unique_key='trip_id'
) }}

select
    trip_id,
    vendor_id,
    pickup_datetime,
    dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_location_id,
    dropoff_location_id,
    fare_amount,
    total_amount
from {{ ref('stg_trips') }}

{% if is_incremental() %}
    where pickup_datetime > (select max(pickup_datetime) from {{ this }})
{% endif %}
