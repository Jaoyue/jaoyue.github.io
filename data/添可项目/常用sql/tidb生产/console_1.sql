# select a.customer_name                     as 客户名称,
#        a.customer_code                     as 客户编码,
#        a.sale_company_code                 as 销售公司编码,
#        a.sale_company_name                 as 销售公司名称,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end         as 订单审批状态,
#        case a.ship_flag
#            when 'Y' then '是'
#            when 'N' then '否'
#            else a.ship_flag end            as 是否自提,
#        case a.ship_status
#            when 'WAITDELIVER' then '待发货'
#            when 'PARTDELIVER' then '部分发货'
#            when 'DELIVERED' then '已发货'
#            else a.ship_status end          as 发货状态,
#        case a.contract_flag
#            when '1' then '是'
#            when '0' then '否'
#            else a.contract_flag end        as 是否生效合同,
#        a.sales_order_no                    as 销售订单号,
#        a.delivery_order_no                 as 发货单号,
#        case a.violation_order_flag
#            when 'Y' then '是'
#            when 'N' then '否'
#            else a.violation_order_flag end as 违规回购订单,
#        a.receive_addr                      as 收货地址,
#        a.receiver                          as 收货联系人,
#        a.receive_mobile                    as 收货人电话,
#        a.sale_count                        as 整单总台数,
#        a.sale_amount                       as 整单销售总金额,
#        a.sale_discount                     as 整单折扣金额,
#        a.sale_discount_rate                as 整单折扣率,
#        a.pre_pay_amount                    as 预付款付款,
#        a.rebate_expense_amount             as 费用折让付款,
#        a.rebate_nonexpense_amount          as 非费用折让付款,
#        a.inner_credit                      as 内部授信,
#        a.out_credit                        as 外部授信,
#        case b.deliver_line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else b.deliver_line_type end    as 行类型,
#        b.approval_no                       as 价格批次号,
#        b.product_name                      as 产品名称,
#        b.product_sap_id                    as 产品SAP_ID,
#        b.brand_cn                          as 产品品牌,
#        b.product_series_model              as 产品系列型号,
#        b.product_big_type                  as 产品大类,
#        b.product_middle_type               as 产品中类,
#        b.product_small_type                as 产品小类,
#        b.product_type                      as 产品分类,
#        b.price                             as 单价,
#        b.apply_count                       as 申请数量,
#        b.apply_amount                      as 申请预付款金额,
#        b.apply_count * b.price             as 申请金额,
#        b.audit_count                       as 审批数量,
#        b.audit_amount                      as 审核预付款金额,
#        b.audit_count * b.price             as 审核金额,
#        b.tax_rate                          as 税率,
#        b.rebate_expense_amount             as 行费用折让付款,
#        b.rebate_nonexpense_amount          as 行非费用折让付款,
#        b.inner_credit                      as 行内部授信,
#        b.out_credit                        as 行外部授信,
#        b.total_count                       as 当月累计提货数量,
#        b.unsend_count                      as 当月已审未发数量,
#        c.delivery_order_num                as 发货单号,
#        case c.deliver_status
#            when 'WAITDELIVER' then '待发货'
#            when 'PARTDELIVER' then '部分发货'
#            when 'DELIVERED' then '已发货'
#            else c.deliver_status end       as 发货状态,
#        c.source_num                        as 来源单号,
#        case c.order_type
#            when 'DIST' then '分销渠道订单'
#            else c.order_type end           as 订单类型,
#        c.creation_date                     as 创建时间,
#        d.deliver_warehouse_name            as 发货仓库,
#        c.province_name                     as 省,
#        c.city_name                         as 市,
#        c.county_name                       as 区,
#        c.receive_addr                      as 收货人地址,
#        c.receiver                          as 收货联系人,
#        c.receive_phone                     as 收货固话,
#        c.receive_mobile                    as 收货手机,
#        c.provider_name                     as 物流商,
#        c.car_code                          as 车牌号,
#        c.driver_name                       as 司机,
#        c.driver_phone                      as 司机电话,
#        d.sap_id                            as 产品SAPID,
#        d.product_desc                      as 物料描述,
#        case d.product_level
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else d.product_level end        as 商品等级,
#        d.delivery_amount                   as 发货数量,
#        d.sign_amount                       as 实发数量,
#        d.sn_code                           as SN码,
#        d.unit                              as 计量单位,
#        case d.deliver_line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else d.deliver_line_type end    as 发货行类型,
#        d.location_name                     as 库位名称,
#        d.location_code                     as 库位编码,
#        d.wms_location_code                 as 实物库区编码,
#        d.wms_location_name                 as 实物库区名称
# from dmp_sales_order.ims_dist_sales_order a
#          join dmp_sales_order.ims_dist_sales_order_item b
#               on a.id = b.header_id
#          join dmp_tms.ims_logistics_delivery_order_header c
#               on a.sales_order_no = c.source_num
#          join dmp_tms.ims_logistics_delivery_order_line d
#               on c.order_header_id =
#                  d.order_header_id
#                   and b.product_sap_id = d.sap_id
# where a.creation_date >= '2025-01-01';
#
# select a.customer_name                  as 客户名称,
#        a.sale_company_name              as 销售公司名称,
#        a.receive_refund_order_no        as 退货单号,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end      as 订单审批状态,
#        case a.return_type
#            when 'REFUND_TYPE_10' then '拒收'
#            when 'REFUND_TYPE_20' then '滞销'
#            when 'REFUND_TYPE_30' then '质量召回'
#            when 'REFUND_TYPE_40' then '售后退货'
#            when 'REFUND_TYPE_50' then '仅退货'
#            when 'REFUND_TYPE_60' then '等级机退货'
#            when 'REFUND_TYPE_70' then '等级机退货 (拒收)'
#            else a.return_type end       as 退货类型,
#        a.receive_warehouse              as 收货仓库,
#        a.receive_location               as 收货库位,
#        a.cn_warehouse_code              as 菜鸟库位编码,
#        a.cn_warehouse_name              as 菜鸟库位名称,
#        a.delivery_order_no              as 发货单号,
#        a.sales_order_no                 as 销售单号,
#        a.receiver                       as 寄件人姓名,
#        a.receive_mobile                 as 寄件人手机,
#        a.receive_addr                   as 选择地址,
#        a.total_return_amount            as 退货金额,
#        case b.deliver_line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else b.deliver_line_type end as 行类型,
#        b.approval_no                    as 价格批次号,
#        b.product_sku                    as 产品SKU,
#        b.product_name                   as 产品名称,
#        b.return_count                   as 退货数量,
#        b.product_sap_id                 as 产品SAP_ID,
#        b.brand_cn                       as 产品品牌,
#        b.product_series_model           as 产品系列型号,
#        b.product_big_type               as 产品部大类,
#        b.product_middle_type            as 产品中类,
#        b.product_small_type             as 产品小类,
#        b.product_type                   as 产品分类,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end     as 商品等级,
#        b.price                          as 单价,
#        b.return_amount                  as 退货金额,
#        b.change_price                   as 调整单价,
#        b.sn                             as SN码,
#        b.receive_sn                     as 实收SN码,
#        b.memo                           as 备注,
#        b.sales_order_no                 as 原销售单号
# from dmp_sales_order.ims_dist_refund_order a
#          join dmp_sales_order.ims_dist_refund_order_item b
#               on a.id = b.header_id
# where a.creation_date >= '2025-01-01';


