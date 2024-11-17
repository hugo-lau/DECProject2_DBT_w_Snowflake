 
select
{{ dbt_utils.generate_surrogate_key(['f.film_id']) }} as film_key,
f.title,
f.release_year,
f.length,
c.category_id,
c.name as category_name
--concat(a.first_name, ' ', a.last_name) as actor_name,
--fa.actor_id,
from {{ ref('film') }} f 
inner join {{ ref('film_category') }}  fc on f.film_id = fc.film_id
inner join {{ ref('category') }}  c on fc.category_id = c.category_id
--inner join {{ ref('film_actor') }} as fa on fa.film_id = f.film_id
--inner join {{ ref('actor') }} as a on a.actor_id = fa.actor_id