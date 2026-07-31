# select id as 编号,material_no as 物料号,level_flag as 等级,prototype_price as 价格,price_code as 价格编码 from `platform-store`.sp_prototype_level_price;
#
# select
#     a.name as 用户姓名,
#     a.work_no as 用户工号,
#     case a.user_type
#         when 'STAFF' then '业务员'
#         when 'CLERK' then '店员'
#         else a.user_type
#     end as 用户类型,
#     case a.position
#         when 'CENTER_EMPLOYEE' then '总部人员'
#         when 'CENTER_OFFLINE' then '线下总部'
#         when 'AREA_MANAGER' then '大区经理'
#         when 'REGION_MANAGER' then '分部经理'
#         when 'BIZ_MANAGER' then '渠道经理'
#         when 'BIZ_SUPERVISOR' then '零售经理'
#         when 'HALL_MANAGER' then '展厅经理'
#         when 'CENTER_FINANCE' then '总部财务'
#         when 'REGION_FINANCE' then '大区财务'
#         when 'OFFICIAL_SALES_CONSULTANT' then '官方销售顾问'
#         when 'AUTHORISED_SALES_CONSULTANT' then '授权销售顾问'
#         when 'TEMP_SALES_CONSULTANT' then '临时销售顾问'
#         else a.position
#     end as 用户职位,
#     a.phone as 用户手机,
#     b.org_name as 归属组织,
#     FROM_UNIXTIME(a.create_time / 1000, '%Y-%m-%d %H:%i:%s') as 创建时间,
#     case c.status
#         when 'ENABLED' then '成功'
#         when 'DISABLED' then '失败'
#         when 'FREEZE' then '冻结'
#         when 'TAKE_EFFECT' then '启用'
#         else c.status
#     end as 中台账号状态,
#     case a.staff_status
#         when 'ENABLED' then '启用'
#         when 'DISABLED' then '禁用'
#         when 'ONLEAVE' then '休假'
#         else a.staff_status
#     end as 状态
# from `platform-store`.sp_biz_staff a
# join `platform-store`.sp_base_organization b on a.org_id = b.id
# # join `platform-admin`.sys_user c on a.work_no = c.workno;
#
# select a.name as 网点名称,concat(b.area_name,'-',c.area_name,'-',d.area_name) as 省市区,a.address as 地址,e.value as 业务大区,f.value as 所属分部,
#        case a.status
#         when 'ENABLED' then '启用'
#         when 'DISABLED' then '禁用'
#         else a.status
#        end as 状态
# from `platform-store`.sp_store_workspace a
# left join `platform-admin`.sys_area b on a.province_id = b.area_id
# left join `platform-admin`.sys_area c on a.city_id = c.area_id
# left join `platform-admin`.sys_area d on a.district_id = d.area_id
# left join `platform-admin`.business_dictionary e on a.sales_area = e.`key` and e.type = 'SALE_AREA'
# left join `platform-admin`.business_dictionary f on a.sales_region = f.`key` and f.type = 'DISTRIBUTOR_SALE_AREA';
# select * from `platform-store`.sp_store_info;
#
# select a.store_no,a.name,a.type,a.store_extend,concat(a.channel_type,'-',a.channel),b.org_name,a.company_name,FROM_UNIXTIME(a.create_time / 1000, '%Y-%m-%d %H:%i:%s') as 创建时间,a.delete_flag,a.business_status from `platform-store`.sp_store_info a
# left join `platform-store`.sp_base_organization b on a.org_id = b.id;

