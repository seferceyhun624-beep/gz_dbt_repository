with base as (

    select *
    from {{ ref('int_orders_operational') }}

)

select
    date_date,

    count(distinct orders_id) as total_orders,

    sum(revenue) as total_revenue,

    sum(revenue) / count(distinct orders_id) as avg_basket,

    sum(operational_margin) as total_operational_margin,

    sum(purchase_cost) as total_purchase_cost,

    sum(shipping_fee) as total_shipping_fees,

    sum(log_cost + ship_cost) as total_logistics_cost,

    sum(quantity) as total_quantity_sold

from base
group by date_date
