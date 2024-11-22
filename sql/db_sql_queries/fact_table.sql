create table fact_table as

select d.id, g.id as gender_id, hypertension, diabetes_pedigree_function, "BMI",
dt.id as diet_type_id, family_diabetes_history,
smu.id as social_media_usage_id, pal.id as physical_activity_level_id,
sleep_duration, sl.id as stress_level_id, pregnancies, ac.id as alcohol_consumption_id,
ag.id as age_group_id, weight, diabetes

from

diabetes d inner join gender g on d.gender = g.gender

inner join diet_type dt on d.diet_type = dt.diet_type

inner join social_media_usage smu on d.social_media_usage = smu.social_media_usage

inner join physical_activity_level pal on d.physical_activity_level = pal.physical_activity_level

inner join stress_level sl on d.stress_level = sl.stress_level

inner join age_group ag on d.age_group = ag.age_group

inner join alcohol_consumption ac on d.alcohol_consumption = ac.alcohol_consumption

