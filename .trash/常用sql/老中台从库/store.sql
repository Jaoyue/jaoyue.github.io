select *
from sp_base_organization;
select *
from sp_base_organization_customer;

select *
from sp_sales_order
where www_order_no = '754304706671459113555';
select *
from sp_sales_order
where order_time >= 1753372800000;
select *
from sp_sales_order_item
where sales_order_no in (select order_no
                         from sp_sales_order
                         where order_time >= 1753372800000);
select *
from sp_sn_list
where sales_order_no in (select order_no
                         from sp_sales_order
                         where order_time >= 1753372800000);
select *
from sp_sales_daily_stat_v2
where stat_time >= 1753372800000;
select *
from sp_store_product_stat
where stat_time >= 1753372800000;

select *
from sp_order_voucher
where order_no = '601755418414806574259';

select i.company_no, sum(sales_count) count
from sp_store_product_stat s
         join sp_store_info i on s.store_id = i.id
where s.stat_time >= 1753113600000
group by s.material_no;
select * from sp_config_enum;
select *
from sp_customer_bill_info
where customer_id = 1710608;
SELECT VERSION();
select i.store_no,
       i.name,
       i.shop_code,
       m.shop_name,
       i.delete_flag
from sp_store_info i
         left join sp_shop_mould m
                   on i.shop_code = m.shop_code
order by i.delete_flag
select *
from sp_train_task_work
update sp_train_task_work

select b.id,
       b.work_no,
       b.name,
       c.company_no,
       c.company_name,
       b.staff_status
from sp_biz_staff_company c
         join sp_biz_staff b on c.staff_id = b.id

select *
from sp_clerk_feedback_info
where feedback_no = 'E1746710469443056263'
  and id = 328
delete
from sp_clerk_feedback_info
where feedback_no = 'E1746710469443056263'
  and id = 328;

INSERT INTO `platform-store`.sp_clerk_feedback_info (id,
                                                     feedback_no,
                                                     type,
                                                     clerk_id,
                                                     store_id,
                                                     content,
                                                     creater,
                                                     create_time,
                                                     modifier,
                                                     modify_time,
                                                     version,
                                                     status,
                                                     record_id,
                                                     done_status)
VALUES (328, 'E1746710469443056263', 'TRAINING',
        13954, 578,
        '智能培训，太不智能了，线下实体没有这么去和顾客讲解的，办公室坐着的领导，你们可以自己看一下你们的智能培训，你们自己给自己智能培训一下吧，给我们培训的线下实体都不会卖货了',
        '13954', 1746710469444, '168',
        1746755520242, 1, null, 1746710482577,
        'C');

select *
from sp_sales_order
where order_no = '601699527754465866266'
select *
from sp_sales_order_item
where sales_order_no = '601699527754465866266'

select *
from sp_config
where `key` = 'api.trust.ips'

select ua.user_id,
       ua.staff_name,
       position,
       a.user_group,
       a.name,
       a.category_id,
       a.start_time,
       a.end_time,
       p.total_score,
       ua.start_time as beginTime,
       ua.end_time   as commitTime,
       ua.status,
       u.user_name   as userAccount,
       a.name        as examName,
       a.exam_time,
       p.total_question,
       uq.finishNum,
       ua.id,
       ua.score,
       uq.incorrectNum,
       u.user_type,
       ua.score_level,
       ua.id         as userExamId,
       ua.mark_status,
       a.status      as examStatus,
       ua.exam_id,
       ua.total_num  as totalNum,
       a.show_explation_after_all_finished,
       u.sales_region
from sp_train_user_exam ua
         join sp_train_exam a on ua.exam_id = a.id
         join sp_train_exam_paper p
              on p.id = ua.paper_id
         left join (select user_exam_id,
                           sum(if(
                                   user_answer is not null,
                                   1,
                                   0))                   as finishNum,
                           sum(if(is_correct = 0, 1, 0)) as incorrectNum
                    from sp_train_user_paper_question
                    group by user_exam_id) uq
                   on uq.user_exam_id = ua.id
         join sp_biz_staff u ON u.id = ua.user_id