# select a.customer_name                  as 客户名称,
#        a.customer_code                  as 客户编码,
#        a.sale_company_code              as 销售公司编码,
#        a.sale_company_name              as 销售公司名称,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end      as 订单审批状态,
#        a.sales_order_no                 as 销售订单号,
#        a.sale_count                     as 整单总台数,
#        a.sale_amount                    as 整单销售总金额,
#        a.sale_discount                  as 整单折扣金额,
#        a.sale_discount_rate             as 整单折扣率,
#        b.line_order_no                  as 行单号,
#        case b.line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else b.line_type end         as 行类型,
#        b.approval_no                    as 价格批次号,
#        b.product_sku                    as 产品SKU,
#        b.product_name                   as 产品名称,
#        b.brand_cn                       as 产品品牌,
#        b.product_series_model           as 产品系列型号,
#        b.product_big_type               as 产品大类,
#        b.product_middle_type            as 产品中类,
#        b.product_small_type             as 产品小类,
#        b.product_type                   as 产品分类,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end     as 产品等级,
#        b.price                          as 单价,
#        b.apply_count                    as 数量,
#        b.apply_amount                   as 金额,
#        b.pre_pay_amount                 as 预付款金额,
#        b.receiver                       as 收货人,
#        b.receive_mobile                 as `收件人-手机号`,
#        b.province_name                  as `收件人-省`,
#        b.city_name                      as `收件人-市`,
#        b.area_name                      as `收件人-区`,
#        b.receive_addr                   as `收件人-地址`,
#        b.express_no                     as 快递单号,
#        b.delivery_order_no              as 发货单号,
#        b.wms_no                         as WMS运单号,
#        case b.line_status
#            when 'NORMAL' then '正常'
#            when 'ClOSE' then '关闭'
#            else b.line_status end       as 状态,
#        c.delivery_order_num             as 发货单号,
#        case c.deliver_status
#            when 'WAITDELIVER' then '待发货'
#            when 'PARTDELIVER' then '部分发货'
#            when 'DELIVERED' then '已发货'
#            else c.deliver_status end    as 发货状态,
#        case c.order_type
#            when 'DIST' then '分销渠道订单'
#            when 'DIST_DROP_SHIPPING'
#                then '分销一件代发订单'
#            else c.order_type end        as 发货类型,
#        c.creation_date                  as 创建日期,
#        d.deliver_warehouse_name         as 发货仓库,
#        c.province_name                  as 省,
#        c.city_name                      as 市,
#        c.county_name                    as 区,
#        c.receive_addr                   as 收货人地址,
#        c.receiver                       as 收货联系人,
#        c.receive_phone                  as 收货固话,
#        c.receive_mobile                 as 收货手机,
#        c.provider_name                  as 物流商,
#        c.car_code                       as 车牌号,
#        c.driver_name                    as 司机,
#        c.driver_phone                   as 司机电话,
#        d.sap_id                         as 产品SAPID,
#        d.product_desc                   as 物料描述,
#        case d.product_level
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else d.product_level end     as 商品等级,
#        d.delivery_amount                as 发货数量,
#        d.sign_amount                    as 实发数量,
#        d.sn_code                        as SN码,
#        d.unit                           as 计量单位,
#        case d.deliver_line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else d.deliver_line_type end as 发货行类型,
#        d.deliver_warehouse_name         as 发货仓库,
#        d.location_name                  as 库位名称,
#        d.location_code                  as 库位编码,
#        d.wms_location_code              as 实物库区编码,
#        d.wms_location_name              as 实物库区名称
# from dmp_sales_order.ims_dist_dropshipping_order a
#          join dmp_sales_order.ims_dist_dropshipping_order_item b
#               on a.id = b.header_id
#          join dmp_tms.ims_logistics_delivery_order_header c
#               on b.line_order_no = c.source_num
#          join dmp_tms.ims_logistics_delivery_order_line d
#               on c.order_header_id =
#                  d.order_header_id
# where a.creation_date >= '2025-01-01' order by a.id;


