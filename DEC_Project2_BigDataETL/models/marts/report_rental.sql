--one big table

select
    {{ dbt_utils.star(from=ref('fact_payment'), relation_alias='fact_payment', except=[
        "payment_key", "customer_key", "film_key", "staff_key"
    ]) }},
    {{ dbt_utils.star(from=ref('dim_film'), relation_alias='dim_film', except=["film_key"]) }},
    {{ dbt_utils.star(from=ref('dim_customer'), relation_alias='dim_customer', except=["customer_key"]) }},
    {{ dbt_utils.star(from=ref('dim_store'), relation_alias='dim_store', except=["staff_key"]) }},
    {{ dbt_utils.star(from=ref('dim_date'), relation_alias='dim_date', except=["date_day"]) }}
from {{ ref('fact_payment') }} as fact_payment
left join {{ ref('dim_film') }} as dim_film on fact_payment.film_key = dim_film.film_key
left join {{ ref('dim_customer') }} as dim_customer on fact_payment.customer_key = dim_customer.customer_key
left join {{ ref('dim_store') }} as dim_store on fact_payment.staff_key = dim_store.staff_key
left join {{ ref('dim_date') }} as dim_date on fact_payment.payment_date = dim_date.date_day
left join {{ ref('dim_date') }} as dim_date_r on fact_payment.rental_date = dim_date_r.date_day