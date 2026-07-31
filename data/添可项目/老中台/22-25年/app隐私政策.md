> HTML 页面: [[page/wiki/data/添可项目/老中台/22-25年/app隐私政策.html|打开 HTML 页面]]

```sql
create table sp_app_policy
(
    id             bigint auto_increment comment '主键,自增'
        primary key,
    delete_flag    int                      not null comment '是否被删除，0：否  1：是',
    creater        varchar(50) charset utf8 not null comment '创建者',
    create_time    bigint                   not null comment '创建时间',
    modifier       varchar(50) charset utf8 not null comment '更新者',
    modify_time    bigint                   not null comment '更新时间',
    version        bigint                   not null comment 'version',
    policy_type    varchar(50)              not null comment '政策类型',
    policy_version varchar(255)             null comment '政策版本',
    policy_status varchar(50)             null comment '政策状态',
    policy_url     varchar(500)             null comment '政策url'
);
```

