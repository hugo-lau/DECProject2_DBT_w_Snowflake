--one big table for periodic snapshot fact table - fact rental vol monthly

select
    {{ dbt_utils.star(from=ref('fact_rental_volume_monthly'), relation_alias='fact_rental_volume_monthly', except=[
        "rental_monthly_key"
    ]) }},
    {{ dbt_utils.star(from=ref('dim_film'), relation_alias='dim_film', except=["film_key"]) }}
    
from {{ ref('fact_rental_volume_monthly') }} as fact_rental_volume_monthly
left join {{ ref('dim_film') }} as dim_film on fact_rental_volume_monthly.film_key = dim_film.film_key




