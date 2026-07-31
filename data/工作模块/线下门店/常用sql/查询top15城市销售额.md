> HTML 页面: [[page/wiki/data/工作模块/线下门店/常用sql/查询top15城市销售额.html|打开 HTML 页面]]

```plsql
select city_id,r.area_name,sales_amount,concat( round( sales_amount  / ( select sum(sales_amount) from (
select SUM(sales_amount_average-refund_amount_average) as sales_amount  FROM sp_sales_daily_stat_v2 stat  where 1=1  and workspace_type='REGION'  AND store_id IN (select id from sp_store_info) AND stat_time >= 1640966400000 AND stat_time <=1661961599000 group by city_id order by sales_amount desc limit 0,15) a ) * 100, 2 ), '%' ) AS per from (
SELECT city_id,SUM(sales_amount_average-refund_amount_average) as sales_amount  FROM sp_sales_daily_stat_v2 stat  where 1=1  and workspace_type='REGION'  AND store_id IN (select id from sp_store_info) AND stat_time >= 1640966400000 AND stat_time <=1661961599000 group by city_id order by sales_amount desc limit 0,15 ) t
left join `platform-admin`.`sys_area` r on t.city_id = r.area_id
```

