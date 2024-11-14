select
{{ dbt_utils.generate_surrogate_key(['staff.staff_id']) }} as staff_key,
concat(staff.first_name, ' ', staff.last_name) as staff_name,
active as staff_active,
store.store_id,
address.address as store_address,
city.city as store_city,
country.country as store_country
from {{ ref('staff') }} as staff
inner join {{ ref('store') }} as store on store.store_id = staff.store_id
inner join {{ ref('address') }} as address on address.address_id = store.address_id
inner join {{ ref('city') }} as city on city.city_id = address.city_id
inner join {{ ref('country') }} as country on country.country_id = city.country_id

