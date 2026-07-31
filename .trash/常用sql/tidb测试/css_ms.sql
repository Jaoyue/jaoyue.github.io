select * from ms_door_installation_order order by id desc;

create table ms_door_installation_agent_solution
(
    id                            bigint auto_increment
        primary key,
    repair_order_no               varchar(50)                           null comment '上门安装单单号',
    status                        varchar(50)                           null comment '状态',
    agent_solution                          text                                  null comment '智能方案',
    created_by                    int                                   null comment '创建人',
    creation_date                 datetime    default CURRENT_TIMESTAMP null comment '创建时间',
    last_update_date              datetime    default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '最后更新时间',
    last_updated_by               int                                   null comment '最后更新人',
    last_update_login             int                                   null comment '最后更新人',
    version_num                   int         default 0                 null comment '版本号',
    delete_flag                   int         default 0                 null comment '删除标识:0.否, 1.是'
)
    comment '上门安装智能方案表';

select * from ms_door_installation_order_item order by id desc;
select distinct material_no,product_name from ms_door_installation_order_item order by id desc;

select * from ms_door_installation_agent_solution


