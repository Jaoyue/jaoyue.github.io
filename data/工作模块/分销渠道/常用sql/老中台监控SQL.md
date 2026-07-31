### 分销库存监控

```
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'inventory_quantity' quantity_type,a.inventory_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='inventory_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'received_inventory_quantity' quantity_type,a.received_inventory_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='received_inventory_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'returned_inventory_quantity' quantity_type,a.returned_inventory_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='returned_inventory_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'received_way_quantity' quantity_type,a.received_way_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='received_way_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'returned_way_quantity' quantity_type,a.returned_way_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='returned_way_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'received_confirm_quantity' quantity_type,a.received_confirm_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='received_confirm_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
union all
select a.distributor_name,a.distributor_code,a.material_no,a.product_name,'returned_confirm_quantity' quantity_type,a.returned_confirm_quantity k_quantity,b.quantity r_quantity from  `platform-dist`.`dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `platform-dist`.`dist_inventory_operation_log`   where  operate_type='returned_confirm_quantity'  group by distributor_code,material_no,operate_type 
)  b,`platform-dist`.dist_distributor c   where a.distributor_code=b.distributor_code and a.material_no=b.material_no and a.distributor_code = c.distributor_code and c.sale_mode = 'OFFLINE' HAVING k_quantity <> r_quantity
```

### 应推库存未推送监控

```
SELECT so.order_no source_no, '门店 APP-无库存门店-销售单支付确认扣减门店归属客户仓库库存' operate_type
FROM `platform-store`.sp_sales_order so
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio1 ON so.order_no = dio1.source_no AND dio1.source_type = 'STORE_NO_INVENTORY_SALES_ORDER'
WHERE so.`status` = 'FINISHED' AND so.storage_location = 'C' AND so.shop_type = 'F' AND so.order_type IN ('RETAIL_ORDER', 'PURCHASE_ORDER', 'TRADE_ORDER') and so.order_time >= 1704038400000 AND dio1.source_no IS NULL
UNION ALL
SELECT r.order_no source_no, '门店 APP-无库存门店-销退单销退确认增加门店归属客户仓库库存' operate_type
FROM `platform-store`.sp_refund_order r
JOIN `platform-store`.sp_sales_order s ON r.sales_order_no = s.order_no
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio2 ON r.order_no = dio2.source_no AND dio2.source_type = 'STORE_NO_INVENTORY_RETURN_ORDER'
WHERE r.`status` = 'FINISHED' AND s.storage_location = 'C' AND s.shop_type = 'F' AND s.order_type IN ('RETAIL_ORDER', 'PURCHASE_ORDER', 'TRADE_ORDER') AND dio2.source_no IS NULL
UNION ALL
SELECT pur_number source_no, '门店 APP-交货单-进货单审核扣减归属客户仓库库存' operate_type
FROM `platform-store`.sp_purchase_order po
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio3 ON pur_number = dio3.source_no AND dio3.source_type = 'STORE_DELIVERY_SALES_ORDER'
WHERE po.`status` IN (4, 5, 6) AND dio3.source_no IS NULL
UNION ALL
SELECT rtn_number source_no, '门店 APP-交货单-退货单收货增加归属客户仓库库存' operate_type
FROM `platform-store`.sp_rtn_purchase_order rpo
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio4 ON rtn_number = dio4.source_no AND dio4.source_type = 'STORE_DELIVERY_RETURN_ORDER'
WHERE rpo.`status` IN (5, 6) AND dio4.source_no IS NULL
UNION ALL
SELECT sn source_no, '门店 APP-出样' operate_type
FROM `platform-store`.sp_prototype_sn_log psn
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio5 ON sn = dio5.source_no AND dio5.source_type = 'TAPE_ORDER'
WHERE psn.operat = '出样_新增样机' AND dio5.source_no IS NULL
UNION ALL
SELECT order_no source_no, '盘点审核通过' operate_type
FROM `platform-dist`.dist_inventory_check dic
LEFT JOIN `platform-dist`.dist_inventory_operation_log dio6 ON order_no = dio6.source_no AND dio6.source_type = 'INVENTORY_CHECK'
WHERE dic.`status` = 'COMPLETE' AND dio6.source_no IS NULL
```

### 分销库存日志同步监控

```
select '门店APP-无库存门店-销售单支付确认扣减门店归属客户仓库库存' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,i.count scount from `platform-dist`.dist_inventory_operation_log l,(select sales_order_no,material_no,sum(count) count from `platform-store`.sp_sales_order_item group by sales_order_no,material_no) i where l.source_no = i.sales_order_no and l.material_no = i.material_no and l.source_type = 'STORE_NO_INVENTORY_SALES_ORDER' GROUP BY l.source_no,l.material_no HAVING lcount + scount <> 0
union all
select '门店APP-无库存门店-销退单销退确认增加门店归属客户仓库库存' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,i.count scount from `platform-dist`.dist_inventory_operation_log l,(select refund_order_no,material_no,sum(count) count from `platform-store`.sp_refund_order_item group by refund_order_no,material_no) i where l.source_no = i.refund_order_no and l.material_no = i.material_no and l.source_type = 'STORE_NO_INVENTORY_RETURN_ORDER' GROUP BY l.source_no,l.material_no HAVING lcount <> scount
union all
select '门店APP-交货单-进货单审核扣减归属客户仓库库存' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,i.count scount from `platform-dist`.dist_inventory_operation_log l,(select pur_number,material_no,sum(pur_amount) count from `platform-store`.sp_purchase_order_detail group by pur_number,material_no) i where l.source_no = i.pur_number and l.material_no = i.material_no and l.source_type = 'STORE_DELIVERY_SALES_ORDER' GROUP BY l.source_no,l.material_no HAVING lcount + scount <> 0
union all
select '门店APP-交货单-退货单收货增加归属客户仓库库存' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,i.count scount from `platform-dist`.dist_inventory_operation_log l,(select rtn_number,material_no,sum(rtn_amount) count from `platform-store`.sp_rtn_purchase_order_detail group by rtn_number,material_no) i where l.source_no = i.rtn_number and l.material_no = i.material_no and l.source_type = 'STORE_DELIVERY_RETURN_ORDER' GROUP BY l.source_no,l.material_no HAVING lcount <> scount 
union all
select '门店APP-出样' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,1 scount from `platform-dist`.dist_inventory_operation_log l,`platform-store`.sp_store_prototype_sn i where l.source_no = i.sn_code and l.material_no = i.material_no and l.source_type = 'TAPE_ORDER' GROUP BY l.source_no,l.material_no HAVING lcount + scount <> 0
union all
select '盘点审核通过' source_type,l.source_no,l.material_no,sum(l.quantity) lcount,i.count scount from `platform-dist`.dist_inventory_operation_log l,(select inventory_check_order_no,material_no,sum(adjust_quantity) count from `platform-dist`.dist_inventory_check_item group by inventory_check_order_no,material_no) i where l.source_no = i.inventory_check_order_no and l.material_no = i.material_no and l.source_type = 'INVENTORY_CHECK' GROUP BY l.source_no,l.material_no HAVING lcount <> scount 
```

### 门店样机库存监控

```
select a.store_no,a.material_no,a.stock_amount,b.stock from `platform-store`.sp_prototype_store_stock a,(select store_no,material_no,count(*) stock from `platform-store`.sp_store_prototype_sn where delete_flag = 0 group by store_no,material_no) b where a.store_no = b.store_no and a.material_no = b.material_no HAVING stock_amount <> stock
```

### 门店销售报表监控

```
select t1.stat_time,t1.amount sale_amount,t2.amount material_amount from
(select sum(sales_amount_average-refund_amount_average) amount,stat_time from `platform-store`.sp_sales_daily_stat_v2 group by stat_time) t1
join 
(select sum(sales_amount) amount,stat_time from `platform-store`.sp_store_product_stat group by stat_time) t2 on t1.stat_time=t2.stat_time
where ABS(t1.amount - t2.amount) > 1
```

### 门店销售统计监控

```
select r1.stat_time `日期`,r1.amount `计算销售额`,r2.amount `统计表销售额` from(
select stat_time,sum(amount) amount from(
select CAST(sum(i.count *i.average_price) AS  DECIMAL(15,3)) as amount,2024 stat_time from `platform-store`.sp_sales_order o left JOIN `platform-store`.sp_sales_order_item i on i.sales_order_no=o.order_no where o.order_time >= 1704038400000 and o.`status` in ('FINISHED','WAITING_PICK_UP') and i.is_gift='N' 
union all
select -CAST(sum(i.count *i.average_price) AS  DECIMAL(15,3)) as amount,2024 stat_time from `platform-store`.sp_refund_order o left JOIN `platform-store`.sp_refund_order_item i on i.refund_order_no=o.order_no left join sp_sales_order so on o.sales_order_no = so.order_no   where o.order_time >= 1704038400000 and o.`status`='FINISHED' and i.is_gift='N' 
) t GROUP BY stat_time
) r1 join (
select 2024 stat_time,sum(sales_amount) amount from `platform-store`.sp_store_product_stat where stat_time >= 1704038400000 
) r2 on r1.stat_time = r2.stat_time HAVING ABS(r1.amount - r2.amount) > 1
```