where a.type = 'normal'
  and a.category_id in
      (137, 136, 2, 3, 4, 5, 8, 129, 128, 131, 11,
       130, 12, 133, 132, 13, 135, 134, 21, 20,
       22, 31, 33, 38, 39, 36, 37, 43, 41, 46, 44,
       50, 48, 54, 52, 68, 67, 76, 78, 79, 73, 74,
       85, 87, 81, 83, 93, 95, 89, 91, 103, 101,
       99, 97, 110, 111, 108, 109, 106, 107, 105,
       119, 118, 117, 116, 115, 114, 113, 112,
       127, 126, 125, 124, 123, 122, 121, 120)
  and find_in_set(ua.status, 'doing,todo,again')
  and ua.user_id = '10667'
order by ua.create_time desc

select *
from sp_biz_staff
where name = '王秀琴'
select ua.user_id,
       ua.staff_name,
       position,
       a.user_group,
       a.name,
       a.category_id,
       a.start_time,
       a.end_time,
       p.total_score,
       ua.start_time as beginTime,
       ua.end_time   as commitTime,
       ua.status,
       u.user_name   as userAccount,
       a.name        as examName,
       a.exam_time,
       p.total_question,
       uq.finishNum,
       ua.id,
       ua.score,
       uq.incorrectNum,
       u.user_type,
       ua.score_level,
       ua.id         as userExamId,
       ua.mark_status,
       a.status      as examStatus,
       ua.exam_id,
       ua.total_num  as totalNum,
       a.show_explation_after_all_finished,
       u.sales_region
from sp_train_user_exam ua
         join sp_train_exam a on ua.exam_id = a.id
         join sp_train_exam_paper p
              on p.id = ua.paper_id
         left join (select user_exam_id,
                           sum(if(
                                   user_answer is not null,
                                   1,
                                   0))                   as finishNum,
                           sum(if(is_correct = 0, 1, 0)) as incorrectNum
                    from sp_train_user_paper_question
                    group by user_exam_id) uq
                   on uq.user_exam_id = ua.id
         join sp_biz_staff u ON u.id = ua.user_id
where a.type = 'normal'
  and a.category_id in
      (137, 136, 2, 3, 4, 5, 8, 129, 128, 131, 11,
       130, 12, 133, 132, 13, 135, 134, 21, 20,
       22, 31, 33, 38, 39, 36, 37, 43, 41, 46, 44,
       50, 48, 54, 52, 68, 67, 76, 78, 79, 73, 74,
       85, 87, 81, 83, 93, 95, 89, 91, 103, 101,
       99, 97, 110, 111, 108, 109, 106, 107, 105,
       119, 118, 117, 116, 115, 114, 113, 112,
       127, 126, 125, 124, 123, 122, 121, 120)
  and find_in_set(ua.status, 'commit')
  and ua.user_id = '10257'
order by ua.create_time desc

select ua.user_id,
       ua.staff_name,
       position,
       a.user_group,
       a.name,
       a.category_id,
       a.start_time,
       a.end_time,
       p.total_score,
       ua.start_time as beginTime,
       ua.end_time   as commitTime,
       ua.status,
       u.user_name   as userAccount,
       a.name        as examName,
       a.exam_time,
       p.total_question,
       uq.finishNum,
       ua.id,
       ua.score,
       uq.incorrectNum,
       u.user_type,
       ua.score_level,
       ua.id         as userExamId,
       ua.mark_status,
       a.status      as examStatus,
       ua.exam_id,
       ua.total_num  as totalNum,
       a.show_explation_after_all_finished,
       u.sales_region
