select * from pn_product where name = '芙万2.0';

select * from pn_product_line where product_id = 99;

select * from pn_config where id = 31;

INSERT INTO pyne_agent.pn_config (create_by, create_time, update_by, update_time, is_deleted, version, config_key, config_value, config_desc) VALUES ('system', '2025-10-10 00:00:00', 'system', '2025-10-10 00:00:00', 0, 0, 'agent_obm_coral_flow_switch2', 'Y', null);
;
select * from pn_obm_mro_process where source_sys is null;

select count(*) from pn_repair_history_tineco;
select count(*) from pn_repair_history_ecovacs;
select * from pn_repair_history_tineco where sap_id in ('109-23250001') and actual_fault = '显示屏提示故障-提示“请尝试重启或联系客服”-电机故障';

select * from pn_corpus_data where corpus_name = 'PINE-维修排障-拆机视频';
select * from pn_corpus_data_detail where data_id in (select id from pn_corpus_data where corpus_name = 'PINE-维修排障-拆机视频');

select * from pn_product p join pn_product_line l on p.id = l.product_id

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件',b.file_content->'$.wxfa' AS '维修方案' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = 'DEEBOT N20系列'

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件',b.file_content->'$.wxfa' AS '维修方案' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = 'DEEBOT X8系列' and b.file_content->'$.kfgzbq' IN ('工作时间短')

INSERT INTO pyne_agent.pn_config (create_by, create_time, update_by, update_time, is_deleted, version, config_key, config_value, config_desc) VALUES ('system', '2025-10-10 00:00:00', 'system', '2025-10-10 00:00:00', 0, 0, 'agent_mro_coral_flow_switch', 'Y', null);
INSERT INTO pyne_agent.pn_config (create_by, create_time, update_by, update_time, is_deleted, version, config_key, config_value, config_desc) VALUES ('system', '2025-10-10 00:00:00', 'system', '2025-10-10 00:00:00', 0, 0, 'agent_mro_coral_flow_switch2', 'Y', null);

select l.sap_id from pn_product_line l
            join pn_product p on l.product_id = p.id
                        where p.is_deleted = 0
                          and p.name = '芙万3.0'
                          and p.company = 'tineco';

select * from pn_product_line;

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件',b.file_content->'$.wxfa' AS '维修方案' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = 'DEEBOT X5 系列' and b.file_content->'$.kfgzbq' IN ('机器异响/异音','启动后不吸尘/吸不干净')
;
select * from pn_agent_log where operator = 'doscs' and app_id is not null  order by id desc limit 1000;
select * from pn_agent_log where id = '1977980404861833217';
select * from pn_obm_mro_process where create_time > '2025-10-15 09:00:00' and source_sys = 'doscs' and if_execute = 1;
select min(start_time),max(end_time) from pn_obm_mro_process where create_time > '2025-10-15 09:00:00' and if_execute = 1 and source_sys = 'CSS';
select * from pn_obm_mro_process where process_code = 'OBM251014172036009';
select * from pn_agent_log where status = 'ERROR' AND operator = '派恩';
select * from pn_agent_log where  operator = '派恩' and create_time > '2025-10-14 00:29:38';
select * from pn_config;
select avg(end_time-start_time)/1000 from pn_obm_mro_process where source_sys = 'CSS' and create_time > '2025-10-15 09:00:00';
select avg(end_time-start_time)/1000 from pn_obm_mro_process where source_sys = 'doscs' and create_time > '2025-10-15 09:00:00';

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '芙万2.0' and b.file_content->'$.kfgzbq' IN ('(洗地机)无法自清洁')