# select a.customer_name     as 客户名称,
#        a.customer_code     as 客户编码,
#        a.sale_company_code as 销售公司编码,
#        a.sale_company_name as 销售公司名称,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end         as 订单审批状态,
#        a.warehouse_code      as 仓库编码,
#        a.warehouse_name      as 仓库名称,
#        case a.ship_flag
#            when 'Y' then '是'
#            when 'N' then '否'
#            else a.ship_flag end            as 是否发货,
#        a.location_code        as 库位编码,
#        a.location_name        as 库位名称,
#        -- 把寄售订单类型转成中文
#        case a.consign_order_type
#            when 'RETURN' then '寄售退货'
#            when 'RETURNJD' then '采购退货'
#            when 'SALES' then '寄售销售'
#            when 'RETURNSALES' then '销售退货'
#            else a.consign_order_type end    as 寄售订单类型,
#        a.sales_order_no        as 销售订单号,
#        a.settlement_code  as 结算单号,
#        concat(a.province_name,a.city_name,a.area_name) as 地址,
#        a.receive_addr         as 收货地址,
#        a.receiver              as 收货联系人,
#        a.receive_mobile        as 收货人电话,
#        a.sale_count as 整单总台数,
#        a.sale_amount as 整单销售总金额,
#        a.settlement_amount as 整单结算金额,
#        case b.deliver_line_type
#            when 'BIG' then '大货'
#            when 'SPENTPARTS' then '散备件'
#            when 'FEEGIFT' then '收费赠品'
#            else b.deliver_line_type end    as 行类型,
#        b.approval_no as 价格批次号,
#        b.product_sku as 产品SKU,
#        b.product_name as 产品名称,
#        b.product_sap_id as 产品SAP_ID,
#        b.brand_cn as 产品品牌,
#        b.product_series_model as 产品系列型号,
#        b.product_big_type as 产品大类,
#        b.product_middle_type as 产品中类,
#        b.product_small_type as 产品小类,
#        b.product_type as 产品分类,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end     as 产品等级,
#        b.price as 系统单价,
#        b.settlement_account_price as 结算账单价,
#        b.deduction_share_price as 扣款分摊,
#        b.settlement_price as 结算单价,
#        b.price-b.settlement_price as 结算价差,
#        b.apply_count as 申请数量,
#        b.apply_amount as 申请金额,
#        b.apply_settlement_amount as 申请结算金额,
#        b.audit_count as 审批数量,
#        b.audit_amount as 审核金额,
#        b.audit_settlement_amount as 审批结算金额
# from dmp_sales_order.ims_consign_sales_order a
#          join dmp_sales_order.ims_consign_sales_order_item b
#               on a.id = b.header_id
# where a.creation_date >= '2025-01-01'

# select case a.channel_big_type
#            when 'ONLINE' then '线上'
#            when 'OFFLINE' then '线下'
#            when 'ODM_OEM' then 'ODM/OEM'
#            else a.channel_big_type
#            end                as 渠道大类,
#        a.product_sap_id       as 产品SAP_ID,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品SKU,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        b.brand_cn             as 品牌,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.pick_up_price        as 提货价,
#        a.violation_price      as 违规价,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code           as 价格批文号
# from dmp_product.ims_product_price_year_price_to_b a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
# where a.creation_date >= '2025-01-01';

# 产品sapid、产品名称、产品系列型号、产品sku、产品大类、产品中类、产品小类、品牌、客户编码、客户名称、起始日期、终止日期、提货价、数量上限、数量下限、状态、价格批文号
# select a.product_sap_id       as 产品SAP_ID,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品SKU,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        b.brand_cn             as 品牌,
#        a.customer_code        as 客户编码,
#        c.customer_name        as 客户名称,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.pick_up_price        as 提货价,
#        a.num_toplimit         as 数量上限,
#        a.num_lowerlimit       as 数量下限,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code           as 价格批文号
# from dmp_product.ims_product_price_promotion_price_to_b a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
#          join dmp_customer.customer_info c
#               on a.customer_code = c.customer_code
# where a.creation_date >= '2025-01-01';

# sapid、产品名称、产品系列型号、产品sku、产品等级、品牌、产品大类、产品种类、产品小类、客户编码、客户名称、起始日期、终止日期、提货价、状态、价格批文号。
# select a.product_sap_id       as sapid,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品sku,
#        b.product_grade        as 产品等级,
#        b.brand_cn             as 品牌,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type         as 产品中类,
#        b.product_small_type   as 产品小类,
#        a.customer_code        as 客户编码,
#        c.customer_name        as 客户名称,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.pick_up_price        as 提货价,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code           as 价格批文号
# from dmp_product.ims_product_price_refurbished_price_to_b a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
# join dmp_customer.customer_info c
#     on a.customer_code = c.customer_code
# where a.creation_date >= '2025-01-01';

