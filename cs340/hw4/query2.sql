-- We want to find out how many of each category of film ED CHASE has starred in.

-- So return a table with "category_name" and the count of the "number_of_films" that ED was in that category.

-- Your query should return every category even if ED has been in no films in that category

-- Order by the category name in ascending order.

select C.`name` as `category_name`, count(A.`actor_id`) as `number_of_films`
from `category` C
left join `film_category` FC
  on C.`category_id` = FC.`category_id`
left join `film_actor` FA
  on FC.`film_id` = FA.`film_id`
left join `actor` A
  on FA.`actor_id` = A.`actor_id`
  and A.`actor_id` = 3
group by C.`category_id`
order by C.`name` ASC;
