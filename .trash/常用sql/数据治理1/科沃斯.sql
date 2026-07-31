SELECT class, svc_type, crm_fault_tag
FROM ecovacs_agent.ecovacs_agent_fault_tag_df
where class = '售后';

SELECT prod_series, prod_model
FROM ecovacs_agent.ecovacs_agent_prod_main_data_df;
SELECT *
FROM ecovacs_agent.ecovacs_agent_prod_main_data_df;

SELECT spares_related_prod_series,
       client,
       small_repair_rate,
       middle_repair_rate,
       large_repair_rate,
       etl_time
FROM ecovacs_agent.ecovacs_agent_csc_orig_prod_repair_spares_grade_df
WHERE 1 = 1;

SELECT id,
       data_synchro_date,
       client,
       struc_grade,
       target_type_specifier,
       no,
       code,
       name,
       class,
       qty,
       unit,
       nW,
       status,
       color,
       auth_model,
       mkt_name,
       ean_upc,
       country_chl,
       etl_time,
       father_lvl_material_no,
       fp_material_no,
       purchase_type,
       special_purchase_type,
       COUNT(1) OVER () AS total_count
FROM ecovacs_agent.ecovacs_agent_pro_rd_bom_df t1 where color is not null
limit 10000;

SELECT *
FROM ecovacs_agent_csc_orig_prod_repair_spares_grade_df;
SELECT accessor_prod_series, count(*)
FROM ecovacs_agent_orig_prod_top_dault_info_df
GROUP BY accessor_prod_series;

SELECT accessor_id,
       accessor_name,
       accessor_prod_series,
       repair_rate
FROM ecovacs_agent.ecovacs_agent_orig_prod_top_dault_info_df
where accessor_prod_series = 'T9';
SELECT distinct prod_series, project_code FROM ecovacs_agent.ecovacs_agent_prod_main_data_df where prod_series is not null and prod_series <> ''
SELECT *
FROM ecovacs_agent.ecovacs_agent_csc_orig_prod_repair_spares_grade_df

SELECT id,
       data_synchro_date,
       client,
       struc_grade,
       target_type_specifier,
       no,
       code,
       name,
       class,
       qty,
       unit,
       nW,
       status,
       color,
       auth_model,
       mkt_name,
       ean_upc,
       country_chl,
       etl_time,
       father_lvl_material_no,
       fp_material_no,
       purchase_type,
       special_purchase_type,
       COUNT(1) OVER () AS total_count
FROM ecovacs_agent.ecovacs_agent_pro_rd_bom_df t1 limit 10;

SELECT distinct prod_series FROM ecovacs_agent.ecovacs_agent_prod_main_data_df where prod_series is not null and prod_series <> ''
SELECT DISTINCT prod_series,prod_set_code FROM ecovacs_agent.ecovacs_agent_prod_main_data_df
SELECT DISTINCT prod_series,prod_set_code FROM ecovacs_agent.ecovacs_agent_prod_main_data_df WHERE prod_series = 'DEEBOT X11';
SELECT * FROM ecovacs_agent.ecovacs_agent_prod_main_data_df WHERE prod_series = 'DEEBOT X9系列';
SELECT * FROM ecovacs_agent.ecovacs_agent_prod_main_data_df WHERE prod_series like '%X9%';
SELECT * FROM ecovacs_agent.ecovacs_agent_prod_main_data_df WHERE ecovacs_agent_prod_main_data_df.prod_set_code like '%ZJ2498%';


SELECT * FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where repair_order_no = '8015140328690329749110';
SELECT * FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where prod_series like '%T80%';
SELECT count(*) FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where repair_order_no like 'WX%';
SELECT count(*) FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where repair_order_no not like 'WX%';
SELECT * FROM ecovacs_agent.ecovacs_agent_repair_3_lvl_fault_df where lvl_3_fault like '%报警%';
select distinct spu_name from tineco_agent.tineco_agent_prod_pbi_main_info_dd where spu_name is not null and spu_name <> '';
SELECT distinct concat(prod_series,',') FROM ecovacs_agent.ecovacs_agent_prod_main_data_df where prod_series is not null and prod_series <> '' ;

