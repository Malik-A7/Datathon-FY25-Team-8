create table gender as


select gender, ROW_NUMBER() OVER(order by gender) as id

from 

(select distinct(gender) from diabetes)


