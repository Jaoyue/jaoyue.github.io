> HTML 页面: [[page/wiki/data/添可项目/派恩/需求/一键获取戴明dfmea.html|打开 HTML 页面]]

### sql
```sql
ALTER TABLE `pyne_agent`.`pn_product` 
ADD COLUMN `dm_code` varchar(1000) NULL COMMENT '产品编码',
ADD COLUMN `product_class` varchar(50) NULL COMMENT '产品类型';
```

### 配置
```yaml
deming:
    appkey: 68636e9b0294ce41f1a6848a
    getTaskIdUrl: https://qas-apim-gw.ecovacs.cn/restcloud/ai-apps/v1/openapi/deming/functionCommon/getConfirmedTaskListByProductNo
    getDfmeaTableUrl: https://qas-apim-gw.ecovacs.cn/restcloud/ai-apps/v1/openapi/deming/functionCommon/getTabContentListByTabIds
```

