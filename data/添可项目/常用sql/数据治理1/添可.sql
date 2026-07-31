SELECT category, service_type, model, fault_tag
FROM tineco_agent.tineco_agent_cs_service_tag_dd;

SELECT accessor_id,
       accessor_name,
       accessor_use_qty,
       accessor_use_qty /
       sum(accessor_use_qty) as rate
FROM tineco_agent.tineco_agent_cs_orig_prod_top_dault_info_dd
order by accessor_use_qty desc
limit 15;
SELECT *
FROM tineco_agent.tineco_agent_cs_orig_prod_top_dault_info_dd;

SELECT product_sap_id,
       level_number,
       cpnt_code,
       upper_cpnt_code,
       cpnt_desc,
       material_group,
       cpnt_qty,
       cpnt_unit_meas,
       net_weight,
       status,
       color,
       certify_model,
       market_region,
       product_name,
       six_nine_code,
       product_category,
       product_name_en,
       customer_type,
       COUNT(1) OVER () AS total_count
from tineco_agent.tineco_agent_general_bom_detail_dd
limit 10;

select distinct spu_name
from tineco_agent_prod_pbi_main_info_dd
where spu_name is not null
  and spu_name <> '';
select *
from tineco_agent_prod_pbi_main_info_dd
where upper(spu_name) = 'STATION VIEW';
select *
from tineco_agent_prod_pbi_main_info_dd
where factory_model = 'CL2482';
select *
from tineco_agent_prod_pbi_main_info_dd
where upper(spu_name) = '芙万2.0';
select *
from tineco_agent_cs_repair_3_lvl_fault_dd;
select *
from tineco_agent_cs_repair_sp_level_dd;

select *
from tineco_agent.tineco_agent_general_bom_detail_dd
where product_sap_id = '109-24260503'
order by level_number;

SELECT id,
       brand_cn,
       brand_en,
       product_big_type,
       product_mid_type,
       spu_name,
       spu_id,
       manufacturer,
       spu_model,
       product_name,
       product_sap_id,
       sku_id,
       product_desc,
       certify_model,
       product_series_model,
       factory_model,
       project_name,
       sales_region,
       market_region,
       status,
       product_colour,
       goods_barcode,
       net_weight,
       gross_weight,
       outer_length,
       outer_width,
       outer_height,
       outer_box_type,
       innerbox_content
FROM tineco_agent.tineco_agent_prod_pbi_main_info_dd
WHERE spu_name in ('悠尼2.0')

select sp_name,
       sum(minor_repr_qty) xiao,
       sum(mid_rpair_qty)  zhong,
       sum(maj_rpair_qty)  da
from tineco_agent.tineco_agent_cs_repair_sp_level_dd
where sp_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '躺平2.0')
GROUP BY sp_name;
select sp_name,
       sum(minor_repr_qty + mid_rpair_qty +
           maj_rpair_qty) count
from tineco_agent_cs_repair_sp_level_dd
where sp_series_model in (
    'CL2343'
    )
GROUP BY sp_name
order by count desc

select *
from tineco_agent_cs_repair_sp_level_dd
where sp_series_model = 'CL2343'
select *
from tineco_agent_cs_repair_sp_level_dd
where sp_series_model like 'CL23%'

select *
from tineco_agent_qc_history_question_list_dd
where matl_code = '109-23430001'
  and defective_phenom = '进水'
order by occur_date
select *
from tineco_agent_qc_history_question_list_dd
where factory_model in ('CL2436', 'CL2436B')
select *
from tineco_agent_qc_history_question_list_dd
select occur_date, defective_phenom
from tineco_agent.tineco_agent_qc_history_question_list_dd
where matl_code in
      ('109-23430001', '109-23430002')
select *
from tineco_agent.tineco_agent_qc_history_question_list_dd
where matl_code in
      ('109-23430001', '109-23430002')

select *
from tineco_agent.tineco_agent_qc_history_question_list_dd
where factory_model in (select factory_model
                        from tineco_agent.tineco_agent_prod_pbi_main_info_dd
                        where spu_name = '躺平2.0')
  and matl_name is not null
  and matl_name <> ''

select *
from tineco_agent_prod_pbi_main_info_dd
where factory_model = 'CL2019'
  and spu_name is not null
select *
from tineco_agent_prod_pbi_main_info_dd
where factory_model = 'CL2343'
  and spu_name is not null
