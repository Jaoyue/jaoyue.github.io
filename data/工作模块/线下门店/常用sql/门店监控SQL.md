> HTML 页面: [[page/wiki/data/工作模块/线下门店/常用sql/门店监控SQL.html|打开 HTML 页面]]

```sql
select a.store_no,a.material_no,a.stock_amount,b.stock from sp_prototype_store_stock a,(select store_no,material_no,count(*) stock from sp_store_prototype_sn where delete_flag = 0 group by store_no,material_no) b where a.store_no = b.store_no and a.material_no = b.material_no HAVING stock_amount <> stock



```

```sql
select t1.stat_time,t1.amount sale_amount,t2.amount material_amount from
(select sum(sales_amount_average-refund_amount_average) amount,stat_time from `platform-store`.sp_sales_daily_stat_v2 group by stat_time) t1
join 
(select sum(sales_amount) amount,stat_time from `platform-store`.sp_store_product_stat group by stat_time) t2 on t1.stat_time=t2.stat_time
where ABS(t1.amount - t2.amount) > 1
```

```sql
SELECT r1.stat_time `日期`,r1.amount `计算销售额`,r2.amount `统计表销售额` FROM(SELECT stat_time,SUM(amount) amount FROM(SELECT CAST(SUM(i.count *i.average_price) AS  DECIMAL(15,3)) AS amount,2024 stat_time FROM `platform-store`.sp_sales_order o LEFT JOIN `platform-store`.sp_sales_order_item i ON i.sales_order_no=o.order_no WHERE o.order_time >= 1704038400000 AND o.`status` IN ('FINISHED','WAITING_PICK_UP')  UNION ALL SELECT -CAST(SUM(i.count *i.average_price) AS  DECIMAL(15,3)) AS amount,2024 stat_time FROM `platform-store`.sp_refund_order o LEFT JOIN `platform-store`.sp_refund_order_item i ON i.refund_order_no=o.order_no LEFT JOIN `platform-store`.sp_sales_order so ON o.sales_order_no = so.order_no   WHERE o.order_time >= 1704038400000 AND o.`status`='FINISHED' ) t GROUP BY stat_time ) r1 JOIN (SELECT 2024 stat_time,SUM(sales_amount) amount FROM `platform-store`.sp_store_product_stat WHERE stat_time >= 1704038400000 ) r2 ON r1.stat_time = r2.stat_time HAVING ABS(r1.amount - r2.amount) > 1
```

