### 1.添加智能体卡片
### 2.授权给香农,获取授权码
### 3.时序图
![](https://cdn.nlark.com/yuque/__mermaid_v3/4c1f8e780afd5e7fbff23d96b512a5fe.svg)

### 4.sql
```plsql
create table pn_hinton_task
(
  id                  bigint auto_increment comment 'id'
  primary key,
  create_by           varchar(50)  null comment 'create_by',
  create_time         datetime     null comment 'create_time',
  update_by           varchar(50)  null comment 'update_by',
  update_time         datetime     null comment 'update_time',
  is_deleted          tinyint      null comment '禁用启用 0：启用  1禁用',
  version             int          null comment 'version',
  call_id          varchar(50)  null comment '任务id',
  domain_account           varchar(100) null comment '任务用户',
  param           text null comment '任务参数',
  callback_url    varchar(500) null comment '回调接口',
  task_type    varchar(100) null comment '任务类型',
  task_name    varchar(255) null comment '任务名称',
  task_status    varchar(50) null comment '任务状态'
)
    comment '辛顿任务';
    alter table pyne_agent.pn_agent_log
    add call_id varchar(50) null comment '辛顿任务id';
    alter table pyne_agent.pn_repair_assessment_process
    modify product_id bigint null comment '产品id';
```

### 5.珊瑚工作流增加香农dfs内容
### 6.代码对香农dfs内容处理








