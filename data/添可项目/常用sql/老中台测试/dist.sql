select * from dist_ship_sales_order where sales_order_no = '1961241091025326081';

select * from dist_distributor where distributor_code = '1001679';
select * from dist_distributor where id = '621';

select distributor_code,sum(sales_amount) target from `platform-dist`.dist_sales_target_day_detail where target_date >= UNIX_TIMESTAMP('2026-01-01') * 1000   AND target_date <= (UNIX_TIMESTAMP('2026-01-31') * 1000+86399999)   and distributor_code in  ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491') group by distributor_code

INSERT INTO `platform-dist`.dist_distributor (id, distributor_code, distributor_name, cooperate_mode, sale_mode, prepay_flag, taxpayer_flag, sale_area, address, linkman, phone, qq, email, creater, create_time, modifier, modify_time, version, status, sales_channel, sale_sap_order_type, asm_sap_order_type, rebate_percentage, customer_type, ascription, channel_type, org_code, org_name, org_code_path, org_name_path, org_level, org_id, customer_short_name, parent_distributor_code, parent_distributor_name, manage_class) VALUES (609, '3008605', '江苏苏宁家科技服务有限公司', 'JINGXIAO', 'OFFLINE', null, null, 'KA', '南京市高淳区桠溪街道国华路66号10幢302', '韦龙海', '13962073460', null, null, 'API_SYSTEM', 1728455350616, 'evan.shen', 1734403092379, 3, 'TAKE_EFFECT', 'SINK_CHANNEL', null, null, null, 'ZHIYING', 'NewChannel', null, 'XM1028', '下沉', '/Tineco/XM1017/XM1024/XM1028', '/添可/线下中心/KA业务部/下沉', 3, null, '苏宁零售云官旗', null, null, 'LARGE_CLIENT');

select * from dist_distributor where  distributor_code = '3008605'
select * from dist_distributor where  sales_channel = 'SINK_CHANNEL'
select * from dist_distributor where sales_channel = 'sinkChannel' and distributor_code = '3008605';


INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1444, '109-23160201', '芙万Chorus Pro Lite', '芙万Chorus Pro Lite', '', '', '', '', 0, 0, 0, '', 0, 'API_SYSTEM', 1706709296784, 'evan.shen', 1733187585272, 2, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1563, '109-23281703', '芙万Stretch 尊享版', 'Stretch 尊享版', '', '', '', '', 0, 0, 0, '', 0, 'API_SYSTEM', 1729226050194, 'evan.shen', 1733792285244, 2, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1496, '109-23350201', '芙万Booster', '芙万Booster', '', '', '', '', 0, 0, 0, '', 0, 'evan.shen', 1711358641169, 'evan.shen', 1729648805811, 1, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1578, '109-23430503', '芙万S50', '芙万Muse', '', '', '', '', 0, 0, 0, '', 0, 'evan.shen', 1739429363357, 'evan.shen', 1739429363357, 0, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1602, '109-23430805', '芙万艺术家 30 Pro', 'Artist 30 pro', '', '', '', '', 0, 0, 0, '', 0, 'evan.shen', 1748509989932, 'evan.shen', 1748509989932, 0, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1620, '109-25370001', '芙万 极客', '躺平1.0升级 搓洗版', '', '', '', '', 0, 0, 0, '', 0, 'evan.shen', 1755854144586, 'evan.shen', 1755854144586, 0, 0, 'QXJ');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1529, '114-22200501', '双旋可拆单滚刷（不带把手）', 'CL2220独立双旋滚体', '', '', '', '', 0, 0, 0, '', 0, 'API_SYSTEM', 1722063894406, 'evan.shen', 1726649254052, 1, 0, 'OTHER');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1512, '114-23160027', '地面清洁液（杀菌500ml）', '升级款杀菌款溶液（500ml瓶装）薰衣草', '', '', '', '', 0, 0, 0, '', 0, 'API_SYSTEM', 1716388098260, 'evan.shen', 1726649265669, 1, 0, 'OTHER');
INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1671, '109-23312505', '2.0 pro S尊享版', '2.0 pro S尊享版', '', '', '', '', 0, 0, 0, '', 0, 'admin', 1770012563687, 'admin', 1770012563687, 0, 0, 'QXJ');

select * from dist_inventory_operation_log where source_no = 'FXTD202512180903110002';
select * from dist_inventory_operation_log where source_no = 'FXTDD20250220914410000';
select * from dist_inventory_operation_log where operate_type = 'returned_way_quantity' and quantity > 0 group by concat(source_no,material_no) having count(*) > 1;
select sum(quantity) quantity from dist_inventory_operation_log where operate_type = 'returned_way_quantity' and superior_source_no = 'FXTD202512180903110002' and material_no = '109-23430001';

