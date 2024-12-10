With clean_gz_product as (SELECT * from {{ ref("stg_raw__product") }})

#select clean_gz_product.purchase_price, clean_gz_sales.quantity
select 
clean_gz_sales.orders_id,
clean_gz_sales.date_date,
clean_gz_sales.revenue,
clean_gz_sales.quantity,
(CAST(clean_gz_product.purchase_price AS FLOAT64)) * clean_gz_sales.quantity as purchase_cost,
round(clean_gz_sales.revenue - (CAST(clean_gz_product.purchase_price AS FLOAT64)) * clean_gz_sales.quantity, 2) as margin

FROM {{ ref("stg_raw__sales") }} as clean_gz_sales

JOIN clean_gz_product 
on clean_gz_product.products_id = clean_gz_sales.products_id