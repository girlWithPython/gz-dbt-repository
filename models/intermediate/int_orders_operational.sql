--{{ config(materialized = 'table') }}

WITH clean_gz_ship as (SELECT * FROM {{ ref("stg_raw__ship") }}),
gz_margin as (SELECT * FROM {{ ref("int_orders_margin") }})

SELECT 
gz_margin.orders_id,
gz_margin.date_date,
ROUND(SUM(ROUND((gz_margin.margin + clean_gz_ship.shipping_fee - clean_gz_ship.ship_cost - clean_gz_ship.logcost), 2)), 2) AS operational_margin,
ROUND(SUM(gz_margin.revenue), 2) as revenue,
ROUND(SUM(gz_margin.purchase_cost), 2) as purchase_cost,
ROUND(SUM(gz_margin.quantity), 2) as quantity,
ROUND(SUM(gz_margin.margin), 2) as margin,
ROUND(SUM(clean_gz_ship.shipping_fee), 2) as shipping_fee,
ROUND(SUM(clean_gz_ship.logcost), 2) as logcost,
ROUND(SUM(clean_gz_ship.ship_cost), 2) as ship_cost,

FROM gz_margin

JOIN clean_gz_ship 
on clean_gz_ship.orders_id = gz_margin.orders_id

GROUP BY 
gz_margin.orders_id, 
gz_margin.date_date