select * from dist_inventory where distributor_code = '3008605' and material_no = '109-23760202';

INSERT INTO `platform-dist`.dist_product (id, material_no, name, product_no, type, url, brand, description, cost_price, weight, volume, unit, on_flag, creater, create_time, modifier, modify_time, version, product_audit_flag, product_classification) VALUES (1528, '109-23281004', '芙万Super Max', '芙万Super Max', '', '', '', '', 0, 0, 0, '', 0, 'API_SYSTEM', 1721983634302, 'evan.shen', 1722583440703, 1, 0, 'QXJ');

select * from dist_distributor where dist_distributor.customer_short_name like '%沧州都市%';

select * from dist_inventory where distributor_code = '1000000';

select * from dist_task;

INSERT INTO `platform-dist`.dist_task (id, name,
                                       params,
                                       classpath,
                                       status,
                                       creater,
                                       create_time,
                                       modifier,
                                       modify_time,
                                       version,
                                       mode,
                                       cron_expression,
                                       repeat_interval,
                                       repeat_count,
                                       trigger_time)
VALUES (4, '发送库存报表邮件', null,
        'com.ecovacs.distribution.task.SendInventoryMailTask',
        'SUCCESS', 'SYSTEM', 1773158400000,
        'TASK_SYSTEM', 1773158400000, 4, 'CRON',
        '0 1 1 1 * ?', null, null, null);

select *from dist_distributor where status = 'TAKE_EFFECT';
select * from dist_inventory;

update `platform-dist`.dist_inventory_operation_log set distributor_code = concat(distributor_code,'_del'),material_no = concat(material_no,'_del') where source_type = 'STORE_NO_INVENTORY_RETURN_ORDER' and source_no not in (select order_no from `platform-store`.sp_refund_order);
update `dist_inventory` a ,(select distributor_code, material_no , operate_type,sum(quantity) as quantity from  `dist_inventory_operation_log`   where  operate_type='inventory_quantity'  group by distributor_code,material_no,operate_type
)  b  set a.inventory_quantity=b.quantity where a.distributor_code=b.distributor_code and a.material_no=b.material_no ;
select distributor_code from dist_distributor where if('' != '',manage_class in (''),1=1) and if('' != '',sale_area in (''),1=1);

select * from `platform-dist`.dist_distributor where if('' != '',manage_class in (''),1=1) and if('' != '',sale_area in (''),1=1)

insert into `platform-ec`.ec_shop (name,shop_no,seller_nick,seller_name,enabled,creater,create_time,modifier,modify_time,version,source_type,show_name)
select distributor_name name, distributor_code shop_no,distributor_name seller_nick,customer_short_name seller_name,'1' enabled,'admin' creater,'1778204178278' create_time,'admin' modifier,'1778204178278' modify_time,'0' version,'B2C' source_type,customer_short_name show_name from `platform-dist`.dist_distributor where distributor_code = '3008853';

create table `platform-dist`.sync_ims_product_price_promotion_price_to_b
(
    promotion_price_id bigint         not null comment '促销价价目表id'
        primary key,
    product_sap_id     varchar(50)    null comment '产品SAP ID',
    customer_code      varchar(50)    null comment '客户编码',
    start_date         datetime       null comment '起始日期',
    end_date           datetime       null comment '终止日期',
    pick_up_price      decimal(11, 5) null comment '提货价',
    num_toplimit       int            null comment '数量上限',
    num_lowerlimit     int            null comment '数量下限',
    effective_status   varchar(30)    null comment '状态',
    price_code         varchar(30)    null comment '价格批文号',
    delete_flag        int default 0  not null comment '数据有效性',
    version_num        int default 0  not null comment '版本号',
    created_by         int            not null comment '创建人',
    creation_date      datetime       not null comment '创建时间',
    last_updated_by    int            not null comment '更新人',
    last_update_date   datetime       not null comment '更新时间',
    last_update_login  int            null comment '最后登录人'
)
    comment '促销价价目表to B';
create table `platform-dist`.sync_ims_product_price_year_price_to_b
(
    year_price_id     bigint         not null comment '年度价目表id'
        primary key,
    channel_big_type  varchar(50)    null comment '渠道大类',
    product_sap_id    varchar(50)    null comment '产品SAP ID',
    start_date        datetime       null comment '起始日期',
    end_date          datetime       null comment '终止日期',
    pick_up_price     decimal(11, 5) null comment '提货价',
    effective_status  varchar(30)    null comment '状态',
    price_code        varchar(30)    null comment '价格批文号',
    delete_flag       int default 0  null comment '数据有效性',
    version_num       int default 0  null comment '版本号',
    created_by        int            null comment '创建人',
    creation_date     datetime       null comment '创建时间',
    last_updated_by   int            null comment '更新人',
    last_update_date  datetime       null comment '更新时间',
    last_update_login int            null comment '最后登录人',
    violation_price   decimal(11, 5) null comment '违规处理价格'
)
    comment '年度价目表to B';
