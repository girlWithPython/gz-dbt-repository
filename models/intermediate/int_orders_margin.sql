--{{ config(materialized = 'table') }}

WITH sales_margin AS (SELECT * from {{ ref("int_sales_margin") }})

SELECT 
DISTINCT(date_date),
orders_id,
ROUND(SUM(revenue), 2) AS revenue,
SUM(quantity) AS quantity,
ROUND(SUM(purchase_cost), 2) AS purchase_cost,
ROUND(SUM(margin), 2) AS margin,

FROM sales_margin

GROUP BY 
orders_id,
date_date

ORDER BY
orders_id,
date_date