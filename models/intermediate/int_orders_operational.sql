with orders_margin as (

    select *
    from {{ ref('int_orders_margin') }}

),

ship as (

    select
        orders_id,
        shipping_fee,
        logCost as log_cost,
        safe_cast(ship_cost as float64) as ship_cost
    from {{ ref('stg_raw_ship') }}

)

select
    o.orders_id,
    o.date_date,

    o.margin
        + s.shipping_fee
        - s.log_cost
        - s.ship_cost
        as operational_margin

from orders_margin o
left join ship s
    on o.orders_id = s.orders_id
