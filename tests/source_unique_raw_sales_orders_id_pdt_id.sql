select
  orders_id,
  pdt_id,
  count(*) as cnt
from {{ source('raw', 'sales') }}
group by 1, 2
having count(*) > 1