select *
        from ecovacs_agent.ecovacs_agent_his_repair_work_order_df
        where material_no in ('110-2488-0301','110-2488-0001')
          and fault_class is not null
          and fault_class != ''
          and check_descri is not null and check_descri != ''
            and actual_fault is not null and actual_fault != ''
            and accessor_name is not null and accessor_name != ''

SELECT accessor_name, sum(repair_rate) rate FROM ecovacs_agent.ecovacs_agent_orig_prod_top_dault_info_df WHERE accessor_prod_series = 'DEEBOT X9系列' group by accessor_name
SELECT prod_line, series_name, repair_accessor, fault_pheno, repair_qty, sample_qty, reason_analyze, invalid_reason_qty, single_problem_reason_rate, duty_dept, longterm_scheme, finish_time, status, material_id, material_name, material_cate, supplier_name FROM ecovacs_agent.ecovacs_agent_mkt_repair_problem_info_df where 1 = 1 AND series_name in ( '1' )

SELECT accessor_name, sum(repair_rate) rate FROM ecovacs_agent.ecovacs_agent_orig_prod_top_dault_info_df WHERE accessor_prod_series = '\u8eba\u5e732.0' GROUP BY accessor_name

select * from
(select confirm_pheno pheno,finish_time from ecovacs_agent.ecovacs_agent_mkt_return_problem_info_df where series_name = 'DEEBOT X8系列' and finish_time is not null
union all
select fault_pheno pheno,finish_time from ecovacs_agent.ecovacs_agent_mkt_repair_problem_info_df where series_name = 'DEEBOT X8系列' and finish_time is not null)
t where t.pheno = '清洁槽异常' order by finish_time desc limit 1;

select * from ecovacs_agent_his_repair_work_order_df where production_date

SELECT accessor_name,
    SUM(total_qty) AS total_count  FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where fault_class = '机器异响/异音' and material_no in (
'110-2488-0001',
'110-2488-0002',
'110-2488-0003',
'110-2488-0301',
'110-2488-0302',
'110-2488-0303'
    ) group by accessor_name order by total_count desc limit 10

select * from ecovacs_agent_his_repair_work_order_df where production_date >= '2025-01-01'

select * from ecovacs_agent_mkt_repair_problem_info_df
select distinct prod_set_code from ecovacs_agent_prod_main_data_df where prod_series = 'W1S Pro'

select pheno,concat(finish_time,'') as finish_time from (select confirm_pheno pheno,finish_time from ecovacs_agent.ecovacs_agent_mkt_return_problem_info_df where series_name = 'DEEBOT X8系列' and finish_time is not null union all select fault_pheno pheno,finish_time from ecovacs_agent.ecovacs_agent_mkt_repair_problem_info_df where series_name = 'DEEBOT X8系列' and finish_time is not null) t where t.pheno = '语音报警：清洁槽水满' order by finish_time desc limit 1

select distinct accessor_sap_material_no,accessor_name from ecovacs_agent_his_repair_work_order_df where accessor_name like '%X1基站包装袋%'
select distinct accessor_sap_material_no,accessor_name from ecovacs_agent_his_repair_work_order_df where ecovacs_agent_his_repair_work_order_df.accessor_sap_material_no <> '201-2102-24K0'
;
select * from ecovacs_agent_his_repair_work_order_df ;
select distinct * from(
select prod_family from ecovacs_agent_os_prod_top_fault_df
union all
select prod_family from ecovacs_agent_os_prod_repair_accessor_lvl_df) t;
select * from ecovacs_agent_os_prod_top_fault_df;
select spare_part_name accessor_name,ifnull(sum(maintenance_rate),0) rate from ecovacs_agent_os_prod_top_fault_df where prod_family = 'AES-T10 FAMILY' group by spare_part_name;
select * from ecovacs_agent_os_prod_repair_accessor_lvl_df where prod_family = 'N10 Family' limit 1;
select min_repair_prop, mod_repair_prop, maj_repair_prop from ecovacs_agent_os_prod_repair_accessor_lvl_df where prod_family = 'X9 Family' limit 1;
SELECT accessor_name, ifnull(sum(repair_rate),0) rate FROM ecovacs_agent.ecovacs_agent_orig_prod_top_dault_info_df WHERE accessor_prod_series = 'DEEBOT T10'  GROUP BY accessor_name
SELECT * FROM ecovacs_agent.ecovacs_agent_orig_prod_top_dault_info_df WHERE accessor_prod_series like '%X5%'

