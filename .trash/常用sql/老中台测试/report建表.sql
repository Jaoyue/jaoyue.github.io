create table `platform-store-report`.sync_ims_product_price_promotion_price_to_b
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
create table `platform-store-report`.sync_ims_product_price_year_price_to_b
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
create table `platform-store-report`.sync_ims_product_price_store_promotion_price
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
    other_subsidy         decimal(10, 2) default 0 null comment '其他补贴',
    distributor_code      varchar(30)  null comment '客户编码'
)
    comment '门店促销价目表';
create table `platform-store-report`.sync_ims_offline_promotion_policy
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
    product_oa_line_id            varchar(100)                             null comment '物料OA行id',
    distributor_code      varchar(30)  null comment '客户编码'
)
    comment '线下渠道促销政策记录表';


CREATE TABLE `platform-store-report`.stat_monthly_delivery_comp (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    stat_date DATE NOT NULL COMMENT '统计日期(T-1)',
    distributor_code VARCHAR(50) NOT NULL COMMENT '分销商编码',
    distributor_name VARCHAR(100) COMMENT '分销商名称',
    material_no VARCHAR(50) NOT NULL COMMENT '物料号',
    product_name VARCHAR(200) COMMENT '商品名称',
    delivery_qty DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '提货数量',
    comp_policy DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '补差政策(单台)',
    comp_fee DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '当月提货补差费用',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_stat_date (stat_date),
    INDEX idx_distributor_code (distributor_code),
    INDEX idx_material (material_no),
    UNIQUE KEY uk_stat_distributor_material (stat_date, distributor_code, material_no)
) COMMENT='当月提货补差统计表';


CREATE TABLE `platform-store-report`.stat_historical_inventory_comp (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    stat_date DATE NOT NULL COMMENT '统计日期(T-1)',
    distributor_code VARCHAR(50) NOT NULL COMMENT '分销商编码',
    distributor_name VARCHAR(100) COMMENT '分销商名称',
    material_no VARCHAR(50) NOT NULL COMMENT '物料号',
    product_name VARCHAR(200) COMMENT '商品名称',
    inventory_qty DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '当天库存数量',
    daily_comp_policy DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '昨天单台补差政策(T-1)',
    prev_comp_policy DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '前一天单台补差政策(T-2)',
    daily_comp_fee DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '当天补差费用',
    accum_comp_fee DECIMAL(18,4) NOT NULL DEFAULT 0 COMMENT '累计补差费用(当月历史求和)',
    create_time DATETIME DEFAULT CURRENT_TIMESTAMP,
    update_time DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_stat_date (stat_date),
    INDEX idx_distributor_code (distributor_code),
    INDEX idx_material (material_no),
    UNIQUE KEY uk_stat_distributor_material (stat_date, distributor_code, material_no)
) COMMENT='历史库存补差统计表';

-- 承接O2O申请明细关联主表数据汇总表
CREATE TABLE `platform-store-report`.`sync_ims_policy_o2o_apply_detail` (
  `o2o_apply_details_id` bigint NOT NULL COMMENT 'O2O政策申请详情ID',
  `is_install` varchar(20) DEFAULT 'N' NULL COMMENT '是否需要安装',
  `o2o_apply_id` bigint NOT NULL COMMENT 'O2O政策申请ID',
  `product_sap_id` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' NOT NULL COMMENT '产品SAP编码',
  `product_name` varchar(255) COLLATE utf8mb4_general_ci DEFAULT '' NOT NULL COMMENT '产品名称',
  `o2o_mall_commission` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O商城佣金',
  `o2o_mall_subsidy` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O商城补贴',
  `o2o_trade_in_commission` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O以旧换新佣金',
  `o2o_trade_in_subsidy` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O以旧换新补贴',
  `o2o_dtb_commission` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O DTB佣金',
  `o2o_dtb_subsidy` decimal(10,2) DEFAULT 0 NOT NULL COMMENT 'O2O DTB补贴',
  `enable_flag` varchar(2) COLLATE utf8mb4_general_ci DEFAULT 'N' NOT NULL COMMENT '是否生效',
  `invalid_date` datetime NULL COMMENT '失效日期',
  `delete_flag` int DEFAULT 0 NOT NULL COMMENT '数据有效性',
  `audit_status` varchar(50) COLLATE utf8mb4_general_ci DEFAULT '' NOT NULL COMMENT '审核状态',
  `o2o_apply_code` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' NOT NULL COMMENT 'O2O政策申请编码',
  `o2o_apply_name` varchar(100) COLLATE utf8mb4_general_ci DEFAULT '' NOT NULL COMMENT 'O2O政策申请名称',
  `begin_date` datetime NOT NULL COMMENT '政策生效起始时间',
  `end_date` datetime NOT NULL COMMENT '政策生效结束时间',
  PRIMARY KEY (`o2o_apply_details_id`),
  -- 按要求仅创建物料号、开始日期、结束日期索引
  KEY `idx_product_sap_id` (`product_sap_id`),
  KEY `idx_begin_date` (`begin_date`),
  KEY `idx_end_date` (`end_date`)
)  COMMENT='O2O政策明细';

CREATE TABLE `stat_order_commission_detail` (
  `id`               BIGINT AUTO_INCREMENT PRIMARY KEY,
  `detail_id`               BIGINT NOT NULL COMMENT '订单明细id',
  `order_no`          VARCHAR(64)   NOT NULL COMMENT '订单编码',
  `order_date`     VARCHAR(64)         NOT NULL COMMENT '业务日期',
  `order_month`        VARCHAR(10)    NOT NULL COMMENT '归属日期',
  `order_type`        VARCHAR(32)   NOT NULL COMMENT '订单类型: 销售/退货',
  `clerk_name`     VARCHAR(32)   NOT NULL COMMENT '导购姓名',
  `work_no`     VARCHAR(32)   NOT NULL COMMENT '导购工号',
  `store_no`        VARCHAR(32)   NOT NULL COMMENT '门店编码',
  `store_name`        VARCHAR(64)   NOT NULL COMMENT '门店名称',
  `material_no`          VARCHAR(64)   NOT NULL COMMENT '物料号',
  `product_name`          VARCHAR(128)           COMMENT '物料名称',
  `count`          INT           NOT NULL COMMENT '数量',
  `commission_price`  DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '单台提成',
  `commission_amount` DECIMAL(10,2) NOT NULL DEFAULT 0 COMMENT '提成额',
  `commission_type` VARCHAR(32) NOT NULL COMMENT '提成类型:',
  `commission_source_no`          VARCHAR(64)   NOT NULL COMMENT '提成来源',
  `create_time`       DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_work_no (work_no)
) COMMENT='店员订单提成明细统计表';