select * from pn_obm_mro_process order by id desc limit 100;

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-拆机教程' and a.is_valid = 'Y' and a.company = 'TINECO'
;
select file_url from pn_corpus_data where corpus_name = 'PINE-维修排障-拆机教程' and is_valid = 'Y' and company = 'TINECO' and product_line_name = '悠尼3.0' limit 1;
select file_url from pn_corpus_data where corpus_name = 'PINE-维修排障-拆机视频' and is_valid = 'Y' and company = 'TINECO' and product_line_name = '悠尼3.0' limit 1;

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-可维修性评估表' and a.is_valid = 'Y' and a.product_line_name = '躺平1.0'
select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'c' and a.is_valid = 'Y' and a.product_line_name = '躺平2.0' and b.file_content->'$.kfgzbq' = '(洗地机)无法自清洁'

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '芙万2.0' and b.file_content->'$.kfgzbq' = '(洗地机)无法自清洁'
;
select avg(end_time-pn_obm_mro_process.start_time) from pn_obm_mro_process where create_time >= '2025-10-15 09:00:00' and create_time < '2025-10-15 10:00:00' and source_sys in ('CSS','doscs');
select min(start_time) from pn_obm_mro_process where create_time >= '2025-10-15 09:00:00' and create_time < '2025-10-15 10:00:00' and source_sys in ('CSS','doscs')
select max(end_time) from pn_obm_mro_process where create_time >= '2025-10-15 09:00:00' and create_time < '2025-10-15 10:00:00' and source_sys in ('CSS','doscs')

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-拆机视频' and a.is_valid = 'Y' and a.product_line_name = 'T80系列' and b.file_content->'$.part_name' IN ('')
;
select * from pn_repair_assessment_process where process_code in (select process_code from pn_agent_log where id = '1968585670318768130')

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-备件BOM-多级分类' and a.is_valid = 'Y' and a.company = 'ECOVACS'

select * from pn_product where name = 'T50系列';

select * from pn_config;

INSERT INTO pyne_agent.pn_config (create_by, create_time, update_by, update_time, is_deleted, version, config_key, config_value, config_desc) VALUES ('system', '2025-10-10 00:00:00', 'system', '2025-10-10 00:00:00', 0, 0, 'agent_ass_coral_flow_switch', 'Y', null);

select b.file_content
        from pn_corpus_data a
                 join pn_corpus_data_detail b on a.id = b.data_id
        where a.is_valid = 'Y'
and a.corpus_name = '';

select distinct occur_date,matl_code,matl_name,defective_phenom,fault_type from pn_bidata_deming_improvement_tineco;
select * from pn_bidata_deming_improvement_tineco where occur_date = '2025-11-07';
select count(*) from pn_bidata_deming_improvement_tineco;
ALTER TABLE pn_bidata_deming_improvement_tineco
MODIFY COLUMN id bigint NOT NULL AUTO_INCREMENT COMMENT 'id';
create table pn_bidata_deming_improvement_tineco
(
    id                  bigint auto_increment comment 'id'
        primary key,
    create_by           varchar(50)  null comment 'create_by',
    create_time         datetime     null comment 'create_time',
    update_by           varchar(50)  null comment 'update_by',
    update_time         datetime     null comment 'update_time',
    is_deleted          tinyint      null comment '禁用启用 0：启用  1禁用',
    version             int          null comment 'version',
    occur_date          varchar(50)  null comment '改善时间',
    matl_code           varchar(500) null comment '物料编码',
    matl_name           varchar(500) null comment '物料名称',
    defective_phenom    varchar(500) null comment '不良现象',
    defective_reason    varchar(500) null comment '不良原因',
    improvement_measure varchar(500) null comment '长期措施/改善措施',
    fault_type          varchar(500) null comment '故障标签'
)
    comment '戴明改善问题添可';
select * from pn_product where name = 'X11S family';
select * from pn_product_line;
INSERT INTO pyne_agent.pn_product (id, name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES (305, 'X11S family', 'P00305', 'ecovacs', 2, '2025-08-07 19:36:16', 'fd69e210acadc53bc98dc5c76bec39fa', '2025-11-05 17:55:50', 'c0b55960c434392fb3fa81e6c009197e', 0, 'ZJ2540', '地宝', 1);

select * from pn_agent_log where id = '1987818035096207361'
select * from pn_agent_log where status = 'ERROR' and create_time > '2025-11-05';
select * from pn_hinton_task;
select * from pn_obm_mro_process where process_code = 'OBM251110174205325'
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
    remark    varchar(500) null comment '备注',
    task_type    varchar(100) null comment '任务类型',
    task_name    varchar(255) null comment '任务名称',
    task_status    varchar(50) null comment '任务状态'
)
    comment '辛顿任务';
