SELECT
    -- 【本年至今累计：今年1月1日 00:00:00 -> 现在】
    SUM(CASE
            WHEN d.stat_time >=
                 UNIX_TIMESTAMP(DATE_FORMAT(NOW(),
                                            '%Y-01-01 00:00:00')) *
                 1000
                AND s.store_extend = 'DIST_STORE'
                THEN d.sales_amount
            ELSE 0 END) AS cy_dist_sales,

    SUM(CASE
            WHEN d.stat_time >=
                 UNIX_TIMESTAMP(DATE_FORMAT(NOW(),
                                            '%Y-01-01 00:00:00')) *
                 1000
                AND (s.store_extend !=
                     'DIST_STORE' OR
                     s.store_extend IS NULL)
                THEN d.sales_amount
            ELSE 0 END) AS cy_retail_sales,

    -- 【去年同期累计：去年1月1日 00:00:00 -> 去年的现在】
    SUM(CASE
            WHEN d.stat_time >=
                 UNIX_TIMESTAMP(DATE_FORMAT(
                         DATE_SUB(NOW(), INTERVAL
                                  1 YEAR),
                         '%Y-01-01 00:00:00')) *
                 1000
                AND d.stat_time <=
                    UNIX_TIMESTAMP(DATE_SUB(NOW(),
                                            INTERVAL
                                            1
                                            YEAR)) *
                    1000
                AND s.store_extend = 'DIST_STORE'
                THEN d.sales_amount
            ELSE 0 END) AS py_dist_sales,

    SUM(CASE
            WHEN d.stat_time >=
                 UNIX_TIMESTAMP(DATE_FORMAT(
                         DATE_SUB(NOW(), INTERVAL
                                  1 YEAR),
                         '%Y-01-01 00:00:00')) *
                 1000
                AND d.stat_time <=
                    UNIX_TIMESTAMP(DATE_SUB(NOW(),
                                            INTERVAL
                                            1
                                            YEAR)) *
                    1000
                AND (s.store_extend !=
                     'DIST_STORE' OR
                     s.store_extend IS NULL)
                THEN d.sales_amount
            ELSE 0 END) AS py_retail_sales

FROM sp_store_product_stat d
         JOIN sp_store_info s ON d.store_id = s.id
WHERE s.company_no = '1000903'
  -- 优化：WHERE子句只保留最远的时间下限，提高索引效率
  AND d.stat_time >= UNIX_TIMESTAMP(DATE_FORMAT(
        DATE_SUB(NOW(), INTERVAL 1 YEAR),
        '%Y-01-01 00:00:00')) * 1000;
SELECT SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            NOW(),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS cy_dist_sales,

       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            NOW(),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS cy_retail_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            DATE_SUB(NOW(),
                                     INTERVAL 1
                                     YEAR),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(DATE_SUB(
                               NOW(), INTERVAL 1
                               YEAR)) * 1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS py_dist_sales,

       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            DATE_SUB(NOW(),
                                     INTERVAL 1
                                     YEAR),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(DATE_SUB(
                               NOW(), INTERVAL 1
                               YEAR)) * 1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS py_retail_sales

FROM sp_store_product_stat d
         JOIN sp_store_info s ON d.store_id = s.id
WHERE s.company_no = '1000903'
  AND d.stat_time >= UNIX_TIMESTAMP(DATE_FORMAT(
        DATE_SUB(NOW(), INTERVAL 1 YEAR),
        '%Y-01-01 00:00:00')) * 1000;
select sum(d.sales_amount)
from sp_store_product_stat d
         JOIN sp_store_info s ON d.store_id = s.id
WHERE s.company_no = '1000903'
  and d.stat_time >= 1735660800000
  and d.stat_time <= 1745251200000;

select distinct store_extend
from sp_store_info;
select *
from `platform-store`.oa_dist_distributor;
select *
from `platform-store`.sp_sales_order;
select *
from `platform-store`.sp_store_info
where company_no = '1000903';
SELECT SUM(CASE
               WHEN delete_flag = 0 THEN 1
               ELSE 0 END) AS business_running_count,
       SUM(CASE
               WHEN delete_flag = 2 THEN 1
               ELSE 0 END) AS business_waiting_count,
       SUM(CASE
               WHEN create_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            NOW(),
                            '%Y-01-01 00:00:00')) *
                    1000 THEN 1
               ELSE 0 END) AS this_year_new_count
FROM `platform-store`.sp_store_info
WHERE company_no = '1000903';
select UNIX_TIMESTAMP(DATE_FORMAT(NOW(),
                                  '%Y-01-01 00:00:00'));

select *
from sp_refund_order
where order_no = '621733728679228049210';

select *,
       FROM_UNIXTIME(create_time / 1000,
                     '%Y-%m-%d %H:%i:%s')
