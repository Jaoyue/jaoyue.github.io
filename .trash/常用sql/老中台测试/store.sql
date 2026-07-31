CREATE VIEW v_tk_counts AS
SELECT
    store_id,
    SUM(tk_count) AS tk_count
FROM
    (
        SELECT
            p.store_id,
            COUNT(p.staff_id) AS tk_count
        FROM
            sp_biz_staff_store_permission p
        JOIN
            sp_biz_staff b ON p.staff_id = b.id
        WHERE
            b.user_type = 'CLERK'
            AND b.staff_status = 'ENABLED'
            AND b.grade IN ('SALES_CONSULTANT', 'MIDDLE_SALES_CONSULTANT', 'HIGH_SALES_CONSULTANT', 'SHOP_MANAGER')
        GROUP BY
            p.store_id
        UNION ALL
        SELECT
            r.store_id,
            SUM(r.operate_num) AS tk_count
        FROM
            sp_clerk_oa_record r
        JOIN
            sp_biz_staff b ON r.clerk_no = b.work_no
            AND b.staff_status = 'ENABLED'
        WHERE
            r.clerk_grade IN ('SALES_CONSULTANT', 'MIDDLE_SALES_CONSULTANT', 'HIGH_SALES_CONSULTANT', 'SHOP_MANAGER')
            AND r.operate_type = 'delete'
            AND r.exec_flag = 0
        GROUP BY
            r.store_id
        UNION ALL
        SELECT
            r.store_id,
            SUM(r.operate_num) AS tk_count
        FROM
            sp_clerk_oa_record r
        WHERE
            r.clerk_grade IN ('SALES_CONSULTANT', 'MIDDLE_SALES_CONSULTANT', 'HIGH_SALES_CONSULTANT', 'SHOP_MANAGER')
            AND r.operate_type = 'create'
            AND r.exec_flag = 0
        GROUP BY
            r.store_id
    ) t1
GROUP BY
    t1.store_id;

select distinct delete_flag from sp_store_info;
select * from sp_product;
update sp_product set orientation = 'STRUCTURAL' where orientation is null;

select * from sp_sign_record order by id desc limit 100;

select * from sp_store_terminal_verify_record where record_id = '275878514970857472';

select * from sp_sales_order where pay_type is null;

select * from sp_product;

select l.sales_order_no,l.sn from sp_sales_order_item i join sp_sales_order o on i.sales_order_no = o.order_no join sp_sn_list l on o.order_no = l.sales_order_no where o.status = 'FINISHED' order by i.id desc limit 100

select * from sp_store_info where workspace_type = 'NEW_BUSINESS';
select * from sp_sales_order where order_no = '60176';

select * from sp_sales_daily_stat_v2 order by id desc limit 100;
select * from sp_store_product_stat where store_id = 6534 and stat_time = '1768752000000' order by id desc limit 100;

select p.material_no,
       p.`name`,
       p.product_classification,
       sum(sales_count),
       sum(sales_amount)
from sp_store_product_stat stat
         join sp_product p
              on stat.material_no = p.material_no
         join sp_store_info st
              on st.id = stat.store_id
where 1 = 1
  and stat.stat_time >= 1767196800000
  and stat.stat_time <= 1769875199999
  and st.`workspace_type` = 'NEW_BUSINESS'
  and st.store_extend in ('DEALER_STORE')
  and stat.store_id in (SELECT distinct si.id
                        FROM sp_store_info si
                        where si.ascription = 'ECOVACS'
                          and si.company_no != '5000004')
GROUP BY stat.material_no;

select * from `platform-store`.sp_biz_staff where id = 1;

select * from v_config_enum where enum_type = 'store_extend' and class_name = 'sp_store_info';

select * from sp_base_organization;

select org_id,customer_code from sp_base_organization_customer where delete_flag = 0 and org_id = 22
union all select org_id,customer_code from sp_base_organization_customer where delete_flag = 0 and org_id in (select id from sp_base_organization where delete_flag = 0 and parent_org_id = 22)

select org_id,customer_code from `platform-store`.sp_base_organization_customer t1 join(select id,
                                                                                               parent_org_id,
                                                                                               org_name
                                                                                        from `platform-store`.sp_base_organization
                                                                                        where delete_flag = 0
                                                                                          and parent_org_id = 2
                                                                                        union all
                                                                                        select id,
                                                                                               parent_org_id,
                                                                                               org_name
                                                                                        from `platform-store`.sp_base_organization
                                                                                        where delete_flag = 0
                                                                                          and parent_org_id in
                                                                                              (select id
                                                                                               from `platform-store`.sp_base_organization
                                                                                               where parent_org_id = 2)) t2 on t1.org_id = t2.id where t1.delete_flag = 0
select org_id,customer_code from `platform-store`.sp_base_organization_customer where delete_flag and org_id in
(select id from `platform-store`.sp_base_organization where delete_flag = 0 and parent_org_id = 3)
select customer_code org_id,customer_code from `platform-store`.sp_base_organization_customer where delete_flag = 0 and org_id = 3
;
select * from sp_biz_staff_company where staff_id = 399;
select company_no from sp_biz_staff_company where staff_id = 399;
select * from sp_biz_staff;
select * from sp_store_product_stat;
select * from sp_config_enum;