# 产品sapid、产品名称、产品系列型号、产品sku、产品大类、产品中类、产品小类、品牌、起始日期、终止日期、建议零售价、促销价、大促价、状态、价格批文号

# select a.product_sap_id       as 产品sapid,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品sku,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        b.brand_cn             as 品牌,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.retail_price as 建议零售价,
#        a.promotion_price as 促销价,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code as 价格批文号
# from dmp_product.ims_product_price_year_price_to_c a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
# where a.creation_date >= '2025-01-01';

# 产品sapid、产品名称、产品系列型号、产品sku、产品大类、产品中类、产品小类、品牌、客户编码、客户名称、起始日期、终止日期、建议零售价、数量上限、数量下限、状态、价格批文号

# select a.product_sap_id       as 产品sapid,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品sku,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        b.brand_cn             as 品牌,
#        a.customer_code        as 客户编码,
#        c.customer_name        as 客户名称,
#        a.start_date          as 起始日期,
#        a.end_date            as 终止日期,
#        a.retail_price as 建议零售价,
#        a.num_toplimit        as 数量上限,
#        a.num_lowerlimit      as 数量下限,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code as 价格批文号
# from dmp_product.ims_product_price_promotion_price_to_c a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
#          join dmp_customer.customer_info c
#               on a.customer_code = c.customer_code
# where a.creation_date >= '2025-01-01';
#
# select * from ims_product_price_promotion_price_to_c

#  sapid、产品名称、产品系列型号、产品sku、产品等级、品牌、产品大类、产品种类、产品小类、客户编码、客户名称、起始日期、终止日期、建议零售价、状态、价格批文号。

# select a.product_sap_id       as sapid,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品sku,
#        b.product_grade        as 产品等级,
#        b.brand_cn             as 品牌,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        a.customer_code        as 客户编码,
#        c.customer_name        as 客户名称,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.retail_price as 建议零售价,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code as 价格批文号
# from dmp_product.ims_product_price_refurbished_price_to_c a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
# join dmp_customer.customer_info c
#      on a.customer_code = c.customer_code
# where a.creation_date >= '2025-01-01';

# 活动类型、产品sapid、产品名称、产品系列型号、产品sku、产品大类、产品种类、产品小类、品牌、门店编码、门店名称、客户编码、客户名称、客户名称、起始日期、终止日期、促销价格、状态、价格批文号
#
# select a.activity_type                 as 活动类型,
#        a.product_sap_id                as 产品sapid,
#        b.product_name                  as 产品名称,
#        b.product_series_model          as 产品系列型号,
#        b.product_sku                   as 产品sku,
#        b.product_big_type              as 产品大类,
#        b.product_middle_type           as 产品中类,
#        b.product_small_type            as 产品小类,
#        b.brand_cn                      as 品牌,
#        a.store_code                    as 门店编码,
#        c.customer_name                 as 门店名称,
#        d.customer_code                 as 客户编码,
#        d.customer_name                 as 客户名称,
#        a.start_date                    as 起始日期,
#        a.end_date                      as 终止日期,
#        a.promotion_price               as 促销价格,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status end as 状态,
#        a.price_code                    as 价格批文号
# from dmp_product.ims_product_price_store_promotion_price a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
#          join dmp_customer.customer_info c
#               on a.store_code = c.customer_code
#          join dmp_customer.customer_info d
#               on c.customer_parent_id = d.customer_id
# where a.creation_date >= '2025-01-01' order by a.promotion_price_id;

# 产品sapid、产品名称、产品系列型号、产品sku、产品大类、产品中类、产品小类、品牌、起始日期、终止日期、促销价格、状态、价格批文号、样机等级
#
# select a.product_sap_id       as 产品sapid,
#        b.product_name         as 产品名称,
#        b.product_series_model as 产品系列型号,
#        b.product_sku          as 产品sku,
#        b.product_big_type     as 产品大类,
#        b.product_middle_type  as 产品中类,
#        b.product_small_type   as 产品小类,
#        b.brand_cn             as 品牌,
#        a.start_date           as 起始日期,
#        a.end_date             as 终止日期,
#        a.price                as 促销价格,
#        case a.effective_status
#            when 'EFFECTIVE' then '生效'
#            when 'ABATE' then '失效'
#            when 'EXPIRED' then '过期失效'
#            else a.effective_status
#            end                as 状态,
#        a.price_code           as 价格批文号,
#        a.prototype_level      as 样机等级
# from dmp_product.ims_product_price_store_prototype_price a
#          join dmp_product.product_info b
#               on a.product_sap_id =
#                  b.product_sap_id
# where a.creation_date >= '2025-01-01';

