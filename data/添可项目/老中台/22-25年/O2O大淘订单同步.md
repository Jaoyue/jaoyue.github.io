> HTML 页面: [[page/wiki/data/添可项目/老中台/22-25年/O2O大淘订单同步.html|打开 HTML 页面]]

```sql
CREATE TABLE `platform-store`.`sp_store_datao`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
  `creater` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `modifier` varchar(50) NOT NULL COMMENT '修改人',
  `modify_time` bigint(20) NOT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '版本',
  `delete_flag` int(10) NOT NULL DEFAULT 0 COMMENT '删除标记',
  `store_no` varchar(20) NOT NULL COMMENT '门店编码',
  `store_datao_id` varchar(100) NOT NULL COMMENT '门店大淘id'
) AUTO_INCREMENT = 1  ROW_FORMAT = Compact COMMENT '门店大淘关联表';

CREATE TABLE `platform-store`.`sp_staff_datao`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT 'id',
  `creater` varchar(50) NOT NULL COMMENT '创建人',
  `create_time` bigint(20) NOT NULL COMMENT '创建时间',
  `modifier` varchar(50) NOT NULL COMMENT '修改人',
  `modify_time` bigint(20) NOT NULL COMMENT '修改时间',
  `version` bigint(20) NOT NULL DEFAULT 0 COMMENT '版本',
  `delete_flag` int(10) NOT NULL DEFAULT 0 COMMENT '删除标记',
  `staff_username` varchar(100) NOT NULL COMMENT '人员域名',
  `staff_datao_id` varchar(100) NOT NULL COMMENT '人员大淘id'
) AUTO_INCREMENT = 1  ROW_FORMAT = Compact COMMENT '人员大淘关联表';


```

#### 加缓存
<font style="color:rgb(81, 90, 110);background-color:rgb(249, 249, 249);">sp_store_datao_import_modal </font>

| <font style="color:rgb(81, 90, 110);">   </font><font style="color:rgb(81, 90, 110);">https://dbu-file.tineco.cn:7443/data/dbu/store/2025-05-09/ec96e349-0eea-442e-8e30-b952536e0562.xlsx</font> |
| --- |


<font style="color:rgb(81, 90, 110);background-color:rgb(249, 249, 249);">sp_staff_datao_import_modal</font>

<font style="color:rgb(81, 90, 110);background-color:rgb(249, 249, 249);">></font>[https://dbu-file.tineco.cn:7443/data/dbu/store/2025-05-12/8e2bd373-7391-401e-af32-bab3a9c886f7.xlsx](https://dbu-file.tineco.cn:7443/data/dbu/store/2025-05-12/8e2bd373-7391-401e-af32-bab3a9c886f7.xlsx)



### 加菜单权限
### 加定时任务
```sql
INSERT INTO `platform-store`.`sp_task` (`id`, `name`, `params`, `classpath`, `status`, `creater`, `create_time`, `modifier`, `modify_time`, `version`, `mode`, `cron_expression`, `repeat_interval`, `repeat_count`, `trigger_time`) VALUES (28, '同步O2O大淘单据', '{\"syncTime\":\"2025-05-14\"}', 'com.ecovacs.store.mgr.controller.task.O2ODataoOrderSyncTask', 'SUCCESS', 'SYSTEM', 1747238400000, 'SYSTEM', 1747238400000, 0, 'CRON', '0 * * * * ? *', NULL, NULL, NULL);

```

LTS加定时任务, 1小时一次

