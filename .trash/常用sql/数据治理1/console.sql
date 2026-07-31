SELECT CASE a.region
           WHEN 'Centro_Region' THEN '中部大区'
           WHEN 'Southern_Region' THEN '南部大区'
           WHEN 'Eastern_Region' THEN '东部大区'
           WHEN 'Western_Division' THEN '西部大区'
           WHEN 'DSF' THEN '第三方'
           WHEN 'headquarters' THEN '总部'
           WHEN 'Northern_Region' THEN '北部大区'
           ELSE a.region END AS          大区,
       a.servicer_name                   网点名称,
       d.fault_reason                    故障描述,
       count(distinct a.repair_order_no) 单量,
       sum(e.labor_fee)                  人工费
FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di a
         JOIN tineco_agent.tineco_agent_cs_ms_repair_order_item_dd b
              ON a.repair_order_no =
                 b.repair_order_no
         join tineco_agent.tineco_agent_cs_ms_repair_order_fault_dd d
              on a.repair_order_no =
                 d.repair_order_no
         join tineco_agent.tineco_agent_cs_ms_repair_order_fee_servicer_dd e
              on a.repair_order_no =
                 e.repair_order_no
where a.repair_order_status = 'FINISH'
GROUP BY a.region,
         a.servicer_name,
         d.fault_reason
having 故障描述 is not null
order by 大区, 网点名称, 故障描述

select distinct region
from tineco_agent_cs_css_ms_repair_order_di
order by finish_time desc
limit 100;
select *
from tineco_agent_cs_css_ms_repair_order_di
order by finish_time desc
limit 100;
select distinct priority_level
from tineco_agent_cs_css_ms_repair_order_di;
select *
from tineco_agent_cs_css_ms_repair_order_di
where finish_time > '2026-01-01 00:00:00';
select *
from tineco_agent_cs_ms_repair_order_item_dd
limit 100;
select *
from tineco_agent_cs_ms_repair_order_parts_item_dd
limit 100;
select *
from tineco_agent_cs_ms_repair_order_fault_dd
limit 10000;
select *
from tineco_agent_cs_ms_repair_order_fee_servicer_dd
limit 10000;

select *, visit_satisfy_status
from tineco_agent_cs_css_ms_door_installation_order_dd
limit 10000;
select *
from tineco_agent_cs_css_ms_service_order_dd
limit 10000;
select distinct priority_level
from tineco_agent_cs_css_ms_service_order_dd
limit 10000;
select *
from tineco_agent_cs_ms_service_order_item_dd
limit 10000;
select *
from tineco_agent_cs_ms_door_installation_settle_fee_dd
limit 10000;
select *
from tineco_agent_cs_ms_door_installation_order_item_dd
limit 10000;
select *
from tineco_agent_cs_warranty_repair_overdue_order_dd
limit 10000;
select *
from tineco_agent_cs_multiple_repair_analysis
limit 10000;
select *
from tineco_agent_cs_ms_door_installation_settle_fee_dd
where on_door_fee is not null
limit 10000;
select distinct repair_order_type
from tineco_agent_cs_css_ms_service_order_dd;


select shop_name    网点名称,
       clerk_name   维修师傅,
       hours_differ 时效范围,
       count(*)     总计
from tineco_agent_cs_warranty_repair_overdue_order_dd
where shop_name is not null
group by shop_name, clerk_name, hours_differ
order by shop_name, clerk_name, hours_differ;
select *
from tineco_agent_cs_multiple_repair_analysis
where name <> lag_clerk_name;

SELECT repair_order_no     AS '维修单号',
       regin               AS '大区',
       shop_short_name     AS '网点名称',
       material_no         AS '物料号',
       product_name        AS '商品名称',
       receive_sn_code     AS 'SN',
       t                   AS '维修时间',
       fault_type          AS '故障',
       parts_code          AS '配件码',
       parts_name          AS '配件名称',
       clerk_id            AS '维修专员id',
       name                AS '维修专员',
       lag_t               AS '上次维修日期',
       lag_repair_order_no AS '上次维修单号',
       lag_fault_type      AS '上次故障',
       lag_parts_code      AS '上次配件码',
       lag_parts_name      AS '上次配件名称',
       lag_clerk_id        AS '上次维修专员id',
       lag_clerk_name      AS '上次维修专员',
       x                   AS '距离上次维修天数',
       x                   AS '举例上次维修期限',
       shop_type           AS '网点类型'