select c.customer_code as org_id,IF(d.customer_short_name IS NOT NULL AND d.customer_short_name != '',d.customer_short_name,d.distributor_name) org_name from `platform-store`.sp_base_organization_customer c join `platform-dist`.dist_distributor d on c.customer_code = d.distributor_code where c.delete_flag = 0 and c.org_id = 19

select org_id,customer_code from sp_base_organization_customer where org_id in (19) and delete_flag = 0

select org_id,customer_code from `platform-store`.sp_base_organization_customer where delete_flag and org_id in
(19);

select * from sp_store_terminal_approval_config_rules where delete_flag != 1;
select * from sp_store_terminal_approval_config_rules_basic;

select b.* from sp_store_terminal_approval_config_rules a
join sp_store_info f on a.terminal_id = f.store_no
join sp_sales_order b on f.id = b.store_id
where b.status = 'FINISHED' and
      b.order_type in ('RETAIL_ORDER','TRADE_ORDER')
and now() between a.start_time and a.end_time and a.status = 0
and a.audit_status in ('COMPLETED','LAPSE_TOBE_HEADQUARTERS_REVIEW')
and a.audit_mode = 'INTELLIGENT_ORDER_REVIEW'

    ;
select b.order_no from sp_store_terminal_approval_config_rules a
join sp_store_info f on a.terminal_id = f.store_no
join (select order_no,
             store_id,
             FROM_UNIXTIME(order_time / 1000,
                           '%Y-%m-%d %h:%i:%s') order_time
      from sp_sales_order o1 join sp_sales_order_item o2 on o1.order_no = o2.sales_order_no
      where o1.status = 'FINISHED' and o1.shop_type = 'F' and o1.refund_status is null
        and o1.order_type in
            ('RETAIL_ORDER', 'TRADE_ORDER')
        and o2.sn is not null and o2.sn != ''
        and o2.modify_time >= 1738371150000
        and o2.modify_time <= 1770084945596) b
     on f.id = b.store_id
where b.order_time between a.start_time and a.end_time and a.status = 0
and a.audit_status in ('COMPLETED','LAPSE_TOBE_HEADQUARTERS_REVIEW')
and a.audit_mode = 'INTELLIGENT_ORDER_REVIEW';
select * from sp_sales_order;
select * from sp_sign_pic where sign_id = 1261998 order by id desc ;
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'CUSTOMER_FORM', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/becd61bb-6b62-4f93-9b2d-1bc4f9c83c6c.jpg', '10928', 1770104873783, '10928', 1770104886511, 1, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'COMPETITOR_FEEDBACK', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/b7d12c8d-7e8f-418c-9f3b-fab9e0c7a0a2.jpg', '10928', 1770104869248, '10928', 1770104886510, 1, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'PERSONAL_CARE_AREA', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/47bfe363-1ae2-48b4-9d01-c3a05c5a1732.jpg', '10928', 1770104865509, '10928', 1770104886510, 1, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'FOOD_AREA', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/84cccb8d-ba84-4eac-80c5-c1b76858984a.jpg', '10928', 1770104861610, '10928', 1770104886509, 1, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'FLAGSHIP_PRODUCT', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/d9c2467e-82c1-4ab0-a707-396d746b7fc4.jpg', '10928', 1770104624510, '10928', 1770104886509, 2, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'HALL_FULL_VIEW', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/53587817-74dd-45c1-b0c6-c6a43ddad133.jpg', '10928', 1770104601341, '10928', 1770104886508, 2, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'CLEAN_AREA', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/cb0cab33-217e-426f-afa5-1c7327bfefe6.jpg', '10928', 1770104576562, '10928', 1770104886508, 2, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'HEADSHOT', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/2b96d726-6b1b-41ab-b75d-7c5899a16867.jpg', '10928', 1770104544945, '10928', 1770104886507, 2, 'CLERK10928', 1261998, 0, 0);
INSERT INTO `platform-store`.sp_sign_pic (type, url, creater, create_time, modifier, modify_time, version, user_id, sign_id, delete_flag, sign_flag) VALUES ( 'FULL_BODY', 'https://dbu-file.tineco.cn:7443/data/dbu/store/2026-02-03/32484897-c6b1-45be-a588-5c9c9bfd5f36.jpg', '10928', 1770104525157, '10928', 1770104886506, 2, 'CLERK10928', 1261998, 0, 0);

select * from sp_coral_flow;

create table sp_coral_flow
(
    id                       bigint auto_increment
        primary key,
    creater                  varchar(50)  not null comment 'creater',
    create_time              bigint       not null comment 'create_time',
    modifier                 varchar(50)  not null comment 'modifier',
    modify_time              bigint       not null comment 'modify_time',
    version                  bigint       not null comment 'version',
    name             varchar(200)  null comment '名称',
    app_code           varchar(100)  null comment 'app权限码',
    flow_id                    varchar(100) null comment '工作流id',
    flow_key            varchar(100) null comment '工作流key'
)
    comment '珊瑚工作流';
