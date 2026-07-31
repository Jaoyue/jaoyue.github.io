select * from ims_dist_sales_order where sales_order_no = 'FXDD202605291315170002';
update ims_dist_sales_order set province_id = replace(province_id, '"', ''),area_id = replace(area_id, '"', '') where 1=1;
select * from ims_dist_sales_order_item where header_id = '2060228461072785409';

CREATE TABLE IF NOT EXISTS data2 (
    customer_code    VARCHAR(64) COMMENT '客户编码',
    lvl_2_category   VARCHAR(128) COMMENT '二级品类',
    sap_id           VARCHAR(64) COMMENT '物料SAP编码',
    forecast_week    VARCHAR(32) COMMENT '预测周',
    forecast_qty     VARCHAR(64) COMMENT '预测数量(字符串存储)',
    data_type        VARCHAR(32) COMMENT '数据类型',
    step_index       VARCHAR(32) COMMENT '步骤序号',
    delivery_mode    VARCHAR(64) COMMENT '配送方式'
) ENGINE = InnoDB DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '预测数据表_全字符串存储';

select * from data1;
select count(*) from data1;
select * from data2;
select count(*) from data2;
delete from data2 where 1=1;