FROM tineco_agent.tineco_agent_cs_multiple_repair_analysis
WHERE regin = '中部大区'
  AND year(t) = '2025'
  and month(t) = '6'
  and week(t) = '10';

select count(*)
from tineco_agent.tineco_agent_cs_repair_revisit_unsat_detail_dd
where
-- 查询字段注释含“费”的表和字段信息
SELECT TABLE_SCHEMA   AS 数据库名,
       TABLE_NAME     AS 表名,
       COLUMN_NAME    AS 字段名,
       COLUMN_COMMENT AS 字段注释,
       DATA_TYPE      AS 字段类型,
       IS_NULLABLE    AS 是否允许为空
FROM INFORMATION_SCHEMA.COLUMNS
WHERE
  -- 匹配注释包含“费”字（模糊查询）
    COLUMN_COMMENT LIKE '%故障%'
  -- 可选：指定要查询的数据库，避免查所有库
  AND TABLE_SCHEMA = 'tineco_agent'
-- 按表名、字段名排序，方便查看
ORDER BY TABLE_NAME,
         COLUMN_NAME;

-- 步骤1：先用CTE计算出所有SN的出现次数和间隔天数（把窗口函数放在CTE里）
WITH sn_base_data AS (SELECT sn_code,
                             creation_date,
                             -- 保留你原有的窗口函数计算逻辑
                             ROW_NUMBER() OVER (
                                 PARTITION BY sn_code
                                 ORDER BY creation_date ASC
                                 ) AS 同SN出现次数,
                             DATEDIFF(
                                     creation_date,
                                     LAG(
                                             creation_date,
                                             1)
                                             OVER (PARTITION BY sn_code ORDER BY creation_date ASC)
                                 ) AS 与上一次出现间隔天数
                      FROM tineco_agent_cs_ms_door_installation_order_item_dd
                      where sn_code is not null
                        and sn_code != ''
    -- WHERE creation_date >= '2024-01-01'
)
-- 步骤2：在外部查询中筛选30天内重复的记录
SELECT sn_code,
       creation_date,
       同SN出现次数,
       与上一次出现间隔天数
FROM sn_base_data
WHERE
  -- 筛选间隔≤30天的记录（用CTE中计算好的字段，而非直接用窗口函数）
    与上一次出现间隔天数 <= 30
  -- 排除间隔为NULL的记录（即SN首次出现的记录）
  AND 与上一次出现间隔天数 IS NOT NULL
ORDER BY sn_code,
         creation_date;


-- 步骤1：计算所有SN的出现次数和间隔天数，过滤空SN
WITH sn_base_data AS (SELECT sn_code,
                             creation_date,
                             DATEDIFF(
                                     creation_date,
                                     LAG(
                                             creation_date,
                                             1)
                                             OVER (PARTITION BY sn_code ORDER BY creation_date ASC)
                                 ) AS 与上一次出现间隔天数
                      FROM tineco_agent_cs_ms_door_installation_order_item_dd
                      WHERE sn_code IS NOT NULL
                        AND sn_code != '' -- 过滤空SN/空字符串SN
),
-- 步骤2：筛选出30天内有重复的SN记录（未去重）
     dup_sn_detail AS (SELECT sn_code
                       FROM sn_base_data
                       WHERE 与上一次出现间隔天数 <= 30
                         AND 与上一次出现间隔天数 IS NOT NULL)
-- 步骤3：最终返回去重后的重复SN列表 + 总数统计
SELECT DISTINCT sn_code              AS 30天内重复的SN,
                (SELECT COUNT(DISTINCT sn_code)
                 FROM dup_sn_detail) AS 重复SN总数
FROM dup_sn_detail
ORDER BY sn_code;

