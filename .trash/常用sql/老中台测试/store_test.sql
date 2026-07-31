select * from sp_patrol_staff_record
select * from sp_patrol_report_plan
select * from sp_store_info
select * from sp_store_company_record

select * from sp_patrol_report_plan where plan_finish_date = '1746028799999' and `status` = 'DOING'
 where plan_finish_date like '%000';
update sp_patrol_report_plan set plan_finish_date = plan_finish_date+86400000-1 where plan_finish_date like '%000';

select * from sp_base_organization;
select * from sp_base_organization_customer where delete_flag = 0 and org_id in (19,20);
select * from sp_biz_staff_company;
select * from sp_product where orientation = 'STRUCTURAL' and delete_flag <> 1 and is_gift = 'N';

select * from sp_store_stock
select i.company_no,sum(t.stock_amount) from sp_store_stock t join sp_store_info i on t.store_no = i.store_no and i.delete_flag <> 1
group by i.company_no
select * from sp_base_organization_customer
select * from sp_store_product_stat limit 11;

select s.stat_time,sum(s.sales_count) sales_count
from sp_store_product_stat s join sp_store_info i on s.store_id = i.id
join sp_product p on s.material_no = p.material_no
where s.stat_time >= 1753113600000 group by s.stat_time;

select p.orientation,s.stat_time,sum(s.sales_count) sales_count
from sp_store_product_stat s join sp_store_info i on s.store_id = i.id
join sp_product p on s.material_no = p.material_no
where s.stat_time >= 1753113600000 group by p.orientation,s.stat_time;

select * from sp_sales_order where order_time >= 1753372800000;
select * from sp_sales_order_item where sales_order_no in (select order_no from sp_sales_order where order_time >= 1753372800000);
select * from sp_sn_list where sales_order_no in (select order_no from sp_sales_order where order_time >= 1753372800000);
select * from sp_sales_daily_stat_v2 where stat_time >= 1753372800000;
select * from sp_store_product_stat where stat_time >= 1753372800000;

select i.store_no,sum(t.stock_amount),i.name from sp_store_stock t
join sp_store_info i on t.store_no = i.store_no where i.delete_flag <> 1
and i.company_no = '3000104' group by i.store_no

select * from sp_train_exam where id =431
;
create table sp_app_policy
(
    id             bigint auto_increment comment '主键,自增'
        primary key,
    delete_flag    int                      not null comment '是否被删除，0：否  1：是',
    creater        varchar(50) charset utf8 not null comment '创建者',
    create_time    bigint                   not null comment '创建时间',
    modifier       varchar(50) charset utf8 not null comment '更新者',
    modify_time    bigint                   not null comment '更新时间',
    version        bigint                   not null comment 'version',
    policy_type    varchar(50)              not null comment '政策类型',
    policy_version varchar(255)             null comment '政策版本',
    policy_status varchar(255)             null comment '政策状态',
    policy_url     varchar(500)             null comment '政策url'
);
select * from sp_app_policy;
select * from sp_product;
select * from sp_biz_staff where work_no = 'J1141';
PINE-维修排障-拆机视频
select * from sp_sales_order where order_no = '601760147261021001018'