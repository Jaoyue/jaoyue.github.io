> HTML 页面: [[page/wiki/data/添可项目/老中台/2026年/20261016组织架构改造/APP地图切换组织架构改造上线方案.html|打开 HTML 页面]]

# 一.地图切换
## 缓存配置

==地图开关 map_search_provider tencent==
==地图key  sp_tencent_os_key 6DKBZ-BD53L-UGAPL-MW45Z-4XV4K-UXBFC==     

## SQL

```sql

-- 先复制表结构（完整结构：主键、索引、引擎、字符集）  
create table sp_store_info_bk_baidu like sp_store_info;  
-- 再插入数据  
insert into sp_store_info_bk_baidu select * from sp_store_info;

```

## 转换门店lbs为腾讯坐标

==/store/task/20200924/1053/run/translateStoreLbs==

# 二.组织架构改造
## 管理中心分部调整
==京津冀大区 改名 华北大区==
==辽吉大区 改名 东北大区==
==南昌分部 改名 江西区域==
==（枚举管理-分部名称同步改DISTRIBUTOR_SALE_AREA）==
## 大区调整
==大区分部改为缓存，枚举管理-大区分部配置==

## 省市区归属配置
分部要修改
==**指定大区**==

## 老中台缓存
==sp_store_extend_config_app_zdjg ：CITY_EXHIBITION_HALL,FLAGSHIP_STORE,KA_FLAGSHIP_STORE,FORMAL_STORE,KA_FORMAL_STORE,GRANT_WORKSPACE,KA_CHANNEL,OTHER,SMART_LIFE_CENTER,BRAND_FLAGSHIP_STORE,BRAND_EXPERIENCE_STORE,BOUTIQUE_STORE,SELECT_STORE==
## GOMS缓存修改
==**MANAGE_TYPE  MANAGE_TYPE_CUSTOMER** 中的==
==REGION 从 零售业务部 改为 大区==
==NEW_BUSINESS 改为 渠道发展部==
==LARGE_CLIENT 改为 大客户部==
### 分部缓存
#### CUSTOMER_SALES_AREA
==A024 京津冀大区 改名 华北大区==
==A013 辽吉大区 改名 东北大区==
==A025 南昌分部 改名 江西区域==
CUSTOMER_SALES_REGION（暂时不知道有什么用）

## 省代取消（当前省代的）门店/人员/客户 先刷省代再刷组织
==黑龙江 东北大区；==
==江西 江西区域；==
==其他 西安分部；==

## 服务发布：
==store-mgr,store-api==
==dist-mgr,dist-api==
## 业务操作：
1.组织架构变更；
2.确认省市区分部没问题，省代的分部修改；
3.更改省代客户的销售区域；
<<<SQL执行后>>>
<mark style="background:#ff4d4f">4.大区经理分部组织维护；</mark>
5.删除多余组织；
## SQL
```
-- 省代调整
update sp_store_info set workspace_type='OFFLINE_OTHER',sales_region = 'DONGBEI' where sales_region = 'SHENGDAI' and province_id = '230000' and store_extend in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_store_info set workspace_type='REGION',sales_region = 'DONGBEI' where sales_region = 'SHENGDAI' and province_id = '230000' and store_extend not in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_store_info set workspace_type='OFFLINE_OTHER',sales_region = 'NANCHANG' where sales_region = 'SHENGDAI' and province_id = '360000' and province_id = '230000' and store_extend in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_store_info set workspace_type='REGION',sales_region = 'NANCHANG' where sales_region = 'SHENGDAI' and province_id = '360000' and province_id = '230000' and store_extend not in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_store_info set workspace_type='OFFLINE_OTHER',sales_region = 'HUDONGER' where sales_region = 'SHENGDAI' and province_id not in ('230000','360000') and store_extend in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_store_info set workspace_type='REGION',sales_region = 'HUDONGER' where sales_region = 'SHENGDAI' and province_id not in ('230000','360000') and store_extend not in ('DIST_STORE','GRANT_WORKSPACE');  
update sp_biz_staff a,sp_biz_staff_store_permission b,sp_store_info c  set a.sales_region = c.sales_region where a.id = b.staff_id and b.store_id = c.id and a.sales_region = 'SHENGDAI';

-- 门店大区
update sp_store_info set sales_area = null where id is not null;  
update sp_store_info set sales_area = 'HUABEI' where sales_region in ('SHIJIAZHUANG');  
update sp_store_info set sales_area = 'DONGBEI' where sales_region in ('DONGBEI');  
update sp_store_info set sales_area = 'SUWAN' where sales_region in ('NANJING');  
update sp_store_info set sales_area = 'XIBEI' where sales_region in ('HUDONGER','XIBEI');  
update sp_store_info set sales_area = 'XINAN' where sales_region in ('CHONGQING','XINAN','KUNMING','NANNING');  
update sp_store_info set sales_area = 'HUAZHONG' where sales_region in ('HUAZHONG','CHANGSHA','SHENZHEN','HUANAN');  
update sp_store_info set sales_area = 'LUYU' where sales_region in ('QINGDAO','HUDONGYI','ZHENGZHOU');  
update sp_store_info set sales_area = 'DONGNAN' where sales_region in ('HANZHOU','XIAMEN','NANCHANG');  
update sp_store_info set sales_area = 'SHANGHAI' where sales_region in ('SHANGHAI');  
update sp_store_info set sales_area = 'SUZHOU' where sales_region in ('SUZHOU');
-- 组织
update sp_base_organization_area_config a,`platform-admin`.business_dictionary b,sp_base_organization c set a.org_code=c.org_code,a.org_name=c.org_name,a.org_code_path=c.org_code_path,a.org_name_path=c.org_name_path where a.sales_region = b.`key` and b.type = 'DISTRIBUTOR_SALE_AREA' and b.value = c.org_name and c.delete_flag = 0;  
update sp_store_info a,`platform-admin`.business_dictionary b,sp_base_organization c set a.org_id = c.id where a.sales_region = b.`key` and b.type = 'DISTRIBUTOR_SALE_AREA' and b.value = c.org_name and c.delete_flag = 0;  
update sp_base_organization_store a,sp_store_info b set a.org_id = b.org_id where a.store_id = b.id;  
update sp_biz_staff a,`platform-admin`.business_dictionary b,sp_base_organization c set a.org_id = c.id where a.sales_region = b.`key` and b.type = 'DISTRIBUTOR_SALE_AREA' and b.value = c.org_name and c.delete_flag = 0;  
update sp_base_organization_user a,sp_biz_staff b set a.org_id = b.org_id where a.user_id = b.id;  
update `platform-dist`.dist_distributor a,`platform-admin`.business_dictionary b,sp_base_organization c set a.org_id = c.id,a.org_code=c.org_code,a.org_name=c.org_name,a.org_code_path=c.org_code_path,a.org_name_path=c.org_name_path where a.sale_area = b.`key` and b.type = 'DISTRIBUTOR_SALE_AREA' and b.value = c.org_name and c.delete_flag = 0;  
update sp_base_organization_customer a,`platform-dist`.dist_distributor b set a.org_id = b.org_id where a.customer_id = b.id;

```