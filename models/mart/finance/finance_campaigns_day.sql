{{ config(materialized='table') }}

with finance as (

    select
        date_date,
        total_orders,
        total_revenue,
        avg_basket,
        total_operational_margin,
        total_purchase_cost,
        total_shipping_fees,
        total_logistics_cost,
        total_quantity_sold
    from {{ ref('finance_days') }}

),

campaigns as (

    select
        date_date,
        ads_cost,
        ads_impressions,
        ads_clicks
    from {{ ref('int_campaigns_day') }}

)

select
    f.date_date as date,
    f.total_orders as orders,
    f.total_revenue as revenue,
    f.avg_basket as average_basket,
    f.total_operational_margin as operational_margin,
    f.total_purchase_cost as purchase_cost,
    f.total_shipping_fees as shipping_fee,
    f.total_logistics_cost as log_cost,
    f.total_quantity_sold as quantity,
    (f.total_revenue - f.total_purchase_cost) as margin,
    coalesce(c.ads_cost, 0) as ads_cost,
    coalesce(c.ads_impressions, 0) as ads_impressions,
    coalesce(c.ads_clicks, 0) as ads_clicks,
    f.total_operational_margin - coalesce(c.ads_cost, 0) as ads_margin

from finance f
left join campaigns c
  on f.date_date = c.date_date
order by f.date_date desc

