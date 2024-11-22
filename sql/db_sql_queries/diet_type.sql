create table diet_type as

select diet_type, ROW_NUMBER() OVER(order by diet_type) as id

from 

(select distinct(diet_type) from diabetes)