create table `platform-dist`.sync_ims_product_price_store_promotion_price
(
    promotion_price_id    bigint                   not null comment '促销价价目表id'
        primary key,
    product_sap_id        varchar(50)              null comment '产品SAP ID',
    store_code            varchar(50)              null comment '门店编码',
    customer_code         varchar(50)              null comment '客户编码',
    start_date            datetime                 null comment '起始日期',
    end_date              datetime                 null comment '终止日期',
    promotion_price       decimal(11, 5)           null comment '促销价格',
    effective_status      varchar(30)              null comment '状态',
    price_code            varchar(30)              null comment '价格批文号',
    delete_flag           int            default 0 not null comment '数据有效性',
    version_num           int            default 0 not null comment '版本号',
    created_by            int                      not null comment '创建人',
    creation_date         datetime                 not null comment '创建时间',
    last_updated_by       int                      not null comment '更新人',
    last_update_date      datetime                 not null comment '更新时间',
    last_update_login     int                      null comment '最后登录人',
    push_money            decimal(11, 5)           null comment '商品提成',
    activity_type         varchar(50)              null comment '活动类型',
    makeup_amount         decimal        default 0 null comment '补差金额',
    single_install_reward decimal(10, 2) default 0 null comment '单台安装奖励',
    install_subsidy       decimal(10, 2) default 0 null comment '安装补贴',
    other_subsidy         decimal(10, 2) default 0 null comment '其他补贴'
)
    comment '门店促销价目表';
create table `platform-dist`.sync_ims_offline_promotion_policy
(
    id                            bigint unsigned auto_increment comment '序号'
        primary key,
    source_order_number           varchar(255)                             not null comment '来源单号',
    store_no                      varchar(255)                             not null comment '门店编码',
    product_sap_id                varchar(255)                             null comment '物料编码',
    apply_promotion_amount        decimal(10, 2) default 0                 not null comment '申请促销价(元)',
    price_subsidy_amount          decimal(10, 2) default 0                 not null comment '价格补贴(元)',
    gift_subsidy_amount           decimal(10, 2) default 0                 not null comment '礼品补贴(元)',
    other_subsidy_amount          decimal(10, 2) default 0                 not null comment '其他补贴(元)',
    total_subsidy_amount          decimal(10, 2) default 0                 not null comment '补贴合计(元)',
    limit_num                     int            default 0                 not null comment '数量上限(台)',
    self_pick_up_control          varchar(10)    default 'N'               not null comment '自提赠品卡控 Y是 N否',
    promotion_amount              decimal(10, 2)                           null comment '渠道总促销(元)',
    start_date                    date                                     not null comment '开始日',
    end_date                      date                                     not null comment '结束日',
    policy_cash_flag              varchar(10)                              null comment 'OA是否兑现 Y/N',
    oa_callback_flag              varchar(5)     default 'N'               null comment 'oa 回写标志',
    delete_flag                   int            default 0                 not null comment '数据有效性',
    version_num                   int            default 0                 not null comment '版本号',
    created_by                    int                                      not null comment '创建人',
    creation_date                 datetime                                 not null comment '创建时间',
    last_updated_by               int                                      not null comment '更新人',
    last_update_date              datetime       default CURRENT_TIMESTAMP not null comment '更新时间',
    last_update_login             int                                      null comment '最后登录人',
    per_unit_commission           decimal(10, 2)                           null comment '单台导购提成(元/台)',
    sales_incentive_type          varchar(50)                              null comment '销售激励类型',
    sales_target_min              int                                      null comment '销售目标下限',
    sales_target_max              int                                      null comment '销售目标上限',
    per_unit_incentive            decimal(10, 2)                           null comment '单台销售激励(元/台)',
    is_included_bet_reward_scope  varchar(10)                              null comment '是否计入对赌奖励规模Y/N',
    is_included_bet_reward_policy varchar(10)                              null comment '是否计入对赌奖励政策Y/N',
    sales_area                    varchar(50)                              null comment '销售区域',
    product_oa_line_id            varchar(100)                             null comment '物料OA行id'
)
    comment '线下渠道促销政策记录表';

select * from `platform-dist`.sync_ims_product_price_promotion_price_to_b;
select * from `platform-dist`.sync_ims_product_price_store_promotion_price where start_date >= '2025-01-01 00:00:00';

select * from dist_inventory;
select * from dist_distributor where distributor_code = '1003682';

select * from dist_ship_sales_order;
select * from dist_ship_sales_order_item;

