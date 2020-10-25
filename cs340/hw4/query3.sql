-- Find the actor_id first_name, last_name and total_combined_film_length
-- of Sci-Fi films for every actor.
-- That is the result should list the actor ids, names of all of the actors(even if an actor has not been in any Sci-Fi films)
-- and the total length of Sci-Fi films they have been in.
-- Look at the category table to figure out how to filter data for Sci-Fi films.
-- Order your results by the actor_id in descending order.
-- Put query for Q3 here

select A.`actor_id`, A.`first_name`, A.`last_name`, sum(
  case when FC.`category_id` = '14' then F.`length` else 0 end
) as `total_combined_film_length`
from `actor` A, `film_actor` FA, `film` F, `film_category` FC
where A.`actor_id` = FA.`actor_id`
  and FA.`film_id` = F.`film_id`
  and F.`film_id` = FC.`film_id`
group by A.`actor_id`
order by A.`actor_id` DESC;