from `platform-dist`.dist_inventory_operation_log
where source_type =
      'STORE_NO_INVENTORY_RETURN_ORDER'
  and source_no not in
      (select order_no from sp_refund_order);
select *,
       FROM_UNIXTIME(create_time / 1000,
                     '%Y-%m-%d %H:%i:%s')
from `platform-dist`.dist_inventory_operation_log
where source_type =
      'STORE_NO_INVENTORY_SALES_ORDER'
  and source_no not in
      (select order_no from sp_sales_order);
select *
from `platform-dist`.dist_inventory_operation_log
where distributor_code = '1003682'
  and material_no = '109-23350202'
  and quantity = 117

select *
from sp_refund_order
where order_source = 'IMPORT';
select distinct order_source
from sp_refund_order;


SELECT o.*
FROM sp_sales_order o
         JOIN sp_sales_order_item i
              ON o.order_no = i.sales_order_no
WHERE FROM_UNIXTIME(o.order_time / 1000) >=
      '2026-04-06'
  AND FROM_UNIXTIME(o.order_time / 1000) <=
      '2026-04-12'
  AND o.status = 'FINISHED'
  AND order_owner = '12575';
SELECT r.order_owner,
       -SUM(f.count) count,
       -SUM(f.total) total
FROM sp_refund_order r
         JOIN sp_refund_order_item f
              ON r.order_no = f.refund_order_no
WHERE FROM_UNIXTIME(r.order_time / 1000) >=
      '2026-04-06'
  AND r.order_time <
      UNIX_TIMESTAMP(DATE_ADD('2026-04-12',
                              INTERVAL 1 DAY)) *
      1000
  AND r.status = 'FINISHED'
  AND order_owner = '12575'
GROUP BY r.order_owner;

SELECT SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            NOW(),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS cy_dist_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            NOW(),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS cy_retail_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(DATE_FORMAT(
                            DATE_SUB(NOW(),
                                     INTERVAL 1
                                     YEAR),
                            '%Y-01-01 00:00:00')) *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(DATE_SUB(
                               NOW(), INTERVAL 1
                               YEAR)) * 1000
                   THEN d.sales_amount
               ELSE 0 END) AS py_sales
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
WHERE s.company_no = '1000885'
  AND d.stat_time >= UNIX_TIMESTAMP(DATE_FORMAT(
        DATE_SUB(NOW(), INTERVAL 1 YEAR),
        '%Y-01-01 00:00:00')) * 1000;

SELECT SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(CONCAT(
                            '2026-01-01',
                            ' 00:00:00')) * 1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(CONCAT(
                               '2026-04-22',
                               ' 23:59:59')) *
                       1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS cy_dist_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(CONCAT(
                            '2026-01-01',
                            ' 00:00:00')) * 1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(CONCAT(
                               '2026-04-22',
                               ' 23:59:59')) *
                       1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS cy_retail_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP(CONCAT(
                            '2025-01-01',
                            ' 00:00:00')) * 1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP(CONCAT(
                               '2025-04-22',
                               ' 23:59:59')) *
                       1000
                   THEN d.sales_amount
               ELSE 0 END) AS py_sales
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
WHERE s.company_no = '1000885'
  AND d.stat_time >=
      UNIX_TIMESTAMP(CONCAT('2025-01-01',
                            ' 00:00:00')) * 1000
  AND d.stat_time <=
      UNIX_TIMESTAMP(CONCAT('2026-04-22',
                            ' 23:59:59')) * 1000;

SELECT SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP('2026-01-01 00:00:00') *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP('2026-04-22 23:59:59') *
                       1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS cy_dist_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP('2026-01-01 00:00:00') *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP('2026-04-22 23:59:59') *
                       1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS cy_retail_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP('2025-01-01 00:00:00') *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP('2025-04-22 23:59:59') *
                       1000
                   AND
                    s.store_extend = 'DIST_STORE'
                   THEN d.sales_amount
               ELSE 0 END) AS py_dist_sales,
       SUM(CASE
               WHEN d.stat_time >=
                    UNIX_TIMESTAMP('2025-01-01 00:00:00') *
                    1000
                   AND d.stat_time <=
                       UNIX_TIMESTAMP('2025-04-22 23:59:59') *
                       1000
                   AND (s.store_extend !=
                        'DIST_STORE' OR
                        s.store_extend IS NULL)
                   THEN d.sales_amount
               ELSE 0 END) AS py_retail_sales
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
WHERE s.company_no = '1000885'
  AND d.stat_time >=
      UNIX_TIMESTAMP('2025-01-01 00:00:00') * 1000
  AND d.stat_time <=
      UNIX_TIMESTAMP('2026-04-22 23:59:59') *
      1000;