select *
from tineco_agent_prod_pbi_main_info_dd
where spu_name = '躺平2.0'

SELECT *
from tineco_agent_cs_repair_sp_level_dd
limit 11
SELECT *
from tineco_agent_cs_repair_sp_level_dd
where sp_series_model = 'CL2343'

select sum(minor_repr_qty) xiao,
       sum(mid_rpair_qty)  zhong,
       sum(maj_rpair_qty)  da
from tineco_agent.tineco_agent_cs_repair_sp_level_dd
where sp_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '躺平2.0');

select sp_parts_name
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
order by prodn_time desc;
select *
from tineco_agent_cs_repair_fault_order_dd
where material_no in
      ('109-23280002')
  and fault_reason = '清水桶故障';
SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd where back_confirm_time >= '2025-11-01 00:00:00'
and material_no = '109-23281004';


select *
from tineco_agent_cs_repair_fault_order_dd
where fault_class is not null;
select count(*)
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null;
select count(*)
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is null;
select *
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null;
select *
from tineco_agent_cs_repair_fault_order_dd
where material_no in
      ('109-23430001', '109-23430002');
select *
from tineco_agent_cs_repair_fault_order_dd
where material_no in
      ('109-23430001', '109-23430002');
select sum(sp_cnt_qty) total_count
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
  and material_no in
      ('109-23430001', '109-23430002');

SELECT sum(sp_cnt_qty) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
  and fault_class = '充电异常'
  and material_no in
      ('109-21230000', '109-21230001',
       '109-21230901', '109-21230902',
       '109-21230903', '109-21231501',
       '109-23190001', '109-23350001',
       '109-23350101', '109-23350102',
       '109-23350103', '109-23350104',
       '109-23350201', '109-23350202',
       '109-23350203', '109-23350204',
       '109-23351701')
  and prodn_time < '2025-04-28'

select *
from tineco_agent_cs_fault_list_lv2_dd
select *
from tineco_agent_qa_history_question_list_dd
select *
from tineco_agent_qc_history_question_list_dd
select concat(occur_date, '') as occur_date,
       defective_phenom
from tineco_agent.tineco_agent_qc_history_question_list_dd
where matl_code in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
select concat(occur_date, '') as occur_date,
       defective_phenom
from tineco_agent.tineco_agent_qa_history_question_list_dd
where matl_code in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
select distinct spu_name, spu_id
from tineco_agent.tineco_agent_prod_pbi_main_info_dd
where spu_name is not null
  and spu_name <> ''

select fault_system,
       fault_phenomenon,
       fault_mode,
       repair_code
from tineco_agent.tineco_agent_cs_fault_list_lv2_dd

SELECT sum(sp_cnt_qty) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where fault_class = '(通用)开机无反应'
  and material_no in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
  and prodn_time >= '2025-03-08'
;

select *
from tineco_agent_cs_repair_fault_order_dd
where fault_class like '%,%'
select distinct factory_model
from tineco_agent_prod_pbi_main_info_dd
where spu_name = '躺平1.0'


SELECT sum(sp_cnt_qty) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
  and fault_class = '(通用)开机无反应'
  and material_no in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
SELECT count(distinct repair_order_no)
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where fault_class = '(通用)开机无反应'
  and material_no in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
SELECT sum(sp_cnt_qty) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where fault_class = '(通用)开机无反应'
  and material_no in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
SELECT sum(sp_cnt_qty) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where sp_parts_name = 'SP;CL2343-01;电池包密封棉'
  and fault_class = '(通用)开机无反应'
  and material_no in
      ('109-23430001', '109-23430002',
       '109-23430003', '109-23430501',
       '109-23430503', '109-23430505',
       '109-23430601', '109-23430602',
       '109-23430603', '109-23430604',
       '109-23430701', '109-23430703',
       '109-23430801', '109-23430802',
       '109-23430803', '109-23430804',
       '109-23430805', '109-23430806')
;
select *
from tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
  and material_no = '109-20190001';

select *
from tineco_agent.tineco_agent_cs_repair_fault_order_dd
where fault_class like '%其他%';
select distinct fault_class
from tineco_agent.tineco_agent_cs_repair_fault_order_dd
order by fault_class;

SELECT count(distinct repair_order_no) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where concat(lv1_fault, '-', lv2_fault, '-',
             lv3_fault) = '充电故障-充电无反应'

SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where prodn_time is not null
;
SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where lv1_fault = '充电故障'
  and lv2_fault = '充电无反应'
  and lv3_fault = '机身与充电托盘连接处的触点有脏污'

SELECT count(distinct repair_order_no) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where material_no = '109-21230901'
  and lv1_fault = '充电无反应'
  and lv2_fault = '充电无反应'
  and lv3_fault = '电池包故障'


SELECT sp_material_no,
       max(sp_parts_name) sp_parts_name,
       sum(sp_cnt_qty)    total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where material_no = '109-21230901'
  and lv1_fault = '充电故障'
  and lv2_fault = '充电无反应'
  and lv3_fault = '电池包故障'
group by sp_material_no
order by total_count desc
limit 1

select sp_series_model,
       sum(minor_repr_qty) xiao,
       sum(mid_rpair_qty)  zhong,
       sum(maj_rpair_qty)  da
from tineco_agent.tineco_agent_cs_repair_sp_level_dd
where product_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '饮万畅饮')
group by sp_series_model;

SELECT count(distinct repair_order_no) total_count
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where material_no in
      ('109-23430001', '109-23430002')
  and lv1_fault = '地刷体故障'
  and lv2_fault = '水渍大'
  and lv3_fault = '机器故障'

select *
from tineco_agent_prod_pbi_main_info_dd
where product_series_model in
      (select sp_series_model
       from tineco_agent_cs_repair_sp_level_dd);
select *
from tineco_agent_cs_repair_sp_level_dd;

SELECT *
FROM tineco_agent.tineco_agent_cs_repair_sp_level_dd
WHERE sp_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '芙万2.0');
SELECT sp_series_model as  sp_name,
       sum(minor_repr_qty) xiao,
       sum(mid_rpair_qty)  zhong,
       sum(maj_rpair_qty)  da
FROM tineco_agent.tineco_agent_cs_repair_sp_level_dd
WHERE sp_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '芙万2.0')
GROUP BY sp_series_model;

select sum(minor_repr_qty) xiao,
       sum(mid_rpair_qty)  zhong,
       sum(maj_rpair_qty)  da
from tineco_agent.tineco_agent_cs_repair_sp_level_dd
where product_series_model in
      (select product_series_model
       from tineco_agent.tineco_agent_prod_pbi_main_info_dd
       where spu_name = '芙万2.0')

SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where back_confirm_time is not null;
SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
limit 100;
SELECT *
FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd
where material_no = '109-20191301'
  and lv1_fault = '屏幕出现故障提示'
  and lv2_fault = '提示充电故障'
  and lv3_fault = '电池包故障';

select *
from tineco_agent.tineco_agent_qa_history_question_list_dd;
select concat(occur_date, '') as occur_date,
       matl_code,
       matl_name,
       defective_phenom,
       defective_reason,
       improvement_measure
from tineco_agent.tineco_agent_qa_history_question_list_dd
where defective_phenom is not null
  and matl_code is not null
  and occur_date is not null
limit 0, 1000;
select count(*)
from tineco_agent.tineco_agent_qa_history_question_list_dd
where defective_phenom is not null
  and matl_code is not null;

select improvement_measure,
       max(occur_date) as occur_date
from tineco_agent.tineco_agent_qa_history_question_list_dd
group by improvement_measure;


select count(*)
from tineco_agent.tineco_agent_qa_history_question_list_dd
where defective_phenom is not null
  and matl_code is not null
  and occur_date is not null
and occur_date = '2025-11-07';

select * from tineco_agent_fic_pyne_sag_bill_wise_split_detailed2_dd;

select * from tineco_agent_fic_pyne_overview_dd;
select *
from tineco_agent.tineco_agent_qc_history_question_list_dd;
select count(*)
from tineco_agent.tineco_agent_qc_history_question_list_dd
where factory_model in (select factory_model
                        from tineco_agent.tineco_agent_prod_pbi_main_info_dd
                        where spu_name = '轻量化' and factory_model is not null and factory_model <> '')
  and matl_name is not null
  and matl_name <> ''  ;
select count(*)
from tineco_agent.tineco_agent_qc_history_question_list_dd
where factory_model in ('CL2482B')
  and matl_name is not null
  and matl_name <> ''  ;
select *
                        from tineco_agent.tineco_agent_prod_pbi_main_info_dd
                        where spu_name = '轻量化' and factory_model is not null;

