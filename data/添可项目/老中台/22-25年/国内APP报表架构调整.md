> HTML 页面: [[page/wiki/data/添可项目/老中台/22-25年/国内APP报表架构调整.html|打开 HTML 页面]]

### 1.管理中心缓存修改

数据类型=分销商销售大区

“前置家装”改名为“家居”

“厦门分部”改名为“福州分部”

新增“集采” JCPT

新增“中免” ZHONGMIAN

商超  SUPERMARKET

下沉  SINKCHANNEL

**goms数据字典同步修改**

**CUSTOMER_SALES_AREA**

**CUSTOMER_SALES_AREA_SHOP**

### 2.StoreExtend中增加经销店

```java
DEALER_STORE("经销店"), // 20260106新增：经销店
```

需要修改项目：老中台，dbu-trade-flow，dbu-sales-promotion

**sp_store_extend_config_app_search app筛选缓存修改 授权店改为经销店 GRANT_WORKSPACE -> DEALER_STORE  **

goms数据字典CUSTOMER_GRADE增加 

123 经销店