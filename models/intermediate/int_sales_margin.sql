WITH 

purchase_cost_added as(
    SELECT 
    sales.*
    , ROUND((product.purchase_price * quantity), 2) as purchase_cost
    FROM {{ ref("stg_raw__sales") }} as sales
    LEFT JOIN
    {{ ref("stg_raw__product") }} as product
    USING
        (products_id)
)

SELECT 
    *
    , ROUND((revenue - purchase_cost), 2) AS margin
    , {{ margin_percent('revenue', 'purchase_cost') }} AS margin_percent
FROM purchase_cost_added