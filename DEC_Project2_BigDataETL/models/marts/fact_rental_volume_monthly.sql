select
    {{ dbt_utils.generate_surrogate_key(["date.month_end_date", "film_key"]) }} as rental_monthly_key,
    date.month_end_date as rental_month_end_date,
    film_key,
    count(rental_id) as rental_volume
from {{ ref('fact_payment') }} as fact_payment
--inner join {{ ref('dim_customer') }} as dim_customer on fact_payment.customer_key = dim_customer.customer_key
inner join {{ ref('dim_date') }} as date on fact_payment.rental_date = date.date_day
group by
    date.month_end_date, film_key