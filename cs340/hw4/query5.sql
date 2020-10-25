-- Find the film_title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
-- Order the results by film_title in descending order.

select F.`title` as `film_title`
from `film` F, `film_actor` FA1, `film_actor` FA2, `actor` A1, `actor` A2
where F.`film_id` = FA1.`film_id`
  and FA1.`actor_id` = A1.`actor_id`
  and A1.`first_name` = 'KIRSTEN' and A1.`last_name` = 'PALTROW'
  and F.`film_id` = FA2.`film_id`
  and FA2.`actor_id` = A2.`actor_id`
  and A2.`first_name` = 'WARREN' and A2.`last_name` = 'NOLTE'
order by `film_title` DESC;