from sp_train_user_exam ua
         join sp_train_exam a on ua.exam_id = a.id
         join sp_train_exam_paper p
              on p.id = ua.paper_id
         left join (select user_exam_id,
                           sum(if(
                                   user_answer is not null,
                                   1,
                                   0))                   as finishNum,
                           sum(if(is_correct = 0, 1, 0)) as incorrectNum
                    from sp_train_user_paper_question
                    group by user_exam_id) uq
                   on uq.user_exam_id = ua.id
         join sp_biz_staff u ON u.id = ua.user_id
where a.type = 'normal'
  and a.category_id in
      (137, 136, 2, 3, 4, 5, 8, 129, 128, 131, 11,
       130, 12, 133, 132, 13, 135, 134, 21, 20,
       22, 31, 33, 38, 39, 36, 37, 43, 41, 46, 44,
       50, 48, 54, 52, 68, 67, 76, 78, 79, 73, 74,
       85, 87, 81, 83, 93, 95, 89, 91, 103, 101,
       99, 97, 110, 111, 108, 109, 106, 107, 105,
       119, 118, 117, 116, 115, 114, 113, 112,
       127, 126, 125, 124, 123, 122, 121, 120)
  and find_in_set(ua.status, 'doing,todo,again')
  and ua.user_id = '13871'
