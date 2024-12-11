{{ config(materialized = 'view') }}

WITH gz_campaigns_day as (SELECT * FROM {{ ref("int_campaigns_day") }}),
gz_finance_days as (SELECT * FROM {{ ref("finance_days") }})

SELECT 
gz_campaigns_day.date_date,
ROUND((gz_finance_days.operational_margin - gz_campaigns_day.ads_cost), 1) AS ads_margin,
gz_finance_days.average_basket,
gz_finance_days.operational_margin,
gz_campaigns_day.ads_cost,
gz_campaigns_day.ads_impression,
gz_campaigns_day.ads_clicks,
gz_finance_days.quantity,
gz_finance_days.revenue,
gz_finance_days.purchase_cost,
gz_finance_days.margin,
gz_finance_days.shipping_fee,
gz_finance_days.logcost,
gz_finance_days.ship_cost

FROM gz_campaigns_day

JOIN gz_finance_days
on gz_finance_days.date_date = gz_campaigns_day.date_date