#  申请单号、单据名称、装状态、创建人、创建时间、申请类别、申请事由、备注
#
# select a.apply_code                as 申请单号,
#        a.apply_name                as 单据名称,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end as 状态,
#        a.created_by                as 创建人,
#        a.creation_date             as 创建时间,
#        case a.apply_type
#            when 'SUPPLY_SOURCE_SPECIAL_OFFER'
#                then '货源与特价申请'
#            when 'ECOMMERCE_PLATFORM_SUPPLY_PRICE'
#                then '电商平台供价申请'
#            else a.apply_type end   as 申请类别,
#        a.apply_reason              as 申请事由,
#        a.remark                    as 备注
# from dmp_product.ims_product_price_promotion_price_before_header_to_b a
# where a.creation_date >= '2025-01-01';
# #
# select a.prototype_order_code             as 样机订单号,
#        case a.return_flag
#            when 'Y' then '归还'
#            when 'N' then '不归还'
#            else a.return_flag end         as 是否归还,
#        case a.order_delivery_type
#            when 'MARKETING' then '营销仓'
#            when 'FACTORY_IMS' then '国内工厂仓'
#            when 'FACTORY_OMS' then '国际工厂仓'
#            else a.order_delivery_type end as 样机领用仓库,
#        case a.ship_flag
#            when 'Y' then '自提'
#            when 'N' then '快递'
#            else a.ship_flag end           as 样机发货方式,
#        case a.center_type
#            when 'FUNCTION' then '职能'
#            when 'MANUFACTURE' then '制造'
#            when 'RESEARCH' then '研发'
#            when 'SALES' then '销售'
#            else a.center_type end         as 中心类型,
#        case a.use_class
#            when 'ACTIVITY'
#                then '社媒推广、线上直播团购带货、直播间自播领用、客户样机、渠道参展等线上&社媒推广相关'
#            when 'BRAND'
#                then '展厅陈列、参展、品牌活动拍摄等品牌传播相关'
#            when 'SPECIAL' then '特殊客情用途'
#            when 'GUEST' then '一般客情 (客户、平台)'
#            when 'AFTER_SALE' then '售后维修网点培训、售后拍摄'
#            when 'OTHER' then '员工培训 (售后除外)'
#            when 'TEST' then '内部员工试用、部门测试领用'
#            when 'STORE' then '线下门店样机、线下门店直播样机'
#            when 'MEETING' then '年会礼品'
#            else a.use_class end           as 用途分类,
#        a.apply_person_name                as 申请人,
#        a.customer_name                    as 所属客户名称,
#        a.apply_reason                     as 申请原因,
#        c.org_name                         as 申请人部门,
#        a.cost_center_code                 as 申请人部门成本中心编码,
#        d.cost_center_name                 as 申请人部门成本中心名称,
#        e.fee_asc_code                     as 申请人费用归属,
#        b.product_sap_id                   as 产品sapid,
#        b.product_sku                      as 产品sku,
#        b.product_name                     as 物料名称,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end       as 商品等级,
#        b.fee_asc_name                     as 费用归属名称,
#        b.cost_center_name                 as 成本中心名称,
#        b.cost_center_code                 as 成本中心编码,
#        b.quantity                         as 申请数量,
#        b.sn_code                          as sn码,
#        case b.return_flag
#            when 'Y' then '归还'
#            when 'N' then '不归还'
#            else b.return_flag end         as 是否归还,
#        b.receiver                         as 收货人,
#        b.receiver_mobile                  as 收货人手机,
#        b.province                         as 省,
#        b.city                             as 市,
#        b.area                             as 区,
#        b.receiver_addr                    as 收货地址,
#        b.remark                           as 备注
# from dmp_sales_order.ims_prototype_order a
#          join dmp_sales_order.ims_prototype_order_line b
#               on a.prototype_order_id =
#                  b.prototype_order_id
#          left join saaf.base_organization c
#                    on a.person_dept_code =
#                       c.org_code
#          left join dmp_sales_order.ims_prototype_order_safekeep_configure d
#                    on a.cost_center_code =
#                       d.cost_center_code
#          left join dmp_sales_order.ims_prototype_order_safekeep_configure e
#                    on d.dept_code = e.dept_code
# where a.prototype_order_type <> 'OFF_LINE'
#   and a.creation_date >= '2025-01-01';
#
# select distinct prototype_order_type
# from dmp_sales_order.ims_prototype_order
# where return_flag = 'Y';
#
# select a.prototype_order_code       as 样机订单号,
#        a.creation_date              as 创建时间,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end  as 审批状态,
#        a.apply_person_name          as 申请人,
#        b.terminal_code              as 终端编码,
#        b.terminal_name              as 终端名称,
#        b.product_name               as 产品名称,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end as 商品等级,
#        b.product_sap_id             as 产品sapid,
#        b.sn_code                    as sn码,
#        b.quantity                   as 申请数量,
#        b.receiver_addr              as 终端收货地址,
#        b.receiver                   as 收货人姓名,
#        b.receiver_mobile            as 收货人手机,
#        case b.status
#            when 'DELIVERED' then '已发货'
#            when 'WAITDELIVER' then '待发货'
#            when 'CLOSED' then '关闭'
#            when 'NORMAL' then '正常'
#            else b.status end        as 状态,
#        b.remark                     as 备注
# from dmp_sales_order.ims_prototype_order a
#          join dmp_sales_order.ims_prototype_order_line b
#               on a.prototype_order_id =
#                  b.prototype_order_id
# where a.prototype_order_type = 'OFF_LINE'
#   and a.creation_date >= '2025-01-01';
# 样机信息：
# 终端编码、终端名称、产品名称、商品等级、产品sapid、sn码、申请数量、终端收货地址、收货人姓名、收货人手机、状态、备注"
#
# select a.prototype_order_code      as 关联领用单编码,
#        a.prototype_return_code     as 样机订单号,
#        case a.return_form
#            when 'EXPENSE' then '费用化领用'
#            when 'RETURN' then '归还实物'
#            when 'DELAY' then '借用延期'
#            when 'PART' then '核销'
#            when 'RESIST' then '抵佣'
#            else a.return_form end  as 归还形式,
#        case a.audit_status
#            when 'DRAFT' then '草稿'
#            when 'APPROVAL' then '审批中'
#            when 'ALLOW' then '审批通过'
#            when 'REFUSAL' then '审批驳回'
#            when 'CLOSED' then '已关闭'
#            when 'DELETED' then '已删除'
#            else a.audit_status end as 审批状态,
#        a.total_quantity            as 样机总数,
#        a.return_quantity           as 归还总数量,
#        a.expense_quantity          as 费用化数量,
#        a.resist_quantity           as 抵佣数量,
# b.product_sap_id                    as 产品sapid,
# b.product_name                     as 产品名称,
#        case b.product_grade
#            when 'BLP' then '不良品'
#            when 'STANDARD' then '大货'
#            when 'SPARE_PARTS' then '散备件'
#            when 'GRADE_B' then '准新机'
#            when 'GRADE_A' then '等级机'
#            when 'GRADE_B1' then 'B1等级机'
#            when 'GRADE_B2' then 'B2等级机'
#            when 'GRADE_B3' then 'B3等级机'
#            when 'PURCHASED_GIFTS' then '外购赠品'
#            when 'PROTOTYPE_A' then '样机A'
#            when 'PROTOTYPE_B' then '样机B'
#            when 'HANDLE_A' then '处理机A'
#            when 'HANDLE_B' then '处理机B'
#            when 'INSPECT' then '待检机'
#            when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
#            when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
#            else b.product_grade end as 产品等级,
#     b.use_sub         as 用途细分,
#     b.cost_center_name as 成本中心名称,
#     b.quantity        as 申请数量,
#     b.safekeep_location_name as 样机保管库位,
#     b.shipment_no      as 发货单号,
#     b.sn_code         as sn码,
#     b.return_kind_flag as 是否实物归还,
#     b.resist_flag      as 是否抵佣,
#     b.plan_return_date as 计划归还日期,
#     b.return_logistics_order_no as 归还库位退货物流单号
# from dmp_sales_order.ims_prototype_return a
#          join dmp_sales_order.ims_prototype_return_line b
#               on a.prototype_return_id =
#                  b.prototype_return_id
# where a.creation_date >= '2025-01-01';