order by ua.create_time desc
SELECT *
FROM temp.`temp_slow_sql` a
ORDER BY a.id DESC;
select ssi.store_no                       门店编码,
       ssi.name                           门店名称,
       r.company_no                       公司编码,
       r.company_name                     公司名称,
       FROM_UNIXTIME(r.start_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 开始时间,
       FROM_UNIXTIME(r.end_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 结束时间
from sp_store_company_record r
         join sp_store_info ssi
              on r.store_id = ssi.id
where r.delete_flag = 0
order by ssi.store_no;

select ua.user_id,
       ua.staff_name,
       position,
       a.user_group,
       a.name,
       a.category_id,
       a.start_time,
       a.end_time,
       p.total_score,
       ua.start_time as beginTime,
       ua.end_time   as commitTime,
       ua.status,
       u.user_name   as userAccount,
       a.name        as examName,
       a.exam_time,
       p.total_question,
       uq.finishNum,
       ua.id,
       ua.score,
       uq.incorrectNum,
       u.user_type,
       ua.score_level,
       ua.id         as userExamId,
       ua.mark_status,
       a.status      as examStatus,
       ua.exam_id,
       ua.total_num  as totalNum,
       a.show_explation_after_all_finished,
       u.sales_region
from sp_train_user_exam ua
         join sp_train_exam a on ua.exam_id = a.id
         join sp_train_exam_paper p
              on p.id = ua.paper_id
         left join (select user_exam_id,
                           sum(if(
                                   user_answer is not null,
                                   1,
                                   0))                   as finishNum,
                           sum(if(is_correct = 0, 1, 0)) as incorrectNum
                    from sp_train_user_paper_question
                    group by user_exam_id) uq
                   on uq.user_exam_id = ua.id
         join sp_biz_staff u ON u.id = ua.user_id
where a.type = 'normal'
  and a.category_id in
      (137, 136, 2, 3, 4, 5, 8, 129, 128, 131, 11,
       130, 12, 133, 132, 13, 135, 134, 21, 20,
       22, 31, 33, 38, 39, 36, 37, 43, 41, 46, 44,
       50, 48, 54, 52, 68, 67, 76, 78, 79, 73, 74,
       85, 87, 81, 83, 93, 95, 89, 91, 103, 101,
       99, 97, 110, 111, 108, 109, 106, 107, 105,
       119, 118, 117, 116, 115, 114, 113, 112,
       127, 126, 125, 124, 123, 122, 121, 120)
  and find_in_set(ua.status, 'todo,doing,again')
  and ua.user_id = '12786'
order by ua.create_time desc
select *
from sp_biz_staff
where id = 12786

select *
from sp_order_voucher
where order_no = '601757057769008121263'

select ua.user_id,
       ua.staff_name,
       position,
       a.user_group,
       a.name,
       a.category_id,
       a.start_time,
       a.end_time,
       p.total_score,
       ua.start_time as beginTime,
       ua.end_time   as commitTime,
       ua.status,
       u.user_name   as userAccount,
       a.name        as examName,
       a.exam_time,
       p.total_question,
       uq.finishNum,
       ua.id,
       ua.score,
       uq.incorrectNum,
       u.user_type,
       ua.score_level,
       ua.id         as userExamId,
       ua.mark_status,
       a.status      as examStatus,
       ua.exam_id,
       ua.total_num  as totalNum,
       a.show_explation_after_all_finished,
       u.sales_region
from sp_train_user_exam ua
         join sp_train_exam a on ua.exam_id = a.id
         join sp_train_exam_paper p
              on p.id = ua.paper_id
         left join (select user_exam_id,
                           sum(if(
                                   user_answer is not null,
                                   1,
                                   0))                   as finishNum,
                           sum(if(is_correct = 0, 1, 0)) as incorrectNum
                    from sp_train_user_paper_question
                    group by user_exam_id) uq
                   on uq.user_exam_id = ua.id
         join sp_biz_staff u ON u.id = ua.user_id
where a.type = 'normal'
  and a.category_id in
      (137, 136, 139, 2, 138, 3, 4, 141, 140, 5,
       142, 8, 129, 128, 131, 11, 130, 12, 133,
       132, 13, 135, 134, 21, 20, 22, 31, 33, 38,
       39, 36, 37, 43, 41, 46, 44, 50, 48, 54, 52,
       68, 67, 76, 78, 79, 73, 74, 85, 87, 81, 83,
       93, 95, 89, 91, 103, 101, 99, 97, 110, 111,
       108, 109, 106, 107, 105, 119, 118, 117,
       116, 115, 114, 113, 112, 127, 126, 125,
       124, 123, 122, 121, 120)
  and find_in_set(ua.status, 'todo,doing,again')
  and ua.user_id = '12661'
order by ua.create_time desc

select *
from sp_attendance_record
select *
from sp_store_info
where delete_flag != 1
select *
from sp_store_info
where delete_flag = 0

select *
from v_store
where 分销商编号 = '1004093'
select *
from sp_biz_staff
where work_no = 'J1141';


select concat(o.order_no,'') 订单号,
       o.status,
       i.store_no,
       i.name,
       i.store_extend,
       i.sales_region,
       FROM_UNIXTIME(o.order_time/1000,'%Y-%m-%d %H:%i:%s') 订单时间,
       o.customer_name,
       o.customer_mobile,
       o.customer_address,
       o.shop_type,
       oi.count,
       oi.sn,
       o.refund_status
from sp_sales_order o
         join sp_store_info i on o.store_id = i.id
         join sp_sales_order_item oi
              on o.order_no = oi.sales_order_no
where oi.material_no = '109-23430001' and o.order_time >= 1725120000000
and o.order_time < 1759248000000 and oi.sn like '%,%' and oi.count >10;

select * from sp_product;

SELECT
    CONCAT(o.order_no, '') AS 订单号,
    o.status,
    i.store_no,
    i.name,
    i.store_extend,
    i.sales_region,
    FROM_UNIXTIME(o.order_time/1000, '%Y-%m-%d %H:%i:%s') AS 订单时间,
    o.customer_name,
    o.customer_mobile,
    o.customer_address,
    o.shop_type,
    oi.count,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(oi.sn, ',', ht.help_topic_id + 1), ',', -1)) AS sn,
    o.refund_status
FROM
    sp_sales_order o
JOIN
    sp_store_info i ON o.store_id = i.id
JOIN
    sp_sales_order_item oi ON o.order_no = oi.sales_order_no
JOIN
    mysql.help_topic ht ON ht.help_topic_id < LENGTH(oi.sn) - LENGTH(REPLACE(oi.sn, ',', '')) + 1