# select
#     a.store_no as 终端编码,
#     a.name as 终端名称,
#     case a.type
#         when 'SPECIALTY' then '直营'
#         when 'DIST' then '经销'
#         else a.type
#     end as 终端模式,
#     case a.store_extend
#         when 'ZONGBU' then '总部'
#         when 'FORMAL_STORE' then '标准店'
#         when 'KA_FORMAL_STORE' then 'KA标准店'
#         when 'FLAGSHIP_STORE' then '旗舰店'
#         when 'KA_FLAGSHIP_STORE' then 'KA旗舰店'
#         when 'CITY_EXHIBITION_HALL' then '城市展厅'
#         when 'ERZHAN_STORE' then '二展店'
#         when 'SU_PRODUCT' then '苏宁大单机'
#         when 'OFFICE_STORE' then '办事处'
#         when 'DIST_STORE' then '经销商'
#         when 'DEALER_STORE' then '经销店'
#         when 'TRAN_PROTOTYPE' then '培训样机'
#         when 'SAM_PROTOTYPE' then '山姆大单机'
#         when 'CHAIN_PROTOTYPE' then '连锁网点'
#         when 'NOMRAL_PROTOTYPE' then '普通网点'
#         when 'COMMUNITY_PROTOTYPE' then '社群'
#         when 'APP_PROTOTYPE' then '私域'
#         when 'GM_PROTOTYPE' then '国美大单机'
#         when 'KSK_PROTOTYPE' then '开市客大单机'
#         when 'OTHER' then '其它'
#         when 'WORKSPACE' then '网点'
#         when 'GRANT_WORKSPACE' then '授权店'
#         when 'KA_CHANNEL' then 'KA渠道'
#         when 'KA_CHANNEL_B' then 'KA渠道B'
#         else a.store_extend
#     end as 终端类型,
#     concat(
#         case a.channel_type
#             when 'THREE_C' then '3C'
#             when 'GENERAL' then '百货'
#             when 'SHOPPING_MALL' then '购物中心'
#             when 'REGION_HOUSEHOLD' then '区域家电'
#             when 'SUPERMARKET' then '商超量贩'
#             when 'OTHER' then '其他'
#             when 'BUILDING_MATERIALS' then '家装建材'
#             when 'DIGIT_AIRPORT' then '数码机场'
#             when 'ZHONG_BAI' then '重百'
#             else a.channel_type
#         end,
#         '-',
#         case a.channel
#             when 'C_GOME' then '国美系'
#             when 'C_SUNING' then '苏宁系'
#             when 'C_JD' then '京东系'
#             when 'G_GENERAL' then '百货'
#             when 'S_SHOPPING_MALL' then '购物中心'
#             when 'REGION_HOUSEHOLD_TWO' then 'RKA'
#             when 'REGION_HOUSEHOLD_THREE' then 'LKA'
#             when 'SAM_MARKET' then '山姆'
#             when 'KSK_MARKET' then '开市客'
#             when 'OTHER_MARKET' then '其他'
#             when 'HOME_FURNISHING' then '家具'
#             when 'HOME_BUILDING' then '家博会'
#             when 'O_OTHER' then '其他'
#             when 'DIGITAL_MALL' then '数码集合'
#             when 'DIGITAL_MALL_NEW' then '数码集合'
#             when 'AIRPORT_MALL' then '机场'
#             when 'BUILDING_MATERIALS' then '家装建材'
#             else a.channel
#         end
#     ) as 零售业态,
#     b.org_name as 归属组织,
#     a.company_name as 上级客户,
#     FROM_UNIXTIME(a.create_time / 1000, '%Y-%m-%d %H:%i:%s') as 创建时间,
#     case a.delete_flag
#         when 0 then '启用'
#         when 1 then '禁用'
#         when 2 then '待开业'
#         when 3 then '冻结'
#         else a.delete_flag
#     end as 状态,
#     case a.business_status
#         when 'OS' then '待开业'
#         when 'DE' then '装修中'
#         when 'OP' then '营业中'
#         when 'RD' then '重装中'
#         when 'CS' then '闭店中'
#         when 'CL' then '已闭店'
#         else a.business_status
#     end as 营业状态
# from `platform-store`.sp_store_info a
# left join `platform-store`.sp_base_organization b on a.org_id = b.id;

# select a.name,a.clerk_no,max(c.name),a.model,a.position,max(e.name),a.type,a.account,a.phone,a.entry_time,a.create_time,a.creater,a.delete_flag from `platform-store`.sp_clerk_info a
# left join `platform-store`.sp_clerk_store b on a.id = b.clerk_id
# left join `platform-store`.sp_store_info c on b.store_id = c.id
# left join sp_clerk_role d on a.id = d.clerk_id
# left join sp_role e on d.role_id = e.id

select a.`key`,a.value,b.value from sp_config_enum a join `platform-admin`.business_dictionary b on a.`key` = b.`key`
where a.type = 'DISTRIBUTOR_SALE_AREA' and b.type = 'DISTRIBUTOR_SALE_AREA' and b.status = 'ENABLED' having a.value <> b.value;

