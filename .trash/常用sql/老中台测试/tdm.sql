select * from tdm_shop;

alter table `platform-domestic-marketing`.tdm_shop
    modify shop_name varchar(255) not null comment '店铺名称',
    modify abridge varchar(255) not null comment '缩略，简称';
select *
from tdm_user_info where device_id is not null;

alter table `platform-domestic-marketing`.tdm_user_info
    add device_id_type varchar(100) null comment '设备ID类型';

select * from tdm_user_info where remark is not null

select * from tdm_login_device_white
INSERT INTO `platform-domestic-marketing`.tdm_login_device_white (account, remark, creater, create_time, modifier, modify_time) VALUES ('hucheng.zhang', null, null, 0, null, null)
;
select * from tdm_experience_share_info where title_code = 'T002' and ext_status = 'FEATURED';
select * from tdm_experience_share_info where status is null;
update tdm_experience_share_info set title = '交流园地' where title = '提问反馈';
update tdm_experience_share_info set title = '销售金点子' where title = '心得体会';

select title_code as titleCode,count(1) as allNum,0 as noReadNum,
        0 as readNum,count(s.ext_status = 'FEATURED') as featuredNum
        from tdm_experience_share_info s
        where status ='ENABLE'  GROUP BY title_code

select * from tdm_experience_share_info;