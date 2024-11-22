create table age_group as

select age_group, 

ROW_NUMBER() 

OVER(order by (

case when age_group = '18-34' then 0 

when age_group = '35-49' then 1

when age_group = '50-64' then 2

when age_group = '65-79' then 3

when age_group = '>80' then 4

else 5 end)) as id

from 

(select distinct(age_group) from diabetes)