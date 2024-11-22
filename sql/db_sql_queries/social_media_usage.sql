create table social_media_usage as

select social_media_usage, 

ROW_NUMBER() 

OVER(order by (

case when social_media_usage = 'Unknown' then 0 

when social_media_usage = 'Never' then 1

when social_media_usage = 'Occasionally' then 2

when social_media_usage = 'Moderate' then 3

when social_media_usage = 'Excessive' then 4

else 5 end)) as id

from 

(select distinct(social_media_usage) from diabetes)