select a.prototype_order_code             as 样机订单号,
       case a.return_flag
           when 'Y' then '归还'
           when 'N' then '不归还'
           else a.return_flag end         as 是否归还,
       case a.order_delivery_type
           when 'MARKETING' then '营销仓'
           when 'FACTORY_IMS' then '国内工厂仓'
           when 'FACTORY_OMS' then '国际工厂仓'
           else a.order_delivery_type end as 样机领用仓库,
       case a.ship_flag
           when 'Y' then '自提'
           when 'N' then '快递'
           else a.ship_flag end           as 样机发货方式,
       case a.center_type
           when 'FUNCTION' then '职能'
           when 'MANUFACTURE' then '制造'
           when 'RESEARCH' then '研发'
           when 'SALES' then '销售'
           else a.center_type end         as 中心类型,
       case a.use_class
           when 'ACTIVITY'
               then '社媒推广、线上直播团购带货、直播间自播领用、客户样机、渠道参展等线上&社媒推广相关'
           when 'BRAND'
               then '展厅陈列、参展、品牌活动拍摄等品牌传播相关'
           when 'SPECIAL' then '特殊客情用途'
           when 'GUEST' then '一般客情 (客户、平台)'
           when 'AFTER_SALE' then '售后维修网点培训、售后拍摄'
           when 'OTHER' then '员工培训 (售后除外)'
           when 'TEST' then '内部员工试用、部门测试领用'
           when 'STORE' then '线下门店样机、线下门店直播样机'
           when 'MEETING' then '年会礼品'
           else a.use_class end           as 用途分类,
       a.apply_person_name                as 申请人,
       a.customer_name                    as 所属客户名称,
       a.apply_reason                     as 申请原因,
       c.org_name                         as 申请人部门,
       a.cost_center_code                 as 申请人部门成本中心编码,
       d.cost_center_name                 as 申请人部门成本中心名称,
       e.fee_asc_code                     as 申请人费用归属,
       b.product_sap_id                   as 产品sapid,
       b.product_sku                      as 产品sku,
       b.product_name                     as 物料名称,
       case b.product_grade
           when 'BLP' then '不良品'
           when 'STANDARD' then '大货'
           when 'SPARE_PARTS' then '散备件'
           when 'GRADE_B' then '准新机'
           when 'GRADE_A' then '等级机'
           when 'GRADE_B1' then 'B1等级机'
           when 'GRADE_B2' then 'B2等级机'
           when 'GRADE_B3' then 'B3等级机'
           when 'PURCHASED_GIFTS' then '外购赠品'
           when 'PROTOTYPE_A' then '样机A'
           when 'PROTOTYPE_B' then '样机B'
           when 'HANDLE_A' then '处理机A'
           when 'HANDLE_B' then '处理机B'
           when 'INSPECT' then '待检机'
           when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
           when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
           else b.product_grade end       as 商品等级,
       b.fee_asc_name                     as 费用归属名称,
       b.cost_center_name                 as 成本中心名称,
       b.cost_center_code                 as 成本中心编码,
       b.quantity                         as 申请数量,
       b.sn_code                          as sn码,
       case b.return_flag
           when 'Y' then '归还'
           when 'N' then '不归还'
           else b.return_flag end         as 是否归还,
       b.receiver                         as 收货人,
       b.receiver_mobile                  as 收货人手机,
       b.province                         as 省,
       b.city                             as 市,
       b.area                             as 区,
       b.receiver_addr                    as 收货地址,
       b.remark                           as 备注
