### 商品销售报表
```plsql
select * from sp_refund_sn_list where sn not in (select sn from sp_sn_list)

select * from sp_sn_list where sales_order_no = '601665229712299542254'
'1234'
'1234'


select * from sp_refund_sn_list where sn not in ('1234') and order_no = '601665229712299542254'
select * from sp_refund_sn_list where sn  in ('1234') and order_no = '601665229712299542254'

select * from sp_sales_order where order_time is null
select * from sp_refund_order where order_time is null

select * from sp_sales_order where `status` = 'FINISHED' and order_no in (select sales_order_no from sp_sn_list where sn = 'TD1707TEB0106') order by create_time desc limit 1

select *from sp_biz_staff where user_name = 'fanny.fan'
select * from sp_refund_order where `status` = 'FINISHED' and order_no in (select sales_order_no from sp_sn_list where sn = 'TD1707TEB0106') order by create_time desc limit 1

select * from sp_sn_black_list where sn like '%TC1127L6D0574%'

select * from sp_store_info where name = '苏州苏州中心旗舰店'



select t.* from( SELECT 0 material_no,spt.store_id store_id,SUM(spt.sales_count) count, SUM(sales_amount),i.delete_flag flag,p.name FROM sp_store_product_stat spt join sp_store_info i on spt.store_id = i.id  JOIN sp_product p on p.material_no = spt.material_no WHERE 1=1 and spt.stat_time >=1690819200000 and spt.stat_time <=1692892799999 and spt.store_id in (SELECT distinct si.id FROM sp_store_info si  where si.ascription ='ECOVACS' and si.company_no !='5000004'and (si.id in (select store_id from sp_biz_staff_store_permission where staff_id = 300 )OR si.manage_staff_id = 90 ) ) GROUP BY spt.store_id  union all  select 0 material_no,s.id store_id,0 count,0 amount,0 flag,0 name from(SELECT distinct si.id FROM sp_store_info si  where si.ascription ='ECOVACS'and si.delete_flag = 0 and si.disabled_reason IS NULL  and si.company_no !='5000004'and (si.id in (select store_id from sp_biz_staff_store_permission where staff_id = 300 )OR si.manage_staff_id = 90 ) ) s ) t  join (select store_id,min(open_business_time) ob_time from sp_store_decoration_life_cycle where delete_flag = 0 group by store_id) c on t.store_id = c.store_id and c.ob_time <= 1692860605289 group by store_id

select t.* from( SELECT 0 material_no,spt.store_id store_id,SUM(spt.sales_count) count, SUM(sales_amount),i.delete_flag flag,p.name FROM sp_store_product_stat spt join sp_store_info i on spt.store_id = i.id  JOIN sp_product p on p.material_no = spt.material_no WHERE 1=1 and spt.stat_time >=1690819200000 and spt.stat_time <=1692892799999 and spt.store_id in (SELECT distinct si.id FROM sp_store_info si  where si.ascription ='ECOVACS' and si.company_no !='5000004'and (si.id in (select store_id from sp_biz_staff_store_permission where staff_id = 300 )OR si.manage_staff_id = 300 ) ) GROUP BY spt.store_id  union all  select 0 material_no,s.id store_id,0 count,0 amount,0 flag,0 name from(SELECT distinct si.id FROM sp_store_info si  where si.ascription ='ECOVACS'and si.delete_flag = 0 and si.disabled_reason IS NULL  and si.company_no !='5000004'and (si.id in (select store_id from sp_biz_staff_store_permission where staff_id = 300 )OR si.manage_staff_id = 300 ) ) s ) t  join (select store_id,min(open_business_time) ob_time from sp_store_decoration_life_cycle where delete_flag = 0 group by store_id) c on t.store_id = c.store_id and c.ob_time <= 1692860833227 group by store_id HAVING store_id = 5756
```

```plsql
select sum(sa) from(
SELECT
	t.* 
FROM
	(
SELECT
	0 material_no,
	spt.store_id store_id,
	SUM( spt.sales_count ) count,
	SUM( sales_amount ) sa,
	i.delete_flag flag,
	p.NAME 
FROM
	sp_store_product_stat spt
	JOIN sp_store_info i ON spt.store_id = i.id
	JOIN sp_product p ON p.material_no = spt.material_no 
WHERE
	1 = 1 
	AND spt.stat_time >= 1696089600000 
	AND spt.stat_time <= 1698681599999 
	AND spt.store_id IN ( SELECT DISTINCT si.id FROM sp_store_info si WHERE si.ascription = 'ECOVACS' AND si.company_no != '5000004' ) 
GROUP BY
	spt.store_id UNION ALL
SELECT
	0 material_no,
	s.id store_id,
	0 count,
	0 amount,
	0 flag,
	0 NAME 
FROM
	(
SELECT DISTINCT
	si.id 
FROM
	sp_store_info si 
WHERE
	si.ascription = 'ECOVACS' 
	AND si.delete_flag = 0 
	AND si.disabled_reason IS NULL 
	AND si.company_no != '5000004' 
	) s 
	) t 
WHERE
	t.store_id IN (
SELECT
	store_id 
FROM
	( SELECT store_id, min( open_business_time ) ob_time FROM sp_store_decoration_life_cycle WHERE delete_flag = 0 GROUP BY store_id ) r 
WHERE
	ob_time <= 1698628242113 
	) 
GROUP BY
	store_id
	) aa
	
	
	
	select sum(sa) from(
SELECT
	t.material_no,t.store_id,sum(t.count),sum(t.sa) sa,t.flag,t.name 
FROM
	(
SELECT
	0 material_no,
	spt.store_id store_id,
	SUM( spt.sales_count ) count,
	SUM( sales_amount ) sa,
	i.delete_flag flag,
	p.NAME 
FROM
	sp_store_product_stat spt
	JOIN sp_store_info i ON spt.store_id = i.id
	JOIN sp_product p ON p.material_no = spt.material_no 
WHERE
	1 = 1 
	AND spt.stat_time >= 1696089600000 
	AND spt.stat_time <= 1698681599999 
	AND spt.store_id IN ( SELECT DISTINCT si.id FROM sp_store_info si WHERE si.ascription = 'ECOVACS' AND si.company_no != '5000004' ) 
GROUP BY
	spt.store_id UNION ALL
SELECT
	0 material_no,
	s.id store_id,
	0 count,
	0 amount,
	0 flag,
	0 NAME 
FROM
	(
SELECT DISTINCT
	si.id 
FROM
	sp_store_info si 
WHERE
	si.ascription = 'ECOVACS' 
	AND si.delete_flag = 0 
	AND si.disabled_reason IS NULL 
	AND si.company_no != '5000004' 
	) s 
	) t 
WHERE
	t.store_id IN (
SELECT
	store_id 
FROM
	( SELECT store_id, min( open_business_time ) ob_time FROM sp_store_decoration_life_cycle WHERE delete_flag = 0 GROUP BY store_id ) r 
WHERE
	ob_time <= 1698628242113 
	) group by store_id) aa
```

