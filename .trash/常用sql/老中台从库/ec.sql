select * from ec_shop where shop_no  in (
3008624,
3008649,
3008669,
3008680
    );

insert into `platform-ec`.ec_shop (name,shop_no,seller_nick,seller_name,enabled,creater,create_time,modifier,modify_time,version,source_type,show_name)
select distributor_name name, distributor_code shop_no,distributor_name seller_nick,customer_short_name seller_name,'1' enabled,'admin' creater,'1778204178278' create_time,'admin' modifier,'1778204178278' modify_time,'0' version,'B2C' source_type,distributor_name show_name from `platform-dist`.dist_distributor where distributor_code in (
3008624,
3008649,
3008669,
3008680
    );

select * from ec_shop where shop_no = '3008581';
update ec_shop set show_name = name where id =175;

select * from ec_user where username = 'tina.feng';