WHERE
    oi.material_no = '109-23430001' and o.status = 'FINISHED'
    AND o.order_time >= 1725120000000
    AND o.order_time < 1759248000000
    AND oi.sn LIKE '%,%';

select * from sp_sales_order order by id desc limit 100;
select distinct delete_flag from sp_store_info;
select * from sp_store_company_record;

SELECT * FROM sp_sn_list;

select `key`,value from `platform-store`.sp_config_enum where type = 'DISTRIBUTOR_SALE_AREA';

select * from sp_customer_info where mobile ='18862133633'

select order_owner 导购id,b.work_no 导购工号,b.name 导购名,sum(t.count) 销量,sum(t.total) 销额 from
(select o.order_owner,sum(i.count) count,sum(i.total) total from sp_sales_order o join sp_sales_order_item i on o.order_no = i.sales_order_no
where year(o.order_time) = '2025' and material_no in ('109-23430001','109-25630101')
group by o.order_owner
union all
select r.order_owner,-sum(f.count) count,-sum(f.total) total from sp_refund_order r join sp_refund_order_item f on r.order_no = f.refund_order_no
where year(r.order_time) = '2025' and material_no in ('109-23430001','109-25630101')
group by r.order_owner) t join sp_biz_staff b on t.order_owner = b.id group by t.order_owner


select
  order_owner 导购id,
  b.work_no 导购工号,
  b.name 导购名,
  sum(t.count) 销量,
  sum(t.total) 销额
from
(
  -- 销售单部分：毫秒时间戳转日期后提取年份
  select
    o.order_owner,
    sum(i.count) count,
    sum(i.total) total
  from sp_sales_order o
  join sp_sales_order_item i on o.order_no = i.sales_order_no
  -- 核心修改：FROM_UNIXTIME(时间戳/1000) 把毫秒转秒后转日期，再用YEAR提取年份
  where FROM_UNIXTIME(o.order_time/1000) >= '2025-01-01' and FROM_UNIXTIME(o.order_time/1000) <= '2026-01-01'
    and material_no in ('109-23430001','109-25630101')
  group by o.order_owner

  union all

  -- 退款单部分：同样处理毫秒时间戳
  select
    r.order_owner,
    -sum(f.count) count,
    -sum(f.total) total
  from sp_refund_order r
  join sp_refund_order_item f on r.order_no = f.refund_order_no
  where FROM_UNIXTIME(r.order_time/1000) >= '2025-01-01' and FROM_UNIXTIME(r.order_time/1000) <= '2026-01-01'
    and material_no in ('109-23430001','109-25630101')
  group by r.order_owner
) t
join sp_biz_staff b on t.order_owner = b.id
group by t.order_owner, b.work_no, b.name; -- 补充分组字段，避免语法报错

select distinct sales_region from sp_store_info where workspace_type = 'NEW_BUSINESS' and delete_flag <> 1;

select sum(sales_amount_average-refund_amount_average) from sp_sales_daily_stat_v2 where stat_time >= 1767196800000;
select sum(sales_amount) from sp_store_product_stat where stat_time >= 1767196800000;

select * from sp_store_terminal_approval_config_rules where terminal_name = '苏州办事处2';
select * from sp_store_info where store_no = '9003904';
select * from sp_store_product_stat where store_id = 6151 and material_no = '109-23430001'
and stat_time >= 1768406400000 and stat_time < 1769875200000;

select * from sp_refund_order where order_no = '621767921250922313262';

select * from sp_store_product where material_no = '115-24350101' and store_id = 5701;
select * from `platform-store`.sp_store_info where store_no = '9003463';
select * from `platform-dist`.dist_config;

select *,product_classification from sp_product;

select * from sp_store_prototype_poll where create_time > 1772294400000;
select * from sp_sales_order where order_no = '601770963457737088218'

