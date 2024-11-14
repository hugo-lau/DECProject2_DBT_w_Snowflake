
select
{{ dbt_utils.generate_surrogate_key(['customer.customer_id']) }} as customer_key,
concat(first_name, ' ', last_name) as customer_name,
Email as customer_email, 
Active as customer_active,
city.city,
country.country
from  {{ ref('customer') }} 
inner join {{ ref('address') }} as address on address.address_id = customer.address_id
inner join {{ ref('city') }} as city on city.city_id = address.city_id
inner join {{ ref('country') }} as country on country.country_id = city.country_id