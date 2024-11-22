create table physical_activity_level as

select physical_activity_level, 

ROW_NUMBER() 

OVER(order by (

case when physical_activity_level = 'Unknown' then 0 

when physical_activity_level = 'Sedentary' then 1

when physical_activity_level = 'Lightly Active' then 2

when physical_activity_level = 'Moderately Active' then 3

when physical_activity_level = 'Very Active' then 4

when physical_activity_level = 'Extremely Active' then 5

else 6 end)) as id

from 

(select distinct(physical_activity_level) from diabetes)