alter table pyne_agent.pn_agent_log
    add call_id varchar(50) null comment '辛顿任务id';

SELECT MAX(occur_date) FROM pn_bidata_deming_improvement_tineco where fault_type = '(洗地机)充电异常' and matl_code in ()
SELECT * FROM pn_bidata_deming_improvement_tineco where fault_type = '(洗地机)充电异常' and matl_code in ()
select REPLACE(b.file_content, ',', '，') as file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-故障分类' and a.is_valid = 'Y' and a.company = 'TINECO';

select b.file_content -> '$.kfgzbq' AS '故障类型',
       b.file_content -> '$.pj'     AS '配件',
       b.file_content -> '$.wxfa'   AS '维修方案'
from pn_corpus_data a
         join pn_corpus_data_detail b
              on a.id = b.data_id
where a.corpus_name = 'PINE-维修排障-SOP'
  and a.is_valid = 'Y'
  and a.product_line_name = 'T80系列'
  and b.file_content -> '$.kfgzbq' IN
      ('语音报警：清洁槽水满','污水无法回收');

select * from pn_agent_log where call_id is not null;
select * from pn_repair_assessment_process where process_code = 'ASS251112144626728';
select * from pn_hinton_task;
select * from pn_corpus_data where corpus_name = 'PINE-可维修性评估表' and company = 'TINECO' AND ;
select * from pn_corpus_data_detail;
select * from pn_dataset_upload_record limit 100,100;
select * from pn_obm_mro_process where create_time >= '2025-11-01 00:00:00';
select * from pn_config;
select * from pn_bom_part_tineco;
select * from pn_bom_part_ecovacs;
select * from pn_bom_dev_tineco where product_sap_id = '107-24510501' and upper_cpnt_code is not null order by level_number;
select * from pn_bom_dev_ecovacs where father_lvl_material_no is null;
select * from pn_part_bom_process;
select * from pn_repair_assessment_process;
select * from pn_product_line where sap_id = '109-20191301';
SELECT
    c.TABLE_SCHEMA AS '数据库名',
    c.TABLE_NAME AS '表名',
    t.TABLE_COMMENT AS '表注释',
    c.COLUMN_NAME AS '列名',
    c.COLUMN_TYPE AS '数据类型',
    c.COLUMN_COMMENT AS '列注释'
FROM INFORMATION_SCHEMA.COLUMNS c
JOIN INFORMATION_SCHEMA.TABLES t ON c.TABLE_SCHEMA = t.TABLE_SCHEMA AND c.TABLE_NAME = t.TABLE_NAME
WHERE c.TABLE_SCHEMA NOT IN ('information_schema', 'mysql', 'performance_schema', 'sys')
ORDER BY c.TABLE_SCHEMA, c.TABLE_NAME, c.ORDINAL_POSITION;
select * from pn_agent_log where process_code in(
select pn_obm_mro_process.process_code from pn_obm_mro_process where type = 'MRO'
  AND create_time > '2025-12-19 8:00:00') and scene_type = 'MRO_MRO_RETURN';
select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_no = 'PINE_R_ASSESS_CONSULTING_TOP' and a.is_valid = 'Y' and a.company = 'TINECO' and a.product_line_name = 'Station Pod'

select b.file_content
from pn_corpus_data a
         join pn_corpus_data_detail b
              on a.id = b.data_id
where a.corpus_no = 'PINE_R_ASSESS_CONSULTING_TOP'
  and a.is_valid = 'Y'
  and a.company = 'TINECO' and a.product_line_name = 'Station Pod';

select * from pn_agent_log where agent_type = 'OPH';
select * from pn_repair_assessment_process where process_code = 'ASS251225113006869'
select * from plus_function_task_export_record;
select * from pn_3r_quality_process;-- OBM251223180905421
select * from pn_obm_mro_process where process_code = 'OBM251223180905421';

select * from pn_config;
select * from pn_config;
INSERT INTO pyne_agent.pn_config (create_by,
                                  create_time,
                                  update_by,
                                  update_time,
                                  is_deleted,
                                  version,
                                  config_key,
                                  config_value,
                                  config_desc)
