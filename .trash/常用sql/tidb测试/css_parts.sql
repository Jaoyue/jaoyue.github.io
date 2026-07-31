select *
from parts_quality_inspection_header group by parts_sn having count(*) > 1;
select *
from parts_quality_inspection_recheck;
select * from parts_quality_inspection_extend where quality_inspection_code = 'CSZJ250812000005';
select distinct * from parts_quality_inspection_header where quality_inspection_code in ('CSZJ250812000005','CSZJ250812000001');
select distinct * from parts_quality_inspection_header where parts_category = 'BATTERY_PACK';
select distinct header_id,quality_inspection_code,audit_status,audit_source,servicer_code,servicer_name,servicer_type,parts_sn,parts_code,generate_or_not from parts_quality_inspection_header where quality_inspection_code = 'CSZJ251204000004';
select * from parts_quality_inspection_recheck;
select * from parts_quality_inspection_header where parts_sn = 'BB62019014D392813';

CREATE TABLE IF NOT EXISTS parts_quality_inspection_extend
(
    id                      bigint auto_increment comment 'id'
        primary key,
    quality_inspection_code varchar(255)                       null comment '质检单号',
    sn_code                 varchar(64)                        null comment 'SN码',
    battery_version         varchar(32)                        null comment '电池版本号',
    cell_voltage1           decimal(5, 3)                      null comment '电芯1电压（V）',
    cell_voltage2           decimal(5, 3)                      null comment '电芯2电压（V）',
    cell_voltage3           decimal(5, 3)                      null comment '电芯3电压（V）',
    cell_voltage4           decimal(5, 3)                      null comment '电芯4电压（V）',
    cell_voltage5           decimal(5, 3)                      null comment '电芯5电压（V）',
    cell_voltage6           decimal(5, 3)                      null comment '电芯6电压（V）',
    cell_voltage7           decimal(5, 3)                      null comment '电芯7电压（V）',
    cell_pressure_diff      decimal(5, 3)                      null comment '电芯压差（V）',
    total_voltage           decimal(6, 3)                      null comment '电池总电压（V）',
    current_power           decimal(5, 2)                      null comment '当前电量（%）',
    remaining_power         decimal(5, 2)                      null comment '剩余电量（%）',
    bms_status              varchar(64)                null comment 'BMS状态',
    total_capacity          int                                null comment '电芯总容量（mAh）',
    cycle_times             int                                null comment '循环次数',
    charge_current          decimal(5, 2)                      null comment '充电电流（A）',
    battery_temp            decimal(4, 1)                      null comment '电池温度（℃）',
    agent_inspection_result    text                      null comment '智能质检结果',
    delete_flag             int      default 0                 not null comment '是否删除',
    created_by              int                                null comment '创建人',
    creation_date           datetime default CURRENT_TIMESTAMP null comment '创建时间',
    last_updated_by         int                                null comment '更新人',
    last_update_date        datetime default CURRENT_TIMESTAMP null on update CURRENT_TIMESTAMP comment '最后更新时间',
    last_update_login       int                                null comment '最后登录人',
    version_num             int      default 0                 not null comment '版本号'
) COMMENT '配件质检扩展表';

INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726901, 'CSZJ260410000101', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62411001F1C000D','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726902, 'CSZJ260410000102', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62376001F9N0245','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726903, 'CSZJ260410000103', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62123010D482748','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726904, 'CSZJ260410000104', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62123010D3W1528','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726905, 'CSZJ260410000105', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB62123006D5R5818','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726906, 'CSZJ260410000106', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB21230201C7U0156','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726907, 'CSZJ260410000107', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62123010D5F3039','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726908, 'CSZJ260410000108', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62343002EA8072E','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726909, 'CSZJ260410000109', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB02330004E4C4019','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726910, 'CSZJ260410000110', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM02376003F2P0499','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726911, 'CSZJ260410000111', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BG18790212B5V1456','114-21230019','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726912, 'CSZJ260410000112', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB18790209B437180','114-20190099','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726913, 'CSZJ260410000113', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB62221001D4D3427','114-20190099','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726914, 'CSZJ260410000114', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BM62019019D4A2746','114-20190099','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726915, 'CSZJ260410000115', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BC62019002D5N1797','114-20190099','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726916, 'CSZJ260410000116', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB62019014D3L2735','114-18790199','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726917, 'CSZJ260410000117', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB20190201BBS1056','114-22210013','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726918, 'CSZJ260410000118', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB20190201B9U4788','114-23260010','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726919, 'CSZJ260410000119', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BG61879004CC60315','114-23350116','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726920, 'CSZJ260410000120', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BG20110201B4H0093','114-24261408','N');
INSERT INTO css_parts_tst.parts_quality_inspection_header (header_id, quality_inspection_code, audit_status, audit_source, servicer_code, servicer_name, servicer_type, parts_sn, parts_code,generate_or_not) VALUES (2096452322713726921, 'CSZJ260410000121', 'QUALITY_GENERATE', 'PARTS_RETURN_FACTORY', '8200006', '添可电器苏州维修中心', '10', 'BB62125003CB20734','114-21250142','N');
select *from parts_quality_inspection_header where quality_inspection_code = 'CSZJ260410000102'