from dmp_sales_order.ims_prototype_order a
         join dmp_sales_order.ims_prototype_order_line b
              on a.prototype_order_id =
                 b.prototype_order_id
         left join saaf.base_organization c
                   on a.person_dept_code =
                      c.org_code
         left join dmp_sales_order.ims_prototype_order_safekeep_configure d
                   on a.cost_center_code =
                      d.cost_center_code
         left join dmp_sales_order.ims_prototype_order_safekeep_configure e
                   on d.dept_code = e.dept_code
where a.prototype_order_type <> 'OFF_LINE'
  and a.creation_date >= '2025-01-01';

select a.prototype_order_code      as 单号,
       z.meaning                   as 申请类型,
       a.total_quantity            as 总数量,
       a.apply_person_name         as 申请人,
       a.apply_date                as 申请日期,
       case a.audit_status
           when 'DRAFT' then '草稿'
           when 'APPROVAL' then '审批中'
           when 'ALLOW' then '审批通过'
           when 'REFUSAL' then '审批驳回'
           when 'CLOSED' then '已关闭'
           when 'DELETED' then '已删除'
           else a.audit_status end as 审批状态,
       a.remark                    as 备注,
       b.terminal_code             as 终端编码,
       b.terminal_name             as 终端名称,
       b.product_name              as 产品名称,
       b.product_sap_id            as 产品sapid,
       b.sn_code                   as sn码,
       b.quantity                  as 申请数量,
       a.reject_reason             as 返厂原因,
       b.receiver                  as 寄件人姓名,
       b.receiver_mobile           as 寄件人手机号,
       b.courier_no                as 快递单号
from dmp_sales_order.ims_prototype_order a
         join dmp_sales_order.ims_prototype_order_line b
              on a.prototype_order_id =
                 b.prototype_order_id
         left join saaf.base_lookup_values z
                   on a.use_class =
                      z.lookup_code and
                      z.lookup_type =
                      'IMS_PROTOTYPE_USE_CLASS_ALL'
where a.prototype_order_type = 'FACTORY';

# "单号、申请类型、总数量、申请人、申请日期、审批状态、备注
# 样机信息：
# 终端编码、终端名称、产品名称、产品sapid、sn码、申请数量、返厂原因、寄件人姓名、寄件人手机号、快递单号"

select *
from base_lookup_values
where lookup_code = 'RESEARCH_TEST';

select a.prototype_order_code       as 关联领用单编码,
       a.prototype_return_code      as 样机订单号,
       case a.return_form
           when 'EXPENSE' then '费用化领用'
           when 'RETURN' then '归还实物'
           when 'DELAY' then '借用延期'
           when 'PART' then '核销'
           when 'RESIST' then '抵佣'
           else a.return_form end   as 归还形式,
       case a.audit_status
           when 'DRAFT' then '草稿'
           when 'APPROVAL' then '审批中'
           when 'ALLOW' then '审批通过'
           when 'REFUSAL' then '审批驳回'
           when 'CLOSED' then '已关闭'
           when 'DELETED' then '已删除'
           else a.audit_status end  as 审批状态,
       a.total_quantity             as 样机总数,
       a.return_quantity            as 归还总数量,
       a.expense_quantity           as 费用化数量,
       a.resist_quantity            as 抵佣数量,
       b.product_sap_id             as 产品sapid,
       b.product_name               as 产品名称,
       case b.product_grade
           when 'BLP' then '不良品'
           when 'STANDARD' then '大货'
           when 'SPARE_PARTS' then '散备件'
           when 'GRADE_B' then '准新机'
           when 'GRADE_A' then '等级机'
           when 'GRADE_B1' then 'B1等级机'
           when 'GRADE_B2' then 'B2等级机'
           when 'GRADE_B3' then 'B3等级机'
           when 'PURCHASED_GIFTS' then '外购赠品'
           when 'PROTOTYPE_A' then '样机A'
           when 'PROTOTYPE_B' then '样机B'
           when 'HANDLE_A' then '处理机A'
           when 'HANDLE_B' then '处理机B'
           when 'INSPECT' then '待检机'
           when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
           when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
           else b.product_grade end as 产品等级,
       b.use_sub                    as 用途细分,
       b.cost_center_name           as 成本中心名称,
       b.quantity                   as 申请数量,
       b.safekeep_location_name     as 样机保管库位,
       b.shipment_no                as 发货单号,
       b.sn_code                    as sn码,
       b.return_kind_flag           as 是否实物归还,
       b.resist_flag                as 是否抵佣,
       b.plan_return_date           as 计划归还日期,
       b.return_logistics_order_no  as 归还库位退货物流单号
from dmp_sales_order.ims_prototype_return a
         join dmp_sales_order.ims_prototype_return_line b
              on a.prototype_return_id =
                 b.prototype_return_id
where a.creation_date >= '2025-01-01';

