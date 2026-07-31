select * from sys_privilege where `key` = 'mgr_api_experence_delete'
select * from sys_privilege where `uri` = '/prototype/num/getStoreExtendConfig'

select * from sys_function where id in (select function_id from sys_function_privilege where privilege_id = 5269);

select * from sys_user where username = 'evan.shen';
select * from sys_function where id in (
select function_id from sys_user_function where user_id = 1179) and id = 2038;

select * from business_dictionary where type = 'DISTRIBUTOR_SALE_AREA' and status = 'ENABLED'
select * from business_dictionary where type = 'DISTRIBUTOR_SALE_AREA' and VALUE like '%商超%'

