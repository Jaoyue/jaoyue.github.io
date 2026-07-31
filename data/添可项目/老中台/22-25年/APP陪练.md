> HTML 页面: [[page/wiki/data/添可项目/老中台/22-25年/APP陪练.html|打开 HTML 页面]]

1.先在admin系统批量申请权限创建账号

2.同步用户到电商渠道

```sql
INSERT INTO `platform-ec`.`ec_user` (`sys_user_id`, `workno`, `name`, `nickname`, `username`, `password`, `status`, `department_name`, `position_name`, `level`, `adminDistributorPermissionFlag`, `adminDataPermissionFlag`, `creater`, `create_time`, `modifier`, `modify_time`, `version`, `adminRoomPermissionFlagId`,  `adminCategoryPermissionFlagId`) 
select id `sys_user_id`,workno,name,nickname,username,`password`,`status`,department_name,position_name,`level`,0 adminDistributorPermissionFlag,0 adminDataPermissionFlag,'admin' creater,1744560000000 create_time,'admin' modifier,1744560000000 modify_time,0 version,0 adminRoomPermissionFlagId,0 adminCategoryPermissionFlagId from `platform-admin`.`sys_user` where workno in ('T2917') and workno not in (select workno from `platform-ec`.`ec_user`)
```

3.点击同步至国内营销

