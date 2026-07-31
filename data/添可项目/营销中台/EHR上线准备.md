> HTML 页面: [[page/wiki/data/添可项目/营销中台/EHR上线准备.html|打开 HTML 页面]]

## 1.备份数据, 确认新增表新增字段(红色sql之前已经执行过,此次上线忽略)

|   |   |
|---|---|
|CSS|CREATE TABLE base_person_bk331 LIKE base_person;  <br>INSERT INTO base_person_bk331 SELECT * FROM base_person;  <br>CREATE TABLE base_users_bk331 LIKE base_users;  <br>INSERT INTO base_users_bk331 SELECT * FROM base_users;  <br>CREATE TABLE base_organization_bk331 LIKE base_organization;  <br>INSERT INTO base_organization_bk331 SELECT * FROM base_organization;<br><br>CREATE TABLE base_person_organization_bk331 LIKE base_person_organization;  <br>INSERT INTO base_person_organization_bk331 SELECT * FROM base_person_organization;<br><br>update `css_saaf`.`base_person` set acct_sts_cd = 1 where quit_date is null or quit_date > now();  <br>update `css_saaf`.`base_person` set acct_sts_cd = 0 where quit_date is not null and quit_date <= now();<br><br>CREATE TABLE `css_saaf`.`base_person_job_stor` (  <br>`person_job_stor_id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY COMMENT '主键',  <br>`creation_date` date NULL DEFAULT NULL COMMENT '创建时间',  <br>`created_by` int(11) NULL DEFAULT NULL COMMENT '创建人',  <br>`last_update_date` date NULL DEFAULT NULL COMMENT '更新时间',  <br>`last_updated_by` int(11) NULL DEFAULT NULL COMMENT '更新人',  <br>`last_update_login` int(11) NULL DEFAULT NULL COMMENT '最后登录ID',  <br>`delete_flag` int(11) NULL DEFAULT 0 COMMENT '删除标识',  <br>`version_num` int(11) NULL DEFAULT 0 COMMENT '版本号',  <br>`person_id` int(11) NULL DEFAULT NULL COMMENT '员工id',  <br>`job_dpt` varchar(50) NULL DEFAULT NULL COMMENT '部门编码',  <br>`stor_cd` varchar(50) NULL DEFAULT NULL COMMENT '门店编码',  <br>`job_no` varchar(50) NULL DEFAULT NULL COMMENT '岗位编号',  <br>`job_name` varchar(50) NULL DEFAULT NULL COMMENT '岗位名称',  <br>`job_main` varchar(10) NULL DEFAULT NULL COMMENT '是否主岗 Y是 N否',  <br>`job_start` varchar(50) NULL DEFAULT NULL COMMENT '起始日期',  <br>`job_end` varchar(50) NULL DEFAULT NULL COMMENT '截止日期',  <br>`job_state` varchar(50) NULL DEFAULT NULL COMMENT '状态'  <br>) AUTO_INCREMENT = 1 ROW_FORMAT = Compact COMMENT '员工岗位门店';<br><br>  <br><br>ALTER TABLE `css_saaf`.`base_person_job_stor`  <br>ADD INDEX `idx_person_id`(`person_id`) USING BTREE,  <br>ADD INDEX `idx_delete_flag`(`delete_flag`) USING BTREE;<br><br>ALTER TABLE `css_saaf_tst`.`base_person`  <br>ADD COLUMN `acct_sts_cd` varchar(10) NULL COMMENT '0冻结 1解冻',  <br>ADD COLUMN `identity_type` varchar(10) NULL COMMENT '身份类别',  <br>ADD COLUMN `remote_attendance` varchar(10) NULL COMMENT '是否异地考勤 Y:是；N:否';|
|老中台|CREATE TABLE `platform-admin`.sys_employee_bk331 LIKE `platform-admin`.sys_employee;  <br>INSERT INTO `platform-admin`.sys_employee_bk331 SELECT * FROM `platform-admin`.sys_employee;  <br>CREATE TABLE `platform-admin`.sys_user_bk331 LIKE `platform-admin`.sys_user;  <br>INSERT INTO `platform-admin`.sys_user_bk331 SELECT * FROM `platform-admin`.sys_user;  <br>CREATE TABLE sp_biz_staff_bk331 LIKE sp_biz_staff;  <br>INSERT INTO sp_biz_staff_bk331 SELECT * FROM sp_biz_staff;<br><br>  <br><br>ALTER TABLE `platform-admin`.`sys_employee`  <br>ADD COLUMN `source_id` int(11) NULL COMMENT '来源id',  <br>ADD COLUMN `acct_sts_cd` varchar(10) NULL COMMENT '0冻结 1解冻',  <br>ADD COLUMN `identity_type` varchar(10) NULL COMMENT '身份类别',<br><br>ADD COLUMN `remote_attendance` varchar(10) NULL COMMENT '异地考勤';|

## 2.确认依赖版本

## css-sasf-6.0项目BasePerson类增加字段acctStsCd/identityType/remoteAttendance, 增加类BasePersonJobStor  需要部署依赖供css-bs-base使用

## 3.发布服务

1.CSS base服务

2.老中台; common, admin, store-base, store-mgr, store-api

## 4.配置缓存

1.admin  employee_ehr_switch = true;  esb_url = [https://esb-gateway.tineco.com](https://t-esb-gateway.tineco.com)

2.store  employee_ehr_switch = true