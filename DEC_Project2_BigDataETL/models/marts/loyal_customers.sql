{{
    config(
        materialized="table"
    )
}}


WITH customer_rentals AS (
    SELECT
        r.customer_id,
        COUNT(r.rental_id) AS rental_count
    FROM
        {{ ref('rental') }} r
    WHERE
        r.rental_date >= '2005-01-01'
        AND r.rental_date < '2006-01-01'
    GROUP BY
        r.customer_id
),
ranked_customers AS (
    SELECT
        cr.customer_id,
        c.first_name,
        c.last_name,
        cr.rental_count,
        ROW_NUMBER() OVER (ORDER BY cr.rental_count DESC) AS rental_rank
    FROM
        customer_rentals cr
    JOIN
        {{ ref('customer') }} c ON cr.customer_id = c.customer_id
)
SELECT
    customer_id,
    concat(first_name, ' ', last_name) as customer_name,
    rental_count
FROM
    ranked_customers
WHERE
    rental_rank <= 10
ORDER BY
    rental_rank