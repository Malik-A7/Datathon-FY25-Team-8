create table stress_level as

select stress_level, 

ROW_NUMBER() 

OVER(order by (

case when stress_level = 'Unknown' then 0 

when stress_level = 'Low' then 1

when stress_level = 'Moderate' then 2

when stress_level = 'Elevated' then 3

when stress_level = 'Extreme' then 4

else 5 end)) as id

from 

(select distinct(stress_level) from diabetes)