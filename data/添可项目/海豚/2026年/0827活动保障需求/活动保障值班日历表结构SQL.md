-- auto-generated ops_activity_assurance
create table ops_activity_assurance
(
    id                     bigint unsigned auto_increment  comment 'id'
        primary key,
    activity_no            varchar(100)                          null comment '活动编号（ATHB开头）',
    activity_name          varchar(200)                          null comment '活动名称',
    activity_desc          text                                  null comment '活动描述',
    ai_activity_level      varchar(20)                           null comment 'AI活动等级（MAJOR_SUPPORT/REGULAR_SUPPORT）',
    activity_level         varchar(20)                           null comment '人工活动等级',
    assurance_dept         varchar(100)                          null comment '保障部门',
    assurance_dept_ai      varchar(100)                          null comment 'AI保障部门',
    assurance_leader       varchar(100)                          null comment '保障负责人',
    assurance_leader_id    varchar(100)                          null comment '保障负责人域账号',
    assurance_leader_ai    varchar(100)                          null comment 'AI保障负责人',
    assurance_leader_id_ai varchar(100)                          null comment 'AI保障负责人域账号',
    activity_status        varchar(20) default 'PENDING'         null comment '活动状态',
    submitter_name         varchar(100)                          null comment '提报人名称',
    submitter_account      varchar(100)                          null comment '提报人域账号',
    start_time             datetime                              null comment '活动开始时间',
    end_time               datetime                              null comment '活动结束时间',
    review_time            datetime                              null comment '复盘时间',
    review_status          varchar(20)                           null comment '复盘状态：DRAFT/REVIEWING/SUBMITTED',
    review_guard_flag      varchar(20)                           null comment '复盘守门标识：NOT_GUARDED/GUARDED',
    review_guard_type      varchar(20)                           null comment '复盘守门类型：SILICON_GUARDED/CARBON_GUARDED',
    review_fault_ids       varchar(500)                          null comment '复盘关联故障ID列表（多个逗号分隔）',
    ai_plan_status         varchar(20) default 'NOT_GENERATED'   null comment 'AI方案状态',
    plan_guard_flag        varchar(20) default 'NOT_GUARDED'     null comment '方案守门标识',
    plan_guard_status      varchar(20) default 'NOT_GUARDED'     null comment '方案守门状态',
    ai_action_status       varchar(20) default 'NOT_GENERATED'   null comment 'AI行动计划状态',
    task_platform_task_id  varchar(100)                          null comment '任务中心守门任务ID',
    review_remind_task_id  varchar(100)                          null comment '活动复盘提醒任务中心任务ID（非空即已推送过复盘提醒）',
    version                int         default 0                 null comment '版本号（乐观锁）',
    create_time            timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by              varchar(50) default ''                null comment 'create_by',
    update_time            timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by              varchar(50) default ''                null comment 'update_by',
    is_deleted             tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动保障主表';

create index idx_activity_no
    on ops_activity_assurance (activity_no);

create index idx_activity_status
    on ops_activity_assurance (activity_status);

create index idx_assurance_leader
    on ops_activity_assurance (assurance_leader_id);

create index idx_submitter
    on ops_activity_assurance (submitter_account);

-- auto-generated ops_activity_timeline
create table ops_activity_timeline
(
    id             bigint unsigned auto_increment  comment 'id'
        primary key,
    activity_id    bigint                                not null comment '关联活动主表ID',
    start_time     datetime                              null comment '开始时间',
    end_time       datetime                              null comment '结束时间',
    core_task_desc varchar(500)                          null comment '核心任务说明',
    timeline_type  varchar(20)                           null comment '类型（STARTUP/STRESS_TEST/WARMUP/BURST）',
    sort_order     int         default 0                 null comment '排序序号',
    version        int         default 0                 null comment '版本号（乐观锁）',
    create_time    timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by      varchar(50) default ''                null comment 'create_by',
    update_time    timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by      varchar(50) default ''                null comment 'update_by',
    is_deleted     tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动时间轴表';

create index idx_activity_id
    on ops_activity_timeline (activity_id);

-- auto-generated ops_activity_plan_version
create table ops_activity_plan_version
(
    id                  bigint unsigned auto_increment comment '主键'
        primary key,
    activity_id         bigint            not null comment '关联活动主表ID',
    version_no          varchar(20)       not null comment '版本号（V1, V2, ...）',
    plan_text           longtext          null comment '方案文本（AI生成或人工纠偏统一存储）',
    activity_level      varchar(20)       null comment '人工活动等级',
    assurance_dept      varchar(100)      null comment '保障部门',
    assurance_leader    varchar(100)      null comment '保障负责人',
    assurance_leader_id varchar(100)      null comment '保障负责人域账号',
    is_guard            tinyint default 0 not null comment '是否守门：0否 1是',
    source              varchar(20)       null comment '来源：AI_GENERATED / MANUAL_EDITED',
    operator_account    varchar(100)      null comment '操作人域账号',
    operator_name       varchar(100)      null comment '操作人姓名',
    version             int     default 0 null comment '版本号（乐观锁）',
    create_time         datetime          null comment '创建时间',
    create_by           varchar(100)      null comment '创建人',
    update_time         datetime          null comment '更新时间',
    update_by           varchar(100)      null comment '更新人',
    is_deleted          int     default 0 not null comment '是否删除：0否 1是'
)
    comment '活动AI方案版本表';

create index idx_activity_id
    on ops_activity_plan_version (activity_id);

-- auto-generated ops_activity_review_fault
create table ops_activity_review_fault
(
    id             bigint unsigned auto_increment  comment 'id'
        primary key,
    activity_id    bigint                                not null comment '关联活动保障主表ID',
    fault_id       bigint                                not null comment '关联故障ID',
    fault_no       varchar(100)                          null comment '故障编码',
    fault_desc     text                                  null comment '故障描述',
    fault_level    varchar(50)                           null comment '故障等级',
    product_name   varchar(200)                          null comment '产品名称',
    product_module varchar(200)                          null comment '产品模块',
    department     varchar(100)                          null comment '所属部门',
    version        int         default 0                 null comment '版本号',
    create_time    timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by      varchar(50) default ''                null comment 'create_by',
    update_time    timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by      varchar(50) default ''                null comment 'update_by',
    is_deleted     tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动复盘关联故障表';

create index idx_activity_id
    on ops_activity_review_fault (activity_id);

create index idx_fault_id
    on ops_activity_review_fault (fault_id);

-- auto-generated ops_activity_review_version
create table ops_activity_review_version
(
    id               bigint unsigned auto_increment  comment 'id'
        primary key,
    activity_id      bigint                                not null comment '关联活动主表ID',
    version_no       varchar(20)                           null comment '版本号（V1, V2, ...）',
    review_report    longtext                              null comment '该版本复盘报告内容',
    is_guard         tinyint     default 0                 not null comment '是否守门：0否 1是',
    source           varchar(20)                           null comment '来源（AI_GENERATED/MANUAL_EDITED）',
    operator_account varchar(100)                          null comment '操作人域账号',
    operator_name    varchar(100)                          null comment '操作人姓名',
    version          int         default 0                 null comment '版本号（乐观锁）',
    create_time      timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by        varchar(50) default ''                null comment 'create_by',
    update_time      timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by        varchar(50) default ''                null comment 'update_by',
    is_deleted       tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动复盘版本表';

create index idx_activity_id
    on ops_activity_review_version (activity_id);

-- auto-generated ops_activity_action_plan
create table ops_activity_action_plan
(
    id                       bigint unsigned auto_increment  comment 'id'
        primary key,
    activity_id              bigint                                not null comment '关联活动主表ID',
    title                    varchar(200)                          null comment '标题',
    category                 varchar(50)                           null comment '计划分类',
    objective                text                                  null comment '目标',
    measure                  text                                  null comment '措施',
    responsible_person       varchar(100)                          null comment '责任人',
    responsible_person_id    varchar(100)                          null comment '责任人ID（域账号）',
    department               varchar(100)                          null comment '责任部门',
    expected_completion_time datetime                              null comment '预计完成时间',
    annotation               text                                  null comment '批注内容',
    guard_status             varchar(20) default 'NOT_GUARDED'     null comment '守门状态',
    guard_type               varchar(20)                           null comment '守门类型（SILICON_GUARDED/CARBON_GUARDED）',
    is_edited                int         default 0                 null comment '是否经过人工编辑',
    is_pushed                int         default 0                 null comment '是否已推送任务中心',
    is_annotated             int         default 0                 null comment '是否已批注',
    task_platform_task_id    varchar(100)                          null comment '任务中心任务ID',
    task_status              varchar(20) default 'NOT_STARTED'     null comment '任务中心状态',
    version                  int         default 0                 null comment '版本号（乐观锁）',
    create_time              timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by                varchar(50) default ''                null comment 'create_by',
    update_time              timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by                varchar(50) default ''                null comment 'update_by',
    is_deleted               tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动行动计划表';

create index idx_activity_id
    on ops_activity_action_plan (activity_id);

create index idx_guard_status
    on ops_activity_action_plan (guard_status);

-- auto-generated ops_activity_action_plan_log
create table ops_activity_action_plan_log
(
    id               bigint unsigned auto_increment comment 'id'
        primary key,
    action_plan_id   bigint                                not null comment '关联行动计划ID',
    activity_id      bigint                                not null comment '关联活动主表ID',
    operation_type   varchar(20)                           null comment '操作类型',
    operation_desc   varchar(500)                          null comment '操作描述',
    before_value     text                                  null comment '变更前值（JSON）',
    after_value      text                                  null comment '变更后值（JSON）',
    operator_account varchar(100)                          null comment '操作人域账号',
    operator_name    varchar(100)                          null comment '操作人姓名',
    version          int         default 0                 null comment '版本号（乐观锁）',
    create_time      timestamp   default CURRENT_TIMESTAMP null comment 'create_time',
    create_by        varchar(50) default ''                null comment 'create_by',
    update_time      timestamp   default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment 'update_time',
    update_by        varchar(50) default ''                null comment 'update_by',
    is_deleted       tinyint     default 0                 null comment 'is_deleted'
)
    comment '活动行动计划操作日志表'
   ;

create index idx_action_plan_id
    on ops_activity_action_plan_log (action_plan_id);

create index idx_activity_id
    on ops_activity_action_plan_log (activity_id);

-- auto-generated duty_item
create table duty_item
(
    id          bigint  unsigned                               not null comment '主键ID（ASSIGN_ID 雪花算法）'
        primary key,
    item_name   varchar(100)                          not null comment '事项名称',
    start_date  date                                  not null comment '开始日期',
    end_date    date                                  not null comment '结束日期',
    version     int         default 0                 not null comment '版本号（乐观锁）',
    create_by   varchar(50) default ''                null comment '创建人域账号',
    create_name varchar(50) default ''                null comment '创建人姓名',
    create_time timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_by   varchar(50) default ''                null comment '更新人域账号',
    update_name varchar(50) default ''                null comment '更新人姓名',
    update_time timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted  tinyint     default 0                 not null comment '是否删除 0-否 1-是'
)
    comment '值班事项表';

create index idx_item_name
    on duty_item (item_name);

-- auto-generated duty_schedule
create table duty_schedule
(
    id                bigint   unsigned                              not null comment '主键ID（ASSIGN_ID 雪花算法）'
        primary key,
    item_id           bigint                                not null comment '事项ID',
    duty_date         date                                  not null comment '值班日期',
    start_time        varchar(20)                           not null comment '开始时间',
    end_time          varchar(20)                           not null comment '结束时间',
    shift_type        varchar(20)                           not null comment '班次类型：site-现场，remote-远程',
    location_code     varchar(50)                           not null comment '值班地点编码（字典：DutyLocationEnum：PHASE_4/PHASE_6/PHASE_7/OLD_FACTORY）',
    location_name     varchar(100)                          null comment '值班地点名称（冗余，便于展示）',
    department_id     bigint                                not null comment '值班部门ID（关联 rev_department_config.id）',
    department_name   varchar(100)                          null comment '值班部门名称（冗余，来源 rev_department_config.department_name）',
    duty_persons      varchar(500)                          not null comment '值班人员，逗号分隔（冗余保留，逻辑不变）',
    duty_person_names varchar(1000)                         null comment '值班人员名称，逗号分隔（由值班人员明细同步，便于展示）',
    version           int         default 0                 not null comment '版本号（乐观锁）',
    create_by         varchar(50) default ''                null comment '创建人域账号（权限依据：仅创建人可编辑）',
    create_name       varchar(50) default ''                null comment '创建人姓名',
    create_time       timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_by         varchar(50) default ''                null comment '更新人域账号',
    update_name       varchar(50) default ''                null comment '更新人姓名',
    update_time       timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted        tinyint     default 0                 not null comment '是否删除 0-否 1-是'
)
    comment '值班表';

create index idx_department_id
    on duty_schedule (department_id);

create index idx_duty_date
    on duty_schedule (duty_date);

create index idx_item_date
    on duty_schedule (item_id, duty_date);

create index idx_item_id
    on duty_schedule (item_id);

create index idx_location_code
    on duty_schedule (location_code);

-- auto-generated duty_schedule_person
create table duty_schedule_person
(
    id               bigint   unsigned                              not null comment '主键ID（ASSIGN_ID 雪花算法）'
        primary key,
    schedule_id      bigint                                not null comment '值班ID（关联 duty_schedule.id）',
    person_account   varchar(50)                           null comment '值班人员域账号（可选，便于后续扩展）',
    person_name      varchar(100)                          not null comment '值班人员姓名',
    person_dept_name varchar(100)                          null comment '值班人员所属部门（冗余，便于扩展）',
    sort_order       int         default 0                 not null comment '排序',
    version          int         default 0                 not null comment '版本号（乐观锁）',
    create_by        varchar(50) default ''                null comment '创建人域账号',
    create_name      varchar(50) default ''                null comment '创建人姓名',
    create_time      timestamp   default CURRENT_TIMESTAMP not null comment '创建时间',
    update_by        varchar(50) default ''                null comment '更新人域账号',
    update_name      varchar(50) default ''                null comment '更新人姓名',
    update_time      timestamp   default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间',
    is_deleted       tinyint     default 0                 not null comment '是否删除 0-否 1-是'
)
    comment '值班人员明细表';

create index idx_person_account
    on duty_schedule_person (person_account);

create index idx_person_name
    on duty_schedule_person (person_name);

create index idx_schedule_id
    on duty_schedule_person (schedule_id);