SELECT d.store_id,
       s.name,
       s.store_extend,
       sum(d.sales_amount)
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
WHERE s.company_no = '1000885'
  AND d.stat_time >=
      UNIX_TIMESTAMP(CONCAT('2026-01-01',
                            ' 00:00:00')) * 1000
  AND d.stat_time <=
      UNIX_TIMESTAMP(CONCAT('2026-04-22',
                            ' 23:59:59')) * 1000
group by s.id;
SELECT d.store_id,
       s.name,
       s.store_extend,
       sum(d.sales_amount)
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
WHERE s.company_no = '1000885'
  AND d.stat_time >=
      UNIX_TIMESTAMP(CONCAT('2025-01-01',
                            ' 00:00:00')) * 1000
  AND d.stat_time <=
      UNIX_TIMESTAMP(CONCAT('2025-04-22',
                            ' 23:59:59')) * 1000
group by s.id;
select d.store_id, sum(d.sales_amount)
from sp_store_product_stat d
         join sp_store_info s on d.store_id = s.id
where s.company_no = '1000885'
  and d.stat_time >=
      UNIX_TIMESTAMP(CONCAT('2026-01-01',
                            ' 00:00:00')) * 1000
  and d.stat_time <=
      UNIX_TIMESTAMP(CONCAT('2026-04-22',
                            ' 23:59:59')) * 1000
group by d.store_id;



SELECT d.material_no,
       p.name,
       sum(d.sales_amount)
FROM `platform-store`.sp_store_product_stat d
         JOIN `platform-store`.sp_store_info s
              ON d.store_id = s.id
         join `platform-store`.sp_product p
              on d.material_no = p.material_no
WHERE s.company_no = '1000885'
  AND d.stat_time >=
      UNIX_TIMESTAMP(CONCAT('2026-01-01',
                            ' 00:00:00')) * 1000
  AND d.stat_time <=
      UNIX_TIMESTAMP(CONCAT('2026-04-22',
                            ' 23:59:59')) * 1000
group by d.material_no;

select sum(if(business_status = 'OP', 1,
              0))                            yingye,
       sum(if(business_status = 'OS', 1, 0)) wait,
       sum(if(business_status = 'DE', 1,
              0))                            zhuangxiu,
       sum(if(business_status = 'RD', 1,
              0))                            chongzhuang,
       sum(if(store_extend in
              ('FLAGSHIP_STORE', 'FORMAL_STORE',
               'KA_FLAGSHIP_STORE',
               'KA_FORMAL_STORE', 'KA_CHANNEL'),
              1, 0))                         guanfang
from sp_store_info
where company_no = '1000885';

select store_extend,count(*)
from sp_store_info
where store_extend in
      ('FLAGSHIP_STORE', 'FORMAL_STORE',
       'KA_FLAGSHIP_STORE', 'KA_FORMAL_STORE')
  and delete_flag <> 1
  and company_no = '1000885' group by store_extend;
select i.store_extend,count(distinct i.id) count,sum(p.sales_amount) amount from sp_store_product_stat p join sp_store_info i on p.store_id = i.id
where i.store_extend in
      ('FLAGSHIP_STORE', 'FORMAL_STORE',
       'KA_FLAGSHIP_STORE', 'KA_FORMAL_STORE')
  and i.delete_flag <> 1
  and i.company_no = '1000885' group by i.store_extend;

select i.channel_type,count(distinct i.id) count,sum(p.sales_amount) amount from sp_store_product_stat p join sp_store_info i on p.store_id = i.id
where i.channel_type in
      ('GENERAL', 'SHOPPING_MALL',
       'THREE_C', 'REGION_HOUSEHOLD','BUILDING_MATERIALS')
  and i.delete_flag <> 1
  and i.company_no = '1000885' group by i.channel_type;

select sum(if(business_status='OP',1,0)) yingye,sum(if(business_status='OS',1,0)) wait,sum(if(business_status='DE',1,0)) zhuangxiu,
sum(if(business_status='RD',1,0)) chongzhuang,sum(if(store_extend in ('FLAGSHIP_STORE','FORMAL_STORE','KA_FLAGSHIP_STORE','KA_FORMAL_STORE','KA_CHANNEL'),1,0)) guanfang
       from `platform-store`.sp_store_info where company_no = '1001167'  and delete_flag <> 1;
select * from sp_store_info where store_no = '9004330';
select * from sp_store_product_stat where store_id = 6321 and stat_time = '1743868800000';

select * from sp_attendance_record_data_ehr;