select count(*) from tineco_agent_cs_css_product_warranty_config_dd;
select count(*) from tineco_agent_cs_css_ms_service_order_dd;
select count(*) from tineco_agent_cs_css_ms_door_installation_order_dd;
select count(*) from tineco_agent_cs_css_ms_repair_order_di;
select * from tineco_agent.tineco_agent_cs_repair_fault_order_dd WHERE  sp_parts_name like '%散备件 CL2019 电池包组件%' limit 11;

SELECT material_no, MAX(back_confirm_time) AS latest_time FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd WHERE material_no IN ('115-20450001', '109-23350102') GROUP BY material_no;

SELECT COUNT(*) FROM ecovacs_agent.ecovacs_agent_cs_aftersale_total_fee_paine_df;

SELECT material_no, COUNT(*) AS order_count FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd WHERE  sp_parts_name = '散备件 CL2019 电池包组件' GROUP BY material_no ORDER BY order_count DESC LIMIT 20


SELECT material_no, COUNT(repair_order_no) AS order_count FROM tineco_agent.tineco_agent_cs_repair_fault_order_dd WHERE  sp_parts_name LIKE '%散备件 CL2019 电池包组件 _%' GROUP BY material_no ORDER BY order_count DESC LIMIT 20

SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS table_name,table_comment FROM information_schema.TABLES WHERE TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') ORDER BY TABLE_SCHEMA, TABLE_NAME

SELECT *,day(creation_date) FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di;
SELECT *,day(creation_date) FROM ecovacs_agent.ecovacs_agent_prod_main_data_df;

ecovacs_agent.ecovacs_agent_his_repair_work_order_df,历史维修工单
tineco_agent.tineco_agent_cs_css_ms_door_installation_order_dd,添可CSS上门安装订单表
tineco_agent.tineco_agent_cs_css_ms_repair_order_di,添可CSS维修订单表
tineco_agent.tineco_agent_cs_css_ms_service_order_dd,添可CSS服务订单表

SELECT COUNT(*) AS repair_order_count FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di WHERE YEAR(creation_date) = '2023' AND MONTH(creation_date) = '11' AND DAY(creation_date) = '26' AND delete_flag = 0

SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS table_name,table_comment FROM information_schema.TABLES WHERE TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') AND TABLE_SCHEMA LIKE '%ecovacs%' ORDER BY TABLE_SCHEMA, TABLE_NAME;
SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS table_name,table_comment FROM information_schema.TABLES WHERE TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') AND TABLE_SCHEMA LIKE '%tineco%' ORDER BY TABLE_SCHEMA, TABLE_NAME;


SELECT CONCAT(TABLE_SCHEMA, '.', TABLE_NAME) AS table_name,table_comment FROM information_schema.TABLES WHERE TABLE_SCHEMA NOT IN ('mysql', 'information_schema', 'performance_schema', 'sys') AND TABLE_SCHEMA LIKE '%ecovacs%' ORDER BY TABLE_SCHEMA, TABLE_NAME
;
select * from tineco_agent_qc_history_question_list_dd order by occur_date desc;
select * from tineco_agent_prod_pbi_main_info_dd where factory_model = 'CL2343G-01';
SELECT q.*
FROM tineco_agent.tineco_agent_qc_history_question_list_dd q
         INNER JOIN (SELECT DISTINCT factory_model
                     FROM tineco_agent.tineco_agent_prod_pbi_main_info_dd
                     WHERE spu_name LIKE '%躺平1.0%'
                       AND factory_model IS NOT NULL
                       AND factory_model != '') p
                    ON q.factory_model =
                       p.factory_model
WHERE YEAR(q.occur_date) = '2025' AND MONTH(q.occur_date) = '6';
SELECT q.*
FROM tineco_agent.tineco_agent_qc_history_question_list_dd q
         INNER JOIN (SELECT DISTINCT factory_model
                     FROM tineco_agent.tineco_agent_prod_pbi_main_info_dd
                     WHERE spu_name = '躺平1.0'
                       AND factory_model IS NOT NULL
                       AND factory_model != '') p
                    ON q.factory_model =
                       p.factory_model
WHERE SUBSTRING(q.occur_date, 1, 7) =
      CONCAT('2025', '-', '06');

select * from v_tineco_agent_public_coral_app_token_pyne_dd where app_name is not null order by app_name asc,cost desc;
select * from v_tineco_agent_public_coral_app_token_pyne_dd where app_name is not null order by cost desc;