SELECT fault_code, cate, lvl_1_fault, lvl_2_fault, lvl_3_fault FROM ecovacs_agent.ecovacs_agent_repair_3_lvl_fault_df where 1 = 1

SELECT distinct product_family from ecovacs_agent.ecovacs_agent_os_his_repair_order_df where product_family is not null;

select * from ecovacs_agent_his_repair_work_order_df where fault_class not in (
select distinct pheno from (select confirm_pheno pheno,
                                   finish_time
                            from ecovacs_agent.ecovacs_agent_mkt_return_problem_info_df
                            where series_name = 'T50系列'
                              and finish_time is not null
                            union all
                            select fault_pheno pheno,
                                   finish_time
                            from ecovacs_agent.ecovacs_agent_mkt_repair_problem_info_df
                            where series_name = 'T50系列'
                              and finish_time is not null
)t) and material_no in
      ('110-2425-0001', '110-2425-0101',
       '110-2425-0103', '110-2441-0001',
       '110-2441-0101', '110-2468-0001',
       '110-2468-0101');

SELECT accessor_name,count(*)
FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df
where accessor_sap_material_no <> '201-2102-24K0'
  and fault_class = '驱动轮组件不良'
  and material_no in
      ('110-2425-0001', '110-2425-0101',
       '110-2425-0103', '110-2441-0001',
       '110-2441-0101', '110-2468-0001',
       '702-0000-0074') group by accessor_name;

select count(distinct repair_order_no) from ecovacs_agent_his_repair_work_order_df limit 10;
select distinct lvl_2_fault from ecovacs_agent.ecovacs_agent_repair_3_lvl_fault_df

select distinct lvl_2_fault from ecovacs_agent.ecovacs_agent_repair_3_lvl_fault_df;
select distinct crm_fault_tag from ecovacs_agent_fault_tag_df

select distinct * from ecovacs_agent.ecovacs_agent_repair_3_lvl_fault_df where lvl_2_fault like '%充电%';

SELECT count(distinct repair_order_no) total_count FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df where accessor_sap_material_no <> '201-2102-24K0' and fault_class = '充不进电/充不满电' and material_no in ('110-2515-0001','110-2515-0003','110-2515-0004','110-2515-0101','110-2515-0102','110-2515-0103','110-2546-0001','110-2546-0101');
;
select * from ecovacs_agent_his_repair_work_order_df;

SELECT spares_related_prod_series, client, small_repair_rate, middle_repair_rate, large_repair_rate, etl_time FROM ecovacs_agent.ecovacs_agent_csc_orig_prod_repair_spares_grade_df WHERE 1 = 1 AND spares_related_prod_series = 'T80系列';

select min_repair_prop, mod_repair_prop, maj_repair_prop from ecovacs_agent.ecovacs_agent_os_prod_repair_accessor_lvl_df where prod_family = '{{#17588704557590.out#}}'  limit 1

SELECT prod_series,count(*) ct
FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df
where production_date > '2019-01-01' and production_date < '2026-01-01' group by prod_series order by ct desc limit 10;

SELECT accessor_name,
       max(accessor_sap_material_no) sap_id
FROM ecovacs_agent.ecovacs_agent_his_repair_work_order_df
where material_no = '110-2102-0001'
  and accessor_name in ('锂电池5200mAh',
                        '散备件 锂电池 5200mAh Battery pack(Li-Ion)',
                        '充电极片',
                        '散备件 充电极片 Charging Touching Module 中国',
                        '散备件 回充模块 Charging module',
                        '回充模块', '主板',
                        '地宝主板',
                        '滚刷齿轮箱组件',
                        '散备件 主板 Main board') group by accessor_name ;