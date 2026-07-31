select * from trade_app_forecast_promote;
select * from trade_oa_promotion_forecast_batch where serial_no = 'CSPL17447104181681734';

select * from trade_app_forecast_build where serial_no = 'CSR17562606518075758';
select * from dbu_trade_flow.trade_app_forecast_build where reset_flag = 1;
delete from dbu_trade_flow.trade_app_forecast_build where store_name = '测试审核' and id = 5296;
select * from trade_terminal_plan_list where store_name = 'KA天津京东MALL滨海泰达旗舰店';

select * from trade_app_forecast_build where serial_no = 'CSN17506620095695666';
select * from trade_app_forecast_build where store_no = '9003779';

select * from trade_app_forecast_promote where serial_no = 'CSP17640396648062663';
select * from trade_app_forecast_promote where plan_fixed_cost is not null;
select * from trade_operation_fee_allocation_log;
select * from trade_oa_promotion_forecast_batch;
select * from trade_oa_promotion_forecast_batch_detail where serial_no = 'CSPL17642708177674388';
select d.* from trade_app_forecast_promote_detail d join trade_app_forecast_promote p on d.serial_no = p.serial_no
           join trade_oa_promotion_forecast_batch b on p.batch_id = b.id
           where
b.serial_no = 'CSPL17642708177674388' and store_no = '9000216' and fee_item_code in ('CXF0003','CXF0005');
SELECT
    TABLE_NAME AS 表名,
    TABLE_COMMENT AS 表注释
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = DATABASE()  -- 当前数据库
  AND TABLE_TYPE = 'BASE TABLE'   -- 只查普通表，排除视图
ORDER BY TABLE_NAME;
select * from trade_forecast_verify_staff_relation;
update trade_forecast_verify_staff_relation set staff_id = 456,staff_name = '季甜甜' where id = 3;