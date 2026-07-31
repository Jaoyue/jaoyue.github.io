select * from sys_privilege where `key` = 'mgr_api_experence_delete';
select * from sys_privilege where `uri` = '/product/syncPriceFromSie';

select * from sys_function where id in (select function_id from sys_function_privilege where privilege_id = 4979);

select * from sys_user where username = 'evan.shen';
select * from sys_function where id in (
select function_id from sys_user_function where user_id = 1179);

select * from sys_user where username = 'zhaoyue.zy';
select * from sys_user where name = '于超';