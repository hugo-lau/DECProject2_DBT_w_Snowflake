select
    fact_sale."SALES_KEY",
    fact_sale."ORDERDATE",
    fact_sale."SALESORDERID",
    fact_sale."SALESORDERDETAILID",
    fact_sale."UNITPRICE",
    fact_sale."ORDERQTY",
    fact_sale."REVENUE",
    dim_product."PRODUCT_KEY", -- Example column from dim_product
    dim_customer."CUSTOMERID",
    dim_customer."PERSONBUSINESSENTITYID",
    dim_credit_card."CARDTYPE",
    dim_address."ADDRESS_ID",
    dim_order_status."ORDER_STATUS",
    dim_date."PRIOR_DATE_DAY"
from {{ ref('fact_sale') }} as fact_sale
left join {{ ref('dim_product') }} as dim_product on fact_sale.product_key = dim_product.product_key
left join {{ ref('dim_customer') }} as dim_customer on fact_sale.customer_key = dim_customer.customer_key
left join {{ ref('dim_credit_card') }} as dim_credit_card on fact_sale.creditcard_key = dim_credit_card.creditcard_key
left join {{ ref('dim_address') }} as dim_address on fact_sale.ship_address_key = dim_address.address_key
left join {{ ref('dim_order_status') }} as dim_order_status on fact_sale.order_status_key = dim_order_status.order_status_key
left join {{ ref('dim_date') }} as dim_date on fact_sale.orderdate = dim_date.date_day