select * from sp_base_organization where org_name in ('苏皖大区','合肥分部');-- 21 23
# NANJING HEFEI
update sp_store_info set sales_region = 'NANJING' where sales_region = 'HEFEI' and delete_flag = 1;
update sp_biz_staff set sales_region = 'NANJING' where sales_region = 'HEFEI';
update sp_store_info set org_id = 21 where org_id = 23;
update sp_base_organization_store set org_id = 21 where org_id = 23 and delete_flag = 0;
update sp_base_organization_user set org_id = 21 where org_id = 23 and delete_flag = 0;
update sp_base_organization_customer set org_id = 21 where org_id = 23 and delete_flag = 0;

select * from sp_store_info group by store_no having count(*) >1;
select * from sp_store_info where store_no in
                            (
'9001875',
'9002194',
'9002308',
'9002311',
'TX0205'
                                ) and delete_flag = 1 order by store_no;
update sp_store_info set store_no = concat(store_no,'00'),name=concat(name,'(禁用)') where id = 157;
update sp_store_info set store_no = concat(store_no,'00'),name=concat(name,'(禁用)') where id = 7;
update sp_store_info set store_no = concat(store_no,'00') where id in (482,337,168);

select * from sp_patrol_store_record where patrol_date >= '1778428800000';
select * from sp_patrol_store_report where record_id in (select id from sp_patrol_store_record where patrol_date >= '1778428800000');
select * from sp_patrol_store_voucher where report_id in (select id from sp_patrol_store_report where record_id in (select id from sp_patrol_store_record where patrol_date >= '1778428800000'));
select * from sp_store_info where id > 6734;
select * from sp_biz_staff where sp_biz_staff.create_time > 1773648537703;
select * from sp_task;

select * from sp_attendance_record_data_ehr where employee_code = 'T5024';

select * from sp_task;
select * from sp_task_log;
select * from sp_task_history;

select * from sp_biz_staff where org_id = 23;
select * from `platform-dist`.dist_distributor where org_id = 23;
update sp_biz_staff set org_id = 21 where org_id = 23;
update `platform-dist`.dist_distributor set org_id = 21 where org_id = 23;


select * from sp_biz_staff where name = '季甜甜';-- 366
select * from sp_user_staff_relation where uid = 366;-- tdm_id 456

select * from sp_task;

select * from sp_sales_order_item order by id desc ;

select *
from sp_sales_order
where order_time >= '1780243200000'
  and order_time < '1780502400000'
  AND audit_mode = 'INTELLIGENT_ORDER_REVIEW'
    and intelligent_review_status = '1';

select * from sp_store_terminal_verify_voucher_record where order_no = '601780500723086836258';
select * from sp_store_terminal_verify_record where record_id = '651823718426742784';
select * from sp_store_terminal_verify_material_record where record_id = '651823718426742784';
select * from sp_store_terminal_verify_name_record where record_id = '651823718426742784';
select * from sp_store_terminal_verify_sn_record where record_id = '651823718426742784';

select
       a.order_no 订单号,
       a.ticket_ocr_result ocr识别结果,
       a.order_date_value 订单日期,
       a.order_date_ticket_value ocr日期,
       a.order_date_verify_result 日期结果,
       a.order_amount_value 订单金额,
       a.order_amount_ticket_value ocr金额,
       a.order_amount_verify_result 金额结果,
       a.signet_ticket_value 是否识别到签章,
       a.signet_verify_result 签章结果,
       a.signet_text_value 签章系统文本,
       a.signet_text_ticket_value 签章ocr文本,
       a.signet_text_verify_result 签章文本结果,
       b.sales_voucher_no 凭证号,
       b.ticket_value ocr凭证号,
       b.verify_result 凭证结果,
       c.tineco_product_material 商品编码,
       c.sales_product_material 商品销售编码,
       c.ticket_value ocr商品编码,
       c.verify_result 商品结果,
       d.tineco_product_name 商品名称,
       d.sales_product_name 商品销售名称,
       d.ticket_value ocr商品名称,
       d.verify_result 商品结果,
       e.sales_sn 订单sn,
       e.ticket_value ocr订单sn,
       e.verify_result 订单sn结果
from sp_store_terminal_verify_record a
join sp_store_terminal_verify_voucher_record b on a.record_id = b.record_id
join sp_store_terminal_verify_material_record c on a.record_id = c.record_id
join sp_store_terminal_verify_name_record d on a.record_id = d.record_id
join sp_store_terminal_verify_sn_record e on a.record_id = e.record_id
where a.order_no in (
    select sp_sales_order.order_no
from sp_sales_order
where order_time >= '1780243200000'
  and order_time < '1780502400000'
  AND audit_mode = 'INTELLIGENT_ORDER_REVIEW'
    and intelligent_review_status = '1' and order_no not in ('601780294359997931259','601780307705576131255','601780471648680225265')
    ) or a.record_id in ('651719211231481856','651718876119175168','652372283024740352');

select * from sp_sales_order where www_order_no = '780744990121953828986';






