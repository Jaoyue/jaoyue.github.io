select * from dist_distributor where sales_channel = 'SINK_CHANNEL' and distributor_code = '3008605';

update `platform-dist`.dist_inventory_operation_log set distributor_code = concat(distributor_code,'_del'),material_no = concat(material_no,'_del') where source_type = 'STORE_NO_INVENTORY_RETURN_ORDER' and source_no not in (select order_no from `platform-store`.sp_refund_order);
update `dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `dist_inventory_operation_log`   where  operate_type='inventory_quantity'  group by distributor_code,material_no,operate_type
)  b  set a.inventory_quantity=b.quantity where a.distributor_code=b.distributor_code and a.material_no=b.material_no ;

SELECT
    DATE_FORMAT(FROM_UNIXTIME(target_date / 1000), '%Y-%m') AS month,
    SUM(sales_amount) AS monthly_target_amount
FROM `platform-dist`.dist_sales_target_day_detail
WHERE
    target_date >= UNIX_TIMESTAMP(MAKEDATE(YEAR(CURDATE()), 1)) * 1000
    AND target_date < UNIX_TIMESTAMP(MAKEDATE(YEAR(CURDATE()) + 1, 1)) * 1000
    AND distributor_code = '1003682'
GROUP BY DATE_FORMAT(FROM_UNIXTIME(target_date / 1000), '%Y-%m')
