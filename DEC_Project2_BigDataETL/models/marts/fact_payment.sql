--Fact table reflects the rental & payment process which consists of 3 tables - payment, rental and inventory tables
--this allows us to create a star schema with one fact table and 3 dimensions (dim_customer, dim_film, dim_actor)
--payment table is the most granular

select
{{ dbt_utils.generate_surrogate_key(['payment.payment_id']) }} as payment_key,
{{ dbt_utils.generate_surrogate_key(['payment.customer_id']) }} as customer_key,
{{ dbt_utils.generate_surrogate_key(['inv.film_id']) }} as film_key,
{{ dbt_utils.generate_surrogate_key(['payment.staff_id']) }} as staff_key,
payment.rental_id, --for measuring rental volume
payment.amount as revenue,
date(payment.payment_date) as payment_date,
date(rental.rental_date) as rental_date
-- p.payment_id,
-- p.customer_id,
--inv.film_id

from {{ ref('payment') }} as payment
inner join {{ ref('rental') }} as rental on payment.rental_id = rental.rental_id
inner join {{ ref('inventory') }} as inv on rental.inventory_id = inv.inventory_id 
