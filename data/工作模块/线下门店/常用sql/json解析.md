```plsql
SELECT j.id,j.name,replace(REPLACE(j.detail,"{",""),"}","") 
from sp_train_job j where id = 114



select t3.id,if(t3.`key` = 'name',t3.`value`) `name`
from (
select id,mkey `key`,substring_index(map,concat(mkey,': '),-1) `value`
from(
select id,substring_index(map,':',1) mkey,map
from(
SELECT
	g.id,
	replace(
	trim(substring_index(
		substring_index(
			g.user_ids,
			',',
			b.help_topic_id + 1
		),
		',' ,- 1
	)),'"','') AS map
FROM
	(SELECT j.id,replace(REPLACE(j.detail,"{",""),"}","") user_ids
from sp_train_job j ) g
JOIN mysql.help_topic b ON b.help_topic_id < (
	length(g.user_ids) - length(
		REPLACE (g.user_ids, ',', '')
	) + 1
)
) t
) t2
) t3



Select * from sp_clerk_info

select * from sp_user_staff_relation where id = 506


select id,GROUP_CONCAT(`name`) `name`,GROUP_CONCAT(`age`) `age`,GROUP_CONCAT(`gender`) `gender` from (
select t3.id,if(t3.`key` = 'name',t3.`value`,null) `name`,if(t3.`key` = 'age',t3.`value`,null) `age`,if(t3.`key` = 'gender',t3.`value`,null) `gender`
from (
select id,mkey `key`,substring_index(map,concat(mkey,': '),-1) `value`
from(
select id,substring_index(map,':',1) mkey,map
from(
SELECT
	g.id,
	replace(
	trim(substring_index(
		substring_index(
			g.user_ids,
			',',
			b.help_topic_id + 1
		),
		',' ,- 1
	)),'"','') AS map
FROM
	(SELECT j.id,replace(REPLACE(j.detail,"{",""),"}","") user_ids
from sp_train_job j ) g
JOIN mysql.help_topic b ON b.help_topic_id < (
	length(g.user_ids) - length(
		REPLACE (g.user_ids, ',', '')
	) + 1
)
) t
) t2
) t3
) tt group by id

```