-- 删除sp_coral_flow表中的app_modules字段
ALTER TABLE sp_coral_flow
DROP COLUMN app_modules;
create table sp_coral_flow_config
(
    id                       bigint auto_increment
        primary key,
    creater                  varchar(50)  not null comment 'creater',
    create_time              bigint       not null comment 'create_time',
    modifier                 varchar(50)  not null comment 'modifier',
    modify_time              bigint       not null comment 'modify_time',
    version                  bigint       not null comment 'version',
    flow_id             bigint not null comment 'flow_id',
    app_modules           varchar(500)  null comment 'app组件',
    flow_modules                    text null comment '工作流组件'
)
    comment '珊瑚工作流配置';

-- 1. 给主表sp_coral_flow新增app组件、工作流组件字段（与原字表字段类型一致）
ALTER TABLE sp_coral_flow
ADD COLUMN delete_flag TINYINT(1) NOT NULL COMMENT 'delete_flag',
ADD COLUMN flow_modules TEXT NULL COMMENT '工作流组件';

-- 2. 删除无需保留的子表sp_coral_flow_config（彻底清理，执行前确认无数据需要迁移）
DROP TABLE IF EXISTS sp_coral_flow_config;

ALTER TABLE sp_coral_flow
ADD COLUMN flow_conversation_id VARCHAR(100) NULL COMMENT '会话id';

select * from sp_base_organization_customer where customer_code = '1002511';

select * from sp_sales_order where order_no = '601770257203996009014'; -- 1770257216416
select * from sp_sales_order_item where sales_order_no = '601770257203996009014';-- 1770257204002

select * from sp_base_organization where delete_flag = 1;

select * from sp_coral_flow;

create table sp_coral_flow_app_modules
(
    id                       bigint auto_increment
        primary key,
    creater                  varchar(50)  not null comment 'creater',
    create_time              bigint       not null comment 'create_time',
    modifier                 varchar(50)  not null comment 'modifier',
    modify_time              bigint       not null comment 'modify_time',
    version                  bigint       not null comment 'version',
    flow_id             bigint not null comment 'flow_id',
    module_code           varchar(100)  null comment 'app组件编码',
    module_type            varchar(100)  null comment '组件类型',
    module_name            varchar(100)  null comment '组件名称',
    module_sort            int(8)  null comment '组件顺序',
    field_name            varchar(100)  null comment '字段名称',
    parent_code           varchar(100)  null comment '父级编码',
    parent_field_name           varchar(100)  null comment '父级字段名称'
)
    comment '珊瑚工作流app组件';

ALTER TABLE sp_coral_flow_app_modules
ADD COLUMN is_multiple int(1) NULL COMMENT '是否多选';
select * from sp_coral_flow_app_modules where flow_id = 2;
select * from sp_coral_flow_app_modules;
select * from sp_coral_flow where app_code = 'mgr_api_company_manage_huikuan' and delete_flag = 0;
select * from sp_store_info; -- 10.108.128.219
select * from `platform-dist`.dist_config;

select *,product_classification from sp_product;

select sum(if(violation_type = '市场违规', 1,
              0)) weigui,
       count(distinct if(a.violation_type = '虚假订单', a.source_order_no, null)) xujia
from `platform-store`.sp_market_violation a join `platform-dist`.dist_distributor b
on a.company_no = b.distributor_code
where delete_flag = 0
and a.company_no = '1001683';

select * from sp_coral_flow;
select * from sp_coral_flow_app_modules;

SELECT
    s.company_no,
    COALESCE(NULLIF(d.customer_short_name, ''), d.distributor_name) AS '客户名称',
    COUNT(CASE WHEN s.business_status IN ('OP', 'OS', 'DE', 'RD') THEN 1 END) AS '官方店数',
    COUNT(CASE WHEN s.business_status = 'OP' THEN 1 END) AS '营业中(OP)',
    COUNT(CASE WHEN s.business_status = 'OS' THEN 1 END) AS '待开业(OS)',
    COUNT(CASE WHEN s.business_status = 'DE' THEN 1 END) AS '装修中(DE)',
    COUNT(CASE WHEN s.business_status = 'RD' THEN 1 END) AS '重装中(RD)'
FROM `platform-store`.sp_store_info s
LEFT JOIN `platform-dist`.dist_distributor d
    ON s.company_no = d.distributor_code
WHERE s.delete_flag = 0
    AND d.status = 'TAKE_EFFECT'
and if('' != '', s.workspace_type in (''), 1=1)
and if('' != '', s.sales_region in (''), 1=1)
and if('' != '', s.channel_type in (''), 1=1)
and if('' != '', s.store_extend in (''), 1=1)
GROUP BY s.company_no,
         COALESCE(NULLIF(d.customer_short_name, ''), d.distributor_name);

select * from sp_coral_flow_app_modules;


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

select * from sp_product_terminal_info where terminal_id not in (select store_no from sp_store_info);
