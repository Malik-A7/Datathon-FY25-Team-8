create table alcohol_consumption as

select alcohol_consumption, 

ROW_NUMBER() 

OVER(order by (

case when alcohol_consumption = 'Unknown' then 0 

when alcohol_consumption = 'none' then 1

when alcohol_consumption = 'light' then 2

when alcohol_consumption = 'moderate' then 3

when alcohol_consumption = 'heavy' then 4

else 5 end)) as id

from 

(select distinct(alcohol_consumption) from diabetes)