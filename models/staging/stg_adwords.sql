with source as (

    select *
    from {{ source('raw', 'adwords') }}

)

select
    date_date,
    paid_source,
    campaign_key,
    camPGN_name as campaign_name,
    cast(ads_cost as float64) as ads_cost,
    impression,
    click

from source
