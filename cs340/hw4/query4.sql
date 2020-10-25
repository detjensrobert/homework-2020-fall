-- Find the actor_id, first_name and last_name of all actors who have never been in a Sci-Fi film.
-- Order by the actor_id in ascending order.
-- Put your query for Q4 here

select `actor_id`, `first_name`, `last_name` from `actor`
where `actor_id` not in (
  -- find actors who _have_ been in a scifi movie
  select FA.`actor_id`
  from `film_actor` FA, `film_category` FC, `category` C
  where FA.`film_id` = FC.`film_id`
    and FC.`category_id` = C.`category_id`
    and C.`name` = 'Sci-Fi'
)
order by `actor_id` ASC;
