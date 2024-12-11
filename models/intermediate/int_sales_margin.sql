--{{ config(materialized = 'table') }}

WITH clean_gz_product AS (SELECT * from {{ ref("stg_raw__product") }}),
clean_gz_sales AS (SELECT * FROM {{ ref("stg_raw__sales") }})

SELECT 
clean_gz_sales.products_id,
clean_gz_sales.orders_id,
clean_gz_sales.date_date,
ROUND(SUM(clean_gz_sales.revenue), 2) AS revenue,
SUM(clean_gz_sales.quantity) AS quantity,
ROUND(SUM(ROUND(clean_gz_product.purchase_price * clean_gz_sales.quantity, 2)), 2) AS purchase_cost,
ROUND(SUM(ROUND(clean_gz_sales.revenue - clean_gz_product.purchase_price * clean_gz_sales.quantity, 2)), 2) AS margin,

FROM clean_gz_sales

JOIN clean_gz_product 
ON clean_gz_product.products_id = clean_gz_sales.products_id

GROUP BY 
clean_gz_sales.products_id,
clean_gz_sales.orders_id, 
clean_gz_sales.date_date