{{
    config(
        materialized="table"
    )
}}

select
    language_id,
    trim(name) as name,
    last_update
from {{ source('dvd_rental', 'language') }}
