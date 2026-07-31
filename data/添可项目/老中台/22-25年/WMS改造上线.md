### inqurie
#### 配置:
```yaml
snEsbConfig:
  esbAppKey: 62f5f201bfd0f10d93e7fa19
  snRecordUrl: https://t-esb-gateway.tineco.com/restcloud/wms-api/v1/oms/querysn
  snStoreOrderUrl: https://t-esb-gateway.tineco.com/restcloud/dbu-store/v1/api/storeEwm/getSalesOrder4Sn
```

### distributor-front
#### 1.更新pom依赖版本(ims-api)
#### 2.数据库加字段
```sql
ALTER TABLE `dmp_sales_order`.`ims_delivery_sign`
ADD COLUMN `push_tms_flag` char(1) NULL DEFAULT 'N' COMMENT '推送TMS';
```

#### 3.配置
```yaml
inventory:
    pushTms: https://t-esb-gateway.tineco.com/restcloud/tms/datahubjson/FLUXTMSGOMS/PUTAPPSIGN
```

### 老中台
#### 门店配置 <font style="color:#6a8759;">sp_new_wms_flag</font>
<font style="color:rgb(81, 90, 110);">wms_esb_url </font>[https://esb-gateway.tineco.com](https://esb-gateway.tineco.com)

<font style="color:rgb(81, 90, 110);background-color:rgb(245, 245, 245);">wms_esb_appkey </font><font style="color:rgb(81, 90, 110);background-color:rgb(249, 249, 249);">630ef8c859ab2a60b458ef94</font>

#### 分销配置 <font style="color:#6a8759;">dist_wms_switch</font>
