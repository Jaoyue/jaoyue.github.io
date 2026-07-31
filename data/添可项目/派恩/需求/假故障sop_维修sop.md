### 1.新建表
```sql
CREATE TABLE `pyne_agent`.`pn_fake_fault_sop_process`  (
  `id` bigint NOT NULL COMMENT 'id',
  `create_by` varchar(50) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '禁用启用 0：启用  1禁用',
  `version` int NULL DEFAULT NULL COMMENT '版本号',
  `process_code` varchar(50) NULL DEFAULT NULL COMMENT '流程编码',
  `product_id` bigint NOT NULL COMMENT '产品id',
  `product_name` varchar(255) NULL DEFAULT NULL COMMENT '产品名称',
  `company` varchar(50) NOT NULL COMMENT '公司',
  `refer_product_id` bigint NULL DEFAULT NULL COMMENT '参考品id',
  `refer_product_name` varchar(255) NULL DEFAULT NULL COMMENT '参考品名称',
  `general_fake_fault_sop_url` varchar(255) NULL COMMENT '通用假故障SOP',
  `jira_document_url` varchar(255) NULL COMMENT 'Jira资料',
  `functional_specification_url` varchar(255) NULL COMMENT '功能说明书',
  `reference_faq_url` varchar(255) NULL COMMENT '参考品FAQ',
  `current_faq_url` varchar(255) NULL COMMENT '本代FAQ',
  `new_product_first_order_notes_url` varchar(255) NULL COMMENT '新品首单注意事项',
  `result_file_url` varchar(255) NULL DEFAULT NULL COMMENT '结果文件',
  PRIMARY KEY (`id`)
)COMMENT '假故障SOP';
CREATE TABLE `pyne_agent`.`pn_repair_sop_process`  (
  `id` bigint NOT NULL COMMENT 'id',
  `create_by` varchar(50) NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(50) NULL DEFAULT NULL COMMENT '修改人',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  `is_deleted` tinyint NOT NULL DEFAULT 0 COMMENT '禁用启用 0：启用  1禁用',
  `version` int NULL DEFAULT NULL COMMENT '版本号',
  `process_code` varchar(50) NULL DEFAULT NULL COMMENT '流程编码',
  `product_id` bigint NOT NULL COMMENT '产品id',
  `product_name` varchar(255) NULL DEFAULT NULL COMMENT '产品名称',
  `company` varchar(50) NOT NULL COMMENT '公司',
  `refer_product_id` bigint NULL DEFAULT NULL COMMENT '参考品id',
  `refer_product_name` varchar(255) NULL DEFAULT NULL COMMENT '参考品名称',
  `result_file_url` varchar(255) NULL DEFAULT NULL COMMENT '结果文件',
  `repairability_issues_url` varchar(255) NULL COMMENT '可维修性问题表',
  `new_product_first_order_notes_url` varchar(255) NULL COMMENT '新品首单注意事项',
  `testing_issues_url` varchar(255) NULL COMMENT '测试问题点',
  `dfmea_url` varchar(255) NULL COMMENT 'DFMEA文件',
  `jira_document_url` varchar(255) NULL COMMENT 'Jira资料',
  PRIMARY KEY (`id`)
) COMMENT '维修SOP';
```

### 2.加配置
```sql
INSERT INTO `pyne_agent`.`pn_config` (`create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`, `version`, `config_key`, `config_value`, `config_desc`) VALUES ('system', '2025-06-10 00:00:00', 'system', '2025-06-10 00:00:00', 0, 0, 'agent_function_ffsApikey',
  'app-znnoKrLYivHMVp6nfmfulYzp', NULL);
INSERT INTO `pyne_agent`.`pn_config` (`id`, `create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`, `version`, `config_key`, `config_value`, `config_desc`) VALUES (24, 'system', '2025-06-10 00:00:00', 'system', '2025-06-10 00:00:00', 0, 0, 'agent_function_resApikey', 'app-TJVM0o6uchJFAf7W13bH8CRC', NULL);

```

