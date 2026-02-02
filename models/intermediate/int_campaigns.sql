with adwords as (

    select * from {{ ref('stg_adwords') }}

),

bing as (

    select * from {{ ref('stg_bing') }}

),

criteo as (

    select * from {{ ref('stg_criteo') }}

),

facebook as (

    select * from {{ ref('stg_facebook') }}

)

select * from adwords
union all
select * from bing
union all
select * from criteo
union all
select * from facebook