VALUES ('system', '2025-12-26 00:00:00',
        'system', '2025-12-26 00:00:00', 0, 0,
        'push_gantt_config',
        '[{"label":"ASS_P1","code":"ASS","project":"P1-方案设计&评审","taskNo":"P1T055","deliverNo":"P1P070"},{"label":"ASS_P2","code":"ASS","project":"P2-详细设计&验证","taskNo":"P2T113","deliverNo":"P2P080"},{"label":"ASS_P3","code":"ASS","project":"P3.2-EB试制","taskNo":"P4T132","deliverNo":"P4P078"},{"label":"ASS_P4","code":"ASS","project":"P4-PP试产","taskNo":"P6T021","deliverNo":"P7P008"},{"label":"ASS_P5","code":"ASS","project":"P5-MP量产","taskNo":"P6T026","deliverNo":"P7P013"},{"label":"BOM_P5","code":"BOM","project":"P5-MP量产","taskNo":"P6T023","deliverNo":"P7P010"},{"label":"SPP_P5","code":"SPP","project":"P5-MP量产","taskNo":"P6T022","deliverNo":"P7P009"},{"label":"RES_P5","code":"RES","project":"P5-MP量产","taskNo":"P6T024","deliverNo":"P7P011"},{"label":"FFS_P5","code":"FFS","project":"P5-MP量产","taskNo":"P6T025","deliverNo":"P7P012"}]',
        '推送甘特配置');


select * from pn_agent_log where (product_name is null or product_name = '') and agent_type = 'RES';
select * from pn_agent_log where  agent_type = 'BOM';
select * from pn_service_policy_process;
select * from pn_repair_sop_process where process_code = 'RES251030142525989';

select * from pn_bidata_deming_improvement_tineco;

select * from pn_bidata_deming_improvement_tineco where create_time <= '2025-11-06 12:21:03';
select * from pn_bidata_deming_improvement_tineco where create_time > '2025-11-06 12:21:03';

select *from pn_agent_log order by id desc;
select * from pn_product where company = 'ecovacs' and name in ('W3','MINI2','GOAT T系列 （AWD四驱）');

INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('W3', 'P00309', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);
INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('MINI2', 'P00310', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);
INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('GOAT T系列 （AWD四驱）', 'P00311', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);

select * from pn_agent_log where scene_type = 'ASCA_CREATE';

select * from pn_product_line where product_id in (select id from pn_product where company = 'tineco');

select * from pn_product where company = 'ecovacs';
INSERT INTO pyne_agent.pn_product (id, name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES (443, '贝多芬单机', 'P00383', 'ecovacs', 0, '2025-04-03 10:50:48', 'system', '2025-08-26 10:50:14', 'c0b55960c434392fb3fa81e6c009197e', 0, null, null, 0);

select * from pn_config where config_key = 'push_gantt_config';

select p.name
from pn_product p join pn_product_line l on p.id = l.product_id where p.is_enabled = 1 and l.is_deleted = 0 and sap_id = '110-2102-0001';
SELECT *
FROM pn_product
WHERE name = JSON_UNQUOTE(JSON_EXTRACT('[{"name":"X1 Family"}]', '$[0].name'));

select * from pn_corpus_data where company = 'ECOVACS' and corpus_no = 'PINE_F_REPAIR_SPARE_LIST' and is_valid = 'Y';

select * from pn_corpus_data_detail where data_id = 537 ;

select * from pn_product_line where sap_id = '109-20190401';


select b.file_content
from pn_corpus_data a
         join pn_corpus_data_detail b
              on a.id = b.data_id
where a.corpus_name = 'PINE-可维修性评估表'
  and a.is_valid = 'Y'
  and a.product_line_name = '轻量化';

select * from pn_corpus_data;

select * from pn_agent_log;


select * from pn_obm_mro_process where source_code = 'CJ202606083134825';
select * from pn_obm_mro_process where region = 'INTERNATIONAL' order by id desc;
select * from pn_obm_mro_process where id = '1993216402064166913';

select * from pn_agent_log where process_code = 'OBM260514195202082';

select * from pn_obm_mro_param_err where source_code = 'CJ202606083134825'