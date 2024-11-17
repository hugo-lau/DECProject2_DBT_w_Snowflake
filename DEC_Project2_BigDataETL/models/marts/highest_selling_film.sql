--highest_selling_actor.sql
{{
    config(
        materialized="table"
    )
}}
select
    film.title,
    SUM(payment.amount) AS total_revenue
from {{ ref('payment') }} as payment
inner join {{ ref('rental') }} as rental on payment.rental_id = rental.rental_id
inner join {{ ref('inventory') }} as inventory on rental.inventory_id = inventory.inventory_id
inner join {{ ref('film') }} as film on inventory.film_id = film.film_id
--inner join {{ ref('film_actor') }} as film_actor on film.film_id = film_actor.film_id
--inner join {{ ref('actor') }} as actor on film_actor.actor_id = actor.actor_id
group by film.title
order by total_revenue desc
limit 10