{{ config(materialized='table') }}

with base as (

    select *
    from {{ ref('finance_campaigns_day') }}

),

monthly as (

    select
        date_trunc(date, month) as datemonth,
        sum(ads_margin) as ads_margin,
        sum(operational_margin) as operational_margin,
        sum(ads_cost) as ads_cost,
        sum(ads_impressions) as ads_impressions,
        sum(ads_clicks) as ads_clicks,
        sum(quantity) as quantity,
        sum(revenue) as revenue,
        sum(purchase_cost) as purchase_cost,
        sum(margin) as margin,
        sum(shipping_fee) as shipping_fee,
        sum(log_cost) as log_cost,
        sum(shipping_fee) as ship_cost,

        safe_divide(sum(revenue), sum(quantity)) as average_basket

    from base
    group by 1

)

select *
from monthly
order by datemonth desc