select a.prototype_order_code       as 样机订单号,
       a.creation_date              as 创建时间,
       case a.audit_status
           when 'DRAFT' then '草稿'
           when 'APPROVAL' then '审批中'
           when 'ALLOW' then '审批通过'
           when 'REFUSAL' then '审批驳回'
           when 'CLOSED' then '已关闭'
           when 'DELETED' then '已删除'
           else a.audit_status end  as 审批状态,
       a.apply_person_name          as 申请人,
       b.terminal_code              as 终端编码,
       b.terminal_name              as 终端名称,
       b.product_name               as 产品名称,
       case b.product_grade
           when 'BLP' then '不良品'
           when 'STANDARD' then '大货'
           when 'SPARE_PARTS' then '散备件'
           when 'GRADE_B' then '准新机'
           when 'GRADE_A' then '等级机'
           when 'GRADE_B1' then 'B1等级机'
           when 'GRADE_B2' then 'B2等级机'
           when 'GRADE_B3' then 'B3等级机'
           when 'PURCHASED_GIFTS' then '外购赠品'
           when 'PROTOTYPE_A' then '样机A'
           when 'PROTOTYPE_B' then '样机B'
           when 'HANDLE_A' then '处理机A'
           when 'HANDLE_B' then '处理机B'
           when 'INSPECT' then '待检机'
           when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
           when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
           else b.product_grade end as 商品等级,
       b.product_sap_id             as 产品sapid,
       b.sn_code                    as sn码,
       b.quantity                   as 申请数量,
       b.receiver_addr              as 终端收货地址,
       b.receiver                   as 收货人姓名,
       b.receiver_mobile            as 收货人手机,
       case b.status
           when 'DELIVERED' then '已发货'
           when 'WAITDELIVER' then '待发货'
           when 'CLOSED' then '关闭'
           when 'NORMAL' then '正常'
           else b.status end        as 状态,
       b.remark                     as 备注
from dmp_sales_order.ims_prototype_order a
         join dmp_sales_order.ims_prototype_order_line b
              on a.prototype_order_id =
                 b.prototype_order_id
where a.prototype_order_type = 'OFF_LINE'
  and a.creation_date >= '2025-01-01';

select a.prototype_order_code             as 样机订单号,
       case a.return_flag
           when 'Y' then '归还'
           when 'N' then '不归还'
           else a.return_flag end         as 是否归还,
       case a.order_delivery_type
           when 'MARKETING' then '营销仓'
           when 'FACTORY_IMS' then '国内工厂仓'
           when 'FACTORY_OMS' then '国际工厂仓'
           else a.order_delivery_type end as 样机领用仓库,
       case a.ship_flag
           when 'Y' then '自提'
           when 'N' then '快递'
           else a.ship_flag end           as 样机发货方式,
       case a.center_type
           when 'FUNCTION' then '职能'
           when 'MANUFACTURE' then '制造'
           when 'RESEARCH' then '研发'
           when 'SALES' then '销售'
           else a.center_type end         as 中心类型,
       z.meaning                          as 用途分类,
       a.apply_person_name                as 申请人,
       a.customer_name                    as 所属客户名称,
       a.apply_reason                     as 申请原因,
       c.org_name                         as 申请人部门,
       a.cost_center_code                 as 申请人部门成本中心编码,
       d.cost_center_name                 as 申请人部门成本中心名称,
       e.fee_asc_code                     as 申请人费用归属,
       b.product_sap_id                   as 产品sapid,
       b.product_sku                      as 产品sku,
       b.product_name                     as 物料名称,
       case b.product_grade
           when 'BLP' then '不良品'
           when 'STANDARD' then '大货'
           when 'SPARE_PARTS' then '散备件'
           when 'GRADE_B' then '准新机'
           when 'GRADE_A' then '等级机'
           when 'GRADE_B1' then 'B1等级机'
           when 'GRADE_B2' then 'B2等级机'
           when 'GRADE_B3' then 'B3等级机'
           when 'PURCHASED_GIFTS' then '外购赠品'
           when 'PROTOTYPE_A' then '样机A'
           when 'PROTOTYPE_B' then '样机B'
           when 'HANDLE_A' then '处理机A'
           when 'HANDLE_B' then '处理机B'
           when 'INSPECT' then '待检机'
           when 'PROTOTYPE_A_ZTBH' then '样机A只退不换'
           when 'PROTOTYPE_B_ZTBH' then '样机只退不换'
           else b.product_grade end       as 商品等级,
       b.fee_asc_name                     as 费用归属名称,
       b.cost_center_name                 as 成本中心名称,
       b.cost_center_code                 as 成本中心编码,
       b.quantity                         as 申请数量,
       b.sn_code                          as sn码,
       case b.return_flag
           when 'Y' then '归还'
           when 'N' then '不归还'
           else b.return_flag end         as 是否归还,
       b.receiver                         as 收货人,
       b.receiver_mobile                  as 收货人手机,
       b.province                         as 省,
       b.city                             as 市,
       b.area                             as 区,
       b.receiver_addr                    as 收货地址,
       b.remark                           as 备注
from dmp_sales_order.ims_prototype_order a
         join dmp_sales_order.ims_prototype_order_line b
              on a.prototype_order_id =
                 b.prototype_order_id
         left join saaf.base_organization c
                   on a.person_dept_code =
                      c.org_code
         left join dmp_sales_order.ims_prototype_order_safekeep_configure d
                   on a.cost_center_code =
                      d.cost_center_code
         left join dmp_sales_order.ims_prototype_order_safekeep_configure e
                   on d.dept_code = e.dept_code
         left join saaf.base_lookup_values z
                   on a.use_class =
                      z.lookup_code and
                      z.lookup_type =
                      'IMS_PROTOTYPE_USE_CLASS_ALL'
where a.creation_date >= '2025-01-01';
