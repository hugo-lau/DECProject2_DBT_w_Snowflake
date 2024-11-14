{{
    config(
        materialized="table"
    )
}}
WITH new_releases AS (
    -- Identify new releases based on the release year
    SELECT
        f.film_id,
        f.release_year
    FROM {{ ref('film') }} f
    WHERE f.release_year = 2006
),
rental_activity AS (
    -- Get rental activity for the new releases
    SELECT
        r.rental_date,
        i.film_id,
        COUNT(*) AS rental_count
    FROM {{ ref('rental') }} r
    JOIN {{ ref('inventory') }} i ON r.inventory_id = i.inventory_id
    JOIN new_releases nr ON i.film_id = nr.film_id
    GROUP BY i.film_id, r.rental_date
),
before_after_release AS (
    -- Categorize rentals before and after the release date
    SELECT
        ra.film_id,
        ra.rental_date,
        ra.rental_count,
        CASE
            WHEN ra.rental_date < TO_DATE('2006-01-01', 'YYYY-MM-DD') THEN 'before_release'
            ELSE 'after_release'
        END AS release_period
    FROM rental_activity ra
)
-- Compare rentals before and after the release of new films
SELECT
    release_period,
    SUM(rental_count) AS total_rentals
FROM before_after_release
GROUP BY release_period
ORDER BY release_period