SELECT shop_short_name                    AS '网点名称',
       name                                  '维修师傅',
       COUNT(CASE
                 WHEN x BETWEEN 15 AND 30
                     THEN 1 END)          AS '15天-30天内',
       COUNT(CASE WHEN x < 15 THEN 1 END) AS '15天内',
       COUNT(CASE
                 WHEN x BETWEEN 31 AND 60
                     THEN 1 END)          AS '30天-60天内',
       COUNT(CASE
                 WHEN x BETWEEN 61 AND 90
                     THEN 1 END)          AS '61天-90天内',
       COUNT(*)                           AS '总计'
FROM tineco_agent.tineco_agent_cs_multiple_repair_analysis
WHERE x IS NOT NULL
  AND x REGEXP '^[0-9]+$'
  AND regin = '中部大区'
GROUP BY shop_short_name, name
order by shop_short_name, name;

SELECT servicer_name      AS 网点,
       fettler_clerk_name AS 师傅,
       ROUND(SUM(CASE
                     WHEN priority_level = 'HIGH'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 大修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'MIDDLE'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 中修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'LOW'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 小修百分比,
       ROUND(SUM(CASE
                     WHEN repair_confirm_type =
                          'ONLY_CHECK' THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 只检测不维修百分比
FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di
where repair_order_status = 'FINISH'
GROUP BY servicer_name, fettler_clerk_name;

select distinct priority_level
from tineco_agent_cs_css_ms_repair_order_di;
select d0.repair_order_no,
       sum(d1.count * d2.price)
from tineco_agent_cs_css_ms_repair_order_di d0
         join tineco_agent_cs_ms_repair_order_parts_item_dd d1
              on d0.repair_order_no =
                 d1.repair_order_no
         left join tineco_agent_cs_price_inside_dd d2
                   on d1.material_no =
                      d2.product_sap_id
where d0.repair_confirm_type = 'CONTINUE'
  and d1.warranty_type = 'OUT_WARRANTY'
group by d0.repair_order_no
having d0.repair_order_no = 'CSRP250412000304';
select *
from tineco_agent_cs_price_inside_dd
where product_sap_id in
      ('114-18790176', '114-18790199');
select *
from tineco_agent_cs_ms_repair_order_fee_servicer_dd
where repair_order_no = '801676031362117248100';
select *
from tineco_agent_cs_warranty_repair_overdue_order_dd
where repair_order_no = '801676031362117248100';

SELECT sum(tot_labor_cost)
FROM tineco_agent.tineco_agent_hr_pine_hr_cost_dd
where YEAR(finish_time) = '2026'
  and WEEK(finish_time, 1) = '1';
SELECT *
FROM tineco_agent.tineco_agent_wl_lgsts_exp_wkly_alloc_dd;
SELECT *
FROM tineco_agent.v_tineco_agent_public_coral_app_token_pyne_dd;
SELECT sum(cost) token费用
FROM tineco_agent.v_tineco_agent_public_coral_app_token_pyne_dd;

SELECT sum(tot_labor_cost)
FROM tineco_agent.tineco_agent_hr_pine_hr_cost_dd
where (third_lvl_org_nm = '总部服务' and
       identity_class = '一线人员')
   or (sec_org_nm = '服务商管理部' and
       identity_class <> '一线人员')

SELECT servicer_name      AS 网点,
       ROUND(SUM(CASE
                     WHEN priority_level = 'HIGH'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 大修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'MIDDLE'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 中修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'LOW'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 小修百分比,
       ROUND(SUM(CASE
                     WHEN repair_confirm_type =
                          'ONLY_CHECK' THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 只检测不维修百分比
FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di
where repair_order_status = 'FINISH'
  AND region in ('Southern_Region', 'bb')
  and YEAR(finish_time) = '2025'
GROUP BY servicer_name;

select *
from tineco_agent_cs_css_ms_repair_order_di;
select *
from tineco_agent_cs_ms_repair_order_item_dd;
select *, category
from tineco_agent_cs_product_info_dd;
select *
from tineco_agent_cs_asm_order_original_dd;
select *
from tineco_agent_cs_nationwide_repair_indicator_dd;
SELECT shop_region           AS '区域',
       finish_rate_24        AS '保内24H完工率',
       NULL                  AS '保外24H完工率',
       visit_satisfied_rate  AS '维修回访满意度',
       more_repair_rate      AS '多次维修率',
       repair_aging_score    AS '维修时效得分',
       visit_satisfied_score AS '回访满意度得分',
       more_repair_score     AS '多次维修率得分',
       total_score           AS '总得分'
FROM tineco_agent.tineco_agent_cs_nationwide_repair_indicator_dd

select t.category              维修品类,
       t.material_no           配件sapid物料号,
       t.parts_name            配件名称,
       t.count                 数量,
       t.order_count           品类完工量,
       t.count / t.order_count 耗用量占比
from (select p.category,
             c.material_no,
             max(c.parts_name)                       parts_name,
             sum(c.count)                            count,
             count(distinct a.repair_order_no)
                   over (partition by p.category) as order_count
      from (select distinct d1.repair_order_no,
                            d2.material_no
            from tineco_agent_cs_css_ms_repair_order_di d1
                     join tineco_agent_cs_ms_repair_order_item_dd d2
                          on d1.repair_order_no =
                             d2.repair_order_no
            where d1.repair_order_status =
                  'FINISH'
              and year(d1.finish_time) = '2025'
              and week(d1.finish_time, 1) = '52'
              and d2.warranty_type = 'IN_WARRANTY'
              and d1.repair_confirm_type in
                  ('CONTINUE', 'ONLY_CHECK')) a
               join tineco_agent_cs_ms_repair_order_parts_item_dd c
                    on a.repair_order_no =
                       c.repair_order_no
               join tineco_agent_cs_product_info_dd p
                    on a.material_no =
                       p.product_sap_id
      where p.category is not null
        and c.warranty_type = 'IN_WARRANTY'
      group by p.category, c.material_no) t;

select *
from tineco_agent_cs_css_ms_repair_order_di
select distinct repair_confirm_type
from tineco_agent_cs_css_ms_repair_order_di with order_base as (
    select distinct
        d1.repair_order_no,
        d2.material_no,servicer_name,fettler_clerk_name
    from tineco_agent_cs_css_ms_repair_order_di d1
    join tineco_agent_cs_ms_repair_order_item_dd d2
        on d1.repair_order_no = d2.repair_order_no
    where d1.repair_order_status = 'FINISH'
        and year(d1.finish_time) = '2025'
        and week(d1.finish_time,1) = '52'
        and d2.warranty_type = 'IN_WARRANTY'
        and d1.repair_confirm_type in ('CONTINUE','ONLY_CHECK')
)
select t.category                          维修品类,
       t.material_no                       配件sapid物料号,
       t.parts_name                        配件名称,
       t.count                             数量,
       cat.order_count                     品类完工量,
       round(t.count / cat.order_count, 4) 耗用量占比
from (select p.category,
             c.material_no,
             max(c.parts_name) parts_name,
             sum(c.count)      count
      from order_base a
               join tineco_agent_cs_ms_repair_order_parts_item_dd c
                    on a.repair_order_no =
                       c.repair_order_no
               join tineco_agent_cs_product_info_dd p
                    on a.material_no =
                       p.product_sap_id
      where p.category is not null
        and c.warranty_type = 'IN_WARRANTY'
      group by p.category, c.material_no) t
         join (select p.category,
                      count(distinct
                            a.repair_order_no) as order_count
               from order_base a
                        join tineco_agent_cs_product_info_dd p
                             on a.material_no =
                                p.product_sap_id
               where p.category is not null
               group by p.category) cat
              on t.category = cat.category
having 数量 > 5


SELECT servicer_name      AS 网点,
       fettler_clerk_name AS 师傅,
       ROUND(SUM(CASE
                     WHEN priority_level = 'HIGH'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 大修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'MIDDLE'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 中修百分比,
       ROUND(SUM(CASE
                     WHEN priority_level = 'LOW'
                         THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 小修百分比,
       ROUND(SUM(CASE
                     WHEN repair_confirm_type =
                          'ONLY_CHECK' THEN 1
                     ELSE 0 END) * 100.0 /
             COUNT(*), 2) AS 只检测不维修百分比
FROM tineco_agent.tineco_agent_cs_css_ms_repair_order_di
where repair_order_status = 'FINISH'
  AND regin = '中部大区'
  and YEAR(finish_time) = #{year}
GROUP BY servicer_name, fettler_clerk_name;
select *
from tineco_agent_cs_ms_repair_order_parts_item_dd;

SELECT sale_region,
       prod_line,
       SUM(actual_income) AS total_income
FROM ecovacs_agent.ecovacs_agent_fin_net_income_paine_df
WHERE year = '2026'
  AND month = replace('02', '0', '')
GROUP BY sale_region, prod_line
ORDER BY total_income DESC
LIMIT 100;

select *
from tineco_agent_prod_pbi_main_info_history_dd
where product_series_model = '躺平1.0';
select distinct *
from tineco_agent_prod_pbi_main_info_history_dd
where product_sap_id = '109-21230001';
select distinct spu_name, product_sap_id
from (select distinct spu_name,
                      product_sap_id
      from tineco_agent.tineco_agent_prod_pbi_main_info_dd
      where spu_name is not null
        and spu_name <> ''
        and product_sap_id is not null
        and product_sap_id <> ''
      union all
      select distinct a.spu_name,
                      b.product_sap_id
      from tineco_agent_prod_pbi_main_info_dd a
               join tineco_agent_prod_pbi_main_info_history_dd b
                    on a.factory_model =
                       b.factory_model
      where a.spu_name is not null
        and a.spu_name <> ''
        and b.product_sap_id is not null
        and b.product_sap_id <> '') t;
select *
from tineco_agent_cs_repair_fault_order_dd
where material_no = '109-21230901';


select *, spu_name
from tineco_agent_prod_pbi_main_info_dd
where factory_model = 'CL2123';

SELECT *
FROM tineco_agent.tineco_agent_cs_multiple_repair_analysis
WHERE x IS NOT NULL
  AND x REGEXP '^[0-9]+$'
  AND regin = '东部大区'
  and YEAR(t) = 2026
  and WEEK(t, 1) = 18
GROUP BY shop_short_name;

SELECT *
from tineco_agent_cs_warranty_repair_overdue_order_dd
WHERE region in
      ('北部大区', 'Centro_Region')
  and warranty_type = '保内'
  and YEAR(finished_time) = 2026
  and WEEK(finished_time, 1) = 18
group by shop_name;

SELECT repair_order_no AS '维修单号', regin AS '大区', shop_short_name AS '网点名称', material_no AS '物料号', product_name AS '商品名称', receive_sn_code AS 'SN', t AS '维修时间', fault_type AS '故障', parts_code AS '配件码', parts_name AS '配件名称', clerk_id AS '维修专员id', name AS '维修专员', lag_t AS '上次维修日期', lag_repair_order_no AS '上次维修单号', lag_fault_type AS '上次故障', lag_parts_code AS '上次配件码', lag_parts_name AS '上次配件名称', lag_clerk_id AS '上次维修专员id', lag_clerk_name AS '上次维修专员', x AS '距离上次维修天数', x AS '举例上次维修期限', shop_type AS '网点类型' FROM tineco_agent.tineco_agent_cs_multiple_repair_analysis WHERE  YEAR(t) =  2026 and MONTH(t) = 4

select distinct * from tineco_agent.tineco_agent_cs_repair_fault_order_dd where material_no in (
    select
    product_sap_id
from (
    select distinct
        spu_name,
        product_sap_id
    from tineco_agent.tineco_agent_prod_pbi_main_info_dd
    where spu_name is not null and spu_name <> ''
      and product_sap_id is not null and product_sap_id <> ''
    union all
    select distinct
        a.spu_name,
        b.product_sap_id
    from tineco_agent.tineco_agent_prod_pbi_main_info_dd a
    join tineco_agent.tineco_agent_prod_pbi_main_info_history_dd b
        on a.factory_model = b.factory_model
    where a.spu_name is not null and a.spu_name <> ''
      and b.product_sap_id is not null and b.product_sap_id <> ''
) t
where spu_name = '轻量化'
    )
;
select * from v_tineco_agent_pub_agent_business_week_config;