-- SHIJIAZHUANG
select * from sp_biz_staff where sales_region = 'NHUABEI';
update sp_biz_staff set sales_region = 'SHIJIAZHUANG',org_id = 43 where sales_region = 'NHUABEI';
update sp_biz_staff set sales_region = 'DONGBEI',org_id = 35 where sales_region = 'HAERBIN';
update sp_base_organization_user set org_id = 43 where org_id = 41;
update sp_base_organization_user set org_id = 35 where org_id = 36;

select * from sp_base_organization where org_name = '北京分部';-- 41
select * from sp_base_organization where org_name = '京津冀大区';-- 43
select * from sp_base_organization where org_name = '长春分部';-- 36
select * from sp_base_organization where org_name = '辽吉大区';-- 35

select * from sp_base_organization_user where org_id = 41;
update sp_base_organization_user set org_id = 43 where org_id = 41;
select * from sp_base_organization_user where org_id = 36;
update sp_base_organization_user set org_id = 35 where org_id = 36;

select * from sp_store_info where sales_region = 'NHUABEI' and delete_flag = 1;
select * from sp_store_info where sales_region = 'HAERBIN' and delete_flag = 1;
update sp_store_info set sales_region = 'SHIJIAZHUANG',org_id = 43 where sales_region = 'NHUABEI' and delete_flag = 1;
update sp_store_info set sales_region = 'DONGBEI',org_id = 35 where sales_region = 'HAERBIN' and delete_flag = 1;
update sp_base_organization_store set org_id = 43 where org_id = 41;
update sp_base_organization_store set org_id = 35 where org_id = 36;

select * from sp_sign_record where user_type = 'CLERK'  order by id desc;
select * from sp_sign_record where (remark is null or remark = '') order by id desc;

select distinct start_model from sp_attendance_record where start_model like 'iP%';

select * from sp_sign_record where user_type = 'CLERK' and (remark is null or remark = '')  and sign_time >= 1735660800000 and sign_time <= 1767801600000;
SELECT
  concat('`platform-store`.', TABLE_NAME) AS 表名,
  TABLE_COMMENT AS 表注释
FROM
  INFORMATION_SCHEMA.TABLES
WHERE
  TABLE_SCHEMA = 'platform-store'
  AND TABLE_TYPE = 'BASE TABLE'
having 表注释 <> ''
ORDER BY TABLE_NAME;
select * from `platform-store`.sp_base_organization_area_config;

select * from sp_clerk_feedback_info  where create_time >= 1767196800000;
select * from sp_clerk_feedback_reply where feedback_no in (select sp_clerk_feedback_info.feedback_no from sp_clerk_feedback_info where create_time >= 1767196800000)
;

select order_no,store_id,b.name store_name,b.sales_region,order_amount,FROM_UNIXTIME(order_time/1000) order_time from sp_sales_order a,sp_store_info b where a.store_id=b.id and order_time >= 1735660800000 and order_time < 1736006400000
union all
select order_no,store_id,b.name store_name,b.sales_region,order_amount,FROM_UNIXTIME(order_time/1000) order_time from sp_sales_order a,sp_store_info b where a.store_id=b.id and order_time >= 1767196800000 and order_time < 1767542400000;

-- 109-25630101
select * from sp_store_promotion_product_price where material_no = '109-25630101' and store_no = '9004862';

select * from sp_task where id = 13;
select * from sp_store_info where store_no = '9000423';
select * from sp_clerk_feedback_info;
select * from sp_base_organization;
select p.*,s.name from sp_store_product_stat p join sp_store_info s on p.store_id = s.id
where s.org_id = 48 and p.stat_time = 1775491200000;

select * from sp_store_product_stat where store_id in (4711) and stat_time = 1775491200000;

select distinct  from sp_sign_pic ;
select * from sp_sign_pic;

select * from sp_product_terminal_info where terminal_id not in (select store_no from sp_store_info);
select * from sp_product_terminal_info where terminal_id = '9200107';