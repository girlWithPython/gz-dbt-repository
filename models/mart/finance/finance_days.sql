--{{ config(materialized = 'table') }}

SELECT 
date_date,
COUNT(orders_id) as nb_transactions,
ROUND(SUM(revenue), 1) as revenue,
ROUND(ROUND(SUM(revenue), 2)/COUNT(orders_id), 1) as average_basket,
ROUND(SUM(purchase_cost), 2) as purchase_cost,
ROUND(SUM(margin), 1) as margin,
ROUND(SUM(operational_margin), 1) as operational_margin,
ROUND(SUM(quantity), 1) as quantity,
ROUND(SUM(shipping_fee), 1) as shipping_fee,
ROUND(SUM(logcost), 1) as logcost,
ROUND(SUM(ship_cost), 1) as ship_cost,

FROM {{ ref("int_orders_operational") }} as gz_operational

GROUP BY 
date_date