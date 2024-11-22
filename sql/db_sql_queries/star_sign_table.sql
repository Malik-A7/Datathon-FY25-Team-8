create table star_sign as 

select star_sign, 

ROW_NUMBER() OVER(order by (case when star_sign = 'Unknown' then 0 else 1 end))

from 

(select distinct(star_sign) from diabetes)