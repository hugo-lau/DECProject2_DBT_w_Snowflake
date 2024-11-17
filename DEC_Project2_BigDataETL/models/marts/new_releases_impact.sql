{{
    config(
        materialized="table"
    )
}}
WITH new_releases AS (
    SELECT
        f.film_id,
        f.title
    FROM {{ ref('film') }} f
    WHERE f.release_year = 2006
),
rental_activity AS (
    SELECT
        i.film_id,
        DATE_TRUNC('month', r.rental_date) AS rental_month,
        COUNT(*) AS total_rentals
    FROM {{ ref('rental') }} r
    JOIN {{ ref('inventory') }} i ON r.inventory_id = i.inventory_id
    JOIN new_releases nr ON i.film_id = nr.film_id
    GROUP BY i.film_id, DATE_TRUNC('month', r.rental_date)
)
SELECT
    rental_month,
    SUM(total_rentals) AS total_rentals_all_films
FROM rental_activity
GROUP BY rental_month
ORDER BY rental_month