 {% macro margin_percent(revenue, purchase_cost, dp=2) %}
    ROUND((SAFE_DIVIDE((revenue - purchase_cost), revenue)), {{ dp }} )
 {% endmacro %}

 {% macro create_combined_column(col1, col2) %}
    concat({{col1}}, '-', {{col2}})
 {% endmacro %}