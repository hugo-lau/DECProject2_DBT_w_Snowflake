--month_with_highest_rentals
{{
    config(
        materialized="table"
    )
}}
WITH rental_counts AS (
    SELECT
        DATE_PART('month', rental_date) AS rental_month_num,
        TRIM(TO_CHAR(rental_date, 'Mon-YYYY')) AS rental_month_name,
        COUNT(*) AS rental_count
    FROM {{ ref('rental') }}
    --WHERE DATE_PART('year', rental_date) = 2006
    GROUP BY DATE_PART('month', rental_date), TRIM(TO_CHAR(rental_date, 'Mon-YYYY'))
)
-- Get the highest rental month
SELECT rental_month_name, rental_count
FROM rental_counts
ORDER BY rental_count DESC
LIMIT 10