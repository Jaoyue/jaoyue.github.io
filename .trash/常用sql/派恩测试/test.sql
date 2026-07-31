select * from pn_repair_assessment_process where process_code = 'ASS250416142418284';

select * from pn_agent_log where status = 'ERROR' and operator = '赵越' and product_name = '芙万2.0系列';
delete from pn_agent_log where status = 'ERROR' and operator = '赵越' and product_name = '芙万2.0系列';
select * from pn_agent_log where id = '1955537999731265537';
select * from pn_obm_mro_process where process_code = 'OBM250813155245916'
select * from pn_obm_mro_process where sn is not null and organization = 'ecovacs'
select p.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where l.id = '1955543895978950657';
SELECT @@GLOBAL.transaction_isolation, @@SESSION.transaction_isolation;
select * from pn_agent_log where agent_type = 'BOM' AND status = 'ERROR';
select * from pn_agent_log where operator = 'CSS';
select * from pn_agent_log where operator = 'doscs';
select * from pn_agent_log where id = '1965242709783961602';
select * from pn_obm_mro_process where process_code = 'OBM250813150305994';
select * from pn_repair_assessment_process where process_code = 'ASS250416155936370';
select * from pn_product where is_deleted = 0 and company = 'ecovacs'; -- 8
select * from pn_product where is_deleted = 0 and company = 'tineco'; -- 8
select * from pn_config where id = 29;
select * from pn_knowledge;
select * from pn_knowledge_line;
select * from pn_repair_sop_process where process_code = 'RES250905163025198';
select * from pn_repair_history_tineco where sap_id in (select sap_id from pn_product_line where product_id = 2)  order by id desc limit 10;
select * from pn_repair_history_tineco order by order_time desc limit 100
select * from pn_product_line where sap_id in (
'222-2242-0003',
'110-2479',
'110-2479-0003',
'110-2479-0104',
'110-2357-0001'
);
select * from pn_obm_mro_process limit 11;
select * from pn_product_line where product_id = 123
select * from pn_agent_log where id = '1968538347803250690';
select * from pn_agent_log where process_code = 'MRO250418155629723';
select * from pn_obm_mro_process where process_code = 'MRO250418171123488';
select * from pn_obm_mro_accessories where process_code = 'MRO250418161214801';
select * from pn_config;
select order_no 维修单号,fault_type 故障分类,check_desc 检测描述,actual_fault 实际故障,accessories 维修备件,agent_obm_plan Agent排障方案,agent_mro_plan Agent维修方案,agent_accessories Agent维修备件 from pn_repair_history_tineco where
accessories is not null and
 sap_id in (
select sap_id from pn_product_line where product_id = 1
) order by order_time desc limit 100000;
select * from pn_product;
select * from pn_obm_mro_process where process_code = 'MRO250507164530307';
select * from pn_part_bom_process where product_id = '1914590997306110000';
select * from pn_part_bom_process where product_name = '109-24260503';
update pn_agent_log set product_id = 22 where product_id = '1914590997306110000';
select * from pn_repair_history_ecovacs limit 100;
select e.* from pn_repair_history_ecovacs e
    join pn_product_line l on e.sap_id = l.sap_id join pn_product p on l.product_id = p.id where p.name = 'DEEBOT T10系列' limit 1000;
select * from pn_repair_history_tineco limit 11;

select e.id,e.accessories,t.accessories from pn_repair_history_ecovacs e join pn_repair_history_tineco t on e.id = t.id;

select * from pn_obm_mro_process;
select * from pn_config;
select * from pn_dataset_upload_record;
select * from pn_obm_mro_process where source_sys = 'CSS';
select * from pn_repair_history_tineco where sap_id like '%,%';
select * from pn_repair_history_tineco where order_no like 'CSRP240708000420%';

update pn_agent_log l ,pn_product p set l.product_name = p.name where l.product_id = p.id and l.product_id is not null;

select h.*
        from pn_repair_history_tineco h
                 join pn_product_line l on h.sap_id = l.sap_id
        where l.product_id = 2
          and h.fault_type is not null
          and h.fault_type != ''
          and h.check_desc is not null and h.check_desc != ''
            and h.actual_fault is not null and h.actual_fault != ''
            and h.accessories is not null and h.accessories != '';


select * from pn_obm_mro_process where source_code = '701745395740261302430';

select * from pn_product_line where sap_id = '110-2425-0101';
select * from pn_product where id = 209;
select * from pn_product_line;

delete from pn_repair_history_tineco;
select * from pn_config;
select * from pn_obm_mro_process where process_code in (
select l.* from  pn_agent_log l  where  l.`status` = 'WAITING' and l.scene_type = 'MRO_OBM'
);

select id,update_time-create_time from pn_agent_log where operator = 'CSS' AND update_time >= '2025-05-26 15:21:58' and  update_time <= '2025-05-26 16:18:38' order by update_time limit 200;
select * from pn_agent_log where operator = 'CSS' AND create_time >= '2025-05-27 13:00:00'  order by update_time limit 200;
select * from pn_agent_log where operator = 'CSS' AND create_time >= '2025-05-27 13:00:00'  order by update_time limit 200;
select * from pn_agent_log where operator = '派恩' AND `status` <> 'FINISHED' and error_msg is not null;
select * from pn_agent_log where id = 1927539010902175746;

-- 查询待执行的任务
select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and p.if_execute = 0 and l.`status` = 'WAITING' and p.type = 'OBM';
select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and p.if_execute = 0 and l.`status` = 'WAITING' and p.type = 'MRO';

select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.scene_type = 'MRO_MRO' and p.type = 'MRO' and p.create_time >= '2025-05-27 16:28:00' order by l.update_time;
select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.scene_type = 'MRO_OBM' and p.type = 'OBM' and p.create_time >= '2025-05-28 09:30:00' order by l.update_time;

select llm,count(*) count,avg(执行时间) from (
select l.id,l.scene_type,l.create_time,l.process_code,l.product_name,l.`status`,l.operator,p.start_time,p.end_time,(p.end_time-p.start_time)/1000 执行时间,p.llm from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.scene_type = 'MRO_OBM' and p.type = 'OBM' and p.llm is not null and p.create_time > '2025-06-16 15:00:00'
)t group by llm order by count;


select * from pn_obm_mro_process where type = 'MRO' and create_time >= '2025-05-27 00:00:00';
select * from pn_obm_mro_process where type = 'OBM' and create_time >= '2025-05-27 00:00:00';
select * from pn_repair_assessment_process where product_name like '%T80%';
select * from pn_agent_log where status = 'ERROR' and scene_type = 'MRO_OBM_RETURN';

select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where p.source_code is not null and (p.if_return = 0 or p.if_return is null) and p.if_execute = 1 and l.update_time >= '2025-05-23 14:25:00' and l.`status` <> 'WAITING' AND scene_type = 'MRO_OBM';
select * from pn_agent_log;
select * from pn_config where config_key = 'agent_function_bomServerUrl';

INSERT INTO `pyne_agent`.`pn_config` (`create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`, `version`, `config_key`, `config_value`, `config_desc`) VALUES ('system', '2025-06-04 00:00:00', 'system', '2025-06-04 00:00:00', 0, 0, 'agent_function_mroMroApikey', 'app-Rk0cznEf745lYpfOobXRBbJT', NULL);
select * from pn_obm_mro_process where type = 'OBM';
select * from pn_obm_mro_process where source_code = 'CSRP250603001769';
select * from pn_obm_mro_process where source_code = 'CSRP250605001203';
select * from pn_repair_assessment_process;
select * from pn_fake_fault_sop_process;
select * from pn_repair_history_tineco where sap_id = '109-20191301' and actual_fault = '地刷部分故障-滚刷电机不转-滚刷电机故障';

select * from pn_config;

INSERT INTO `pyne_agent`.`pn_config` (`create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`, `version`, `config_key`, `config_value`, `config_desc`) VALUES ('system', '2025-06-10 00:00:00', 'system', '2025-06-10 00:00:00', 0, 0, 'agent_function_ffsApikey', 'app-znnoKrLYivHMVp6nfmfulYzp', NULL);

select * from pn_bom_dev_tineco;
select * from pn_bom_dev_ecovacs where fp_material_no = '110-2435-0002';
select * from pn_bom_dev_ecovacs where father_lvl_material_no is null;
select * from pn_bom_part_ecovacs;
select * from pn_bom_dev_tineco where cpnt_code = '109-24280001' and product_sap_id = '109-24280001';
select * from pn_bom_dev_tineco where  product_sap_id = '109-24260503' and cpnt_code = '109-24260503'
and upper_cpnt_code is null;
select * from pn_bom_part_tineco;
select * from pn_bom_part_tineco where customer_type is null;
select * from pn_repair_assessment_process;
select * from pn_part_bom_process;
select * from pn_config;
select * from pn_obm_type_rel;


ALTER TABLE `pyne_agent`.`pn_obm_type_rel`
ADD INDEX `idx_fault_class`(`fault_class`) USING BTREE,
ADD INDEX `idx_obm_process_id`(`obm_process_id`) USING BTREE;

select r.fault_class,max(r.id),p.solution from pn_obm_type_rel r join pn_obm_mro_process p on r.obm_process_id = p.id where r.fault_class in ('DToF/LDS/导航模组异常','滚刷异常/报警滚刷被缠绕') group by r.fault_class;

select fault_class,max(obm_process_id) obm_process_id from pn_obm_type_rel where fault_class in ('DToF/LDS/导航模组异常','滚刷异常/报警滚刷被缠绕') group by fault_class;

select * from pn_agent_log where create_time >= '2025-06-01 00:00:00';
select * from pn_dataset_upload_record where type = 'FAULT_TYPE';

SELECT * FROM pn_bom_dev_tineco where product_sap_id = '109-23430001';

SELECT * FROM pn_bom_dev_tineco where level_number = 0 and product_sap_id = cpnt_code and product_sap_id = '109-23432402';
SELECT * FROM pn_bom_dev_ecovacs  where fp_material_no = '117-2215-0002' and father_lvl_material_no is not null
union all
select * from(
SELECT * FROM pn_bom_dev_ecovacs  where fp_material_no = '110-2417-0210' and father_lvl_material_no is null limit 1) t;
SELECT * FROM pn_bom_dev_ecovacs  where fp_material_no = '110-2479-0003' and father_lvl_material_no is null;


SELECT fp_material_no,count(*) c FROM pn_bom_dev_ecovacs GROUP BY fp_material_no order by c;
SELECT * FROM pn_bom_part_ecovacs;
SELECT * FROM pn_bom_dev_ecovacs limit 111;

select l.*
from pn_obm_mro_process p
         join pn_agent_log l on p.process_code = l.process_code
where (p.if_return = 0 or p.if_return is null)
  and p.if_execute = 0
  and l.`status` = 'PENDING'
  and p.type = 'OBM';

select * from pn_fake_fault_sop_process;
select * from pn_part_bom_process where company = 'ecovacs';


select * from (
SELECT
        distinct client, struc_grade, target_type_specifier, `no`, `code`,
        `name`, classify, qty, unit, nw, status, color, auth_model,
        mkt_name, ean_upc, country_chl,  father_lvl_material_no,
        fp_material_no, purchase_type, special_purchase_type
        FROM pn_bom_dev_ecovacs
        where father_lvl_material_no is not null and fp_material_no = '110-2479-0003'
) t group by concat(code,);

INSERT INTO `pyne_agent`.`pn_config` (`create_by`, `create_time`, `update_by`, `update_time`, `is_deleted`, `version`, `config_key`, `config_value`, `config_desc`) VALUES ('system', '2025-06-10 00:00:00', 'system', '2025-06-10 00:00:00', 0, 0, 'agent_function_ophApikey', 'app-zYoV77kHcjlpdF382jMg0xuw', NULL);
select * from pn_opinion_handle_process;
select * from pn_dataset_upload_record;

select * from pn_tineco_agent_cs_service_tag_dd;
select * from pn_ecovacs_agent_fault_tag_df;
SELECT * FROM pn_bom_dev_tineco where  product_sap_id = '109-18790206';
SELECT * FROM pn_bom_dev_tineco
        where level_number = 0  and product_sap_id = '114-23710101';
SELECT * FROM pn_bom_dev_tineco
        where level_number = 0 group by  product_sap_id having count(*) >1
SELECT * from pn_tineco_agent_cs_service_tag_dd;
SELECT * from pn_ecovacs_agent_fault_tag_df;
select * from pn_part_bom_process;

alter table pyne_agent.pn_product
    add is_enabled int default 1 not null comment '是否启用';

select * from pn_product where is_enabled = 0

select  * from pn_product where company = 'ecovacs' and pn_product.is_enabled = '1' and is_deleted = 0

create table pn_dataset
(
    id           bigint UNSIGNED auto_increment comment 'id'
        primary key,
    create_by    varchar(50) collate utf8mb3_bin null comment '创建人',
    create_time  datetime                        null comment '创建时间',
    update_by    varchar(50) collate utf8mb3_bin null comment '修改人',
    update_time  datetime                        null comment '修改时间',
    is_deleted   tinyint default 0               not null comment '禁用启用 0：启用  1禁用',
    version      int                             null comment '版本号',
    dataset_name   varchar(255)                  null comment '知识库名称',
    extend json                        null comment '扩展字段'
);
create table pn_dataset_document
(
    id           bigint UNSIGNED auto_increment comment 'id'
        primary key,
    create_by    varchar(50) collate utf8mb3_bin null comment '创建人',
    create_time  datetime                        null comment '创建时间',
    update_by    varchar(50) collate utf8mb3_bin null comment '修改人',
    update_time  datetime                        null comment '修改时间',
    is_deleted   tinyint default 0               not null comment '禁用启用 0：启用  1禁用',
    version      int                             null comment '版本号',
    dataset_id   bigint                  null comment '知识库id',
    document_name   varchar(255)                  null comment '文档名称',
    document_url   varchar(255)                  null comment '文档地址',
    extend json                        null comment '扩展字段'
);
create table pn_dataset_document_split
(
    id           bigint UNSIGNED auto_increment comment 'id'
        primary key,
    create_by    varchar(50) collate utf8mb3_bin null comment '创建人',
    create_time  datetime                        null comment '创建时间',
    update_by    varchar(50) collate utf8mb3_bin null comment '修改人',
    update_time  datetime                        null comment '修改时间',
    is_deleted   tinyint default 0               not null comment '禁用启用 0：启用  1禁用',
    version      int                             null comment '版本号',
    dataset_id   bigint                  null comment '知识库id',
    document_id   bigint                  null comment '文档名称',
    document_url   varchar(255)                  null comment '文档地址',
    extend json                        null comment '扩展字段'
);

SELECT   *  from    pn_bom_part_tineco  where  product_sap_id ='114-24360036'  and  part_code  ='2062-1861074'

select * from pn_bom_dev_tineco limit 1111
select distinct cpnt_unit_meas from pn_bom_dev_tineco
select distinct cpnt_unit_meas  from pn_bom_part_tineco

select p.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where l.id = ''

SELECT * FROM pn_bom_dev_tineco where product_sap_id = '109-25520001'

alter table pyne_agent.pn_obm_mro_process
    add prodn_time varchar(50) null comment '出厂时间';

alter table pyne_agent.pn_obm_mro_accessories
    modify sap_id varchar(500) null comment '物料号';
alter table pyne_agent.pn_obm_mro_accessories_up
    modify sap_id varchar(500) null comment '物料号';

select l.sap_id from pn_product_line l join pn_product p on l.product_id = p.id where p.is_deleted = 0 and p.name = 'T80系列' and p.company = 'tineco'

select * from knowledge_disassembly_sop_international
select * from knowledge_international_maintenance_sop
select * from knowledge_repair_guide
select * from pn_product where is_deleted = 0 and company = 'tineco'
select * from pn_product where is_deleted = 0 and company = 'ecovacs'
select * from pn_agent_log where error_msg is not null and scene_type = 'MRO_OBM_INTERNATIONAL'
select * from pn_agent_log where  scene_type = 'MRO_MRO_INTERNATIONAL'
update pn_agent_log set scene_type = 'MRO_MRO' where scene_type = 'MRO_MRO_INTERNATIONAL'
select * from pn_obm_mro_accessories
select * from pn_obm_mro_process order by id desc limit 100
select * from pn_config
select * from pn_obm_mro_accessories
select * from pn_obm_mro_accessories_up
select * from pn_product where name like '%DEEBOT X11%'
select * from pn_product_line where product_id = 116

select * from pn_fake_fault_sop_process
select * from pn_agent_log where region is null
update pn_agent_log set region = 'INTERNATIONAL' where process_code in (select process_code from pn_repair_sop_process where region = 'INTERNATIONAL')
;
select * from pn_agent_log order by id desc limit 10
https://cloud-minio-test.tineco.com/tineco-cloud/hinton-public/1970756913201561602.xlsx
select * from pn_corpus_data

SELECT * FROM pn_repair_history_tineco limit 10;
SELECT distinct order_no FROM pn_repair_history_tineco where  fault_type = '(通用)开机无反应' and sap_id in ('109-23430001','109-23430002','109-23430003','109-23430501','109-23430503','109-23430505','109-23430601','109-23430602','109-23430603','109-23430604','109-23430701','109-23430703','109-23430801','109-23430802','109-23430803','109-23430804','109-23430805','109-23430806')
SELECT * FROM pn_repair_history_tineco where accessories like '%SP;CL2343-01;电池包密封棉%' and fault_type = '(通用)开机无反应' and sap_id in ('109-23430001','109-23430002','109-23430003','109-23430501','109-23430503','109-23430505','109-23430601','109-23430602','109-23430603','109-23430604','109-23430701','109-23430703','109-23430801','109-23430802','109-23430803','109-23430804','109-23430805','109-23430806')

select * from pn_product_line where sap_id in ('109-20190001')
select * from pn_product where id = 1;

select a.* from pn_corpus_data a where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = 'W1S';
select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '艺术家Artist系列';
select * from pn_corpus_data_detail where data_id = 70

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '艺术家Artist系列' and b.file_content->'$.kfgzbq' IN ('(洗地机)整机出水小', '报警窗宝气压不足,请前往APP处理（3009）');

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-故障分类' and a.is_valid = 'Y' and a.company = 'TINECO' limit 1
;
select * from pn_obm_mro_process where region = 'INTERNATIONAL'
select * from pn_obm_mro_process where region != 'INTERNATIONAL' order by id desc limit 11
select * from pn_agent_log where id = '1972541910476664834'

select b.file_content->'$.kfgzbq' AS kfgzbq,b.file_content->'$.pj' AS pj from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '艺术家Artist系列' and b.file_content->'$.kfgzbq' IN ('(洗地机)整机出水小')
select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '艺术家Artist系列' and b.file_content->'$.kfgzbq' IN ('洗地机)整机出水小')

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-故障分类' and a.is_valid = 'Y' and a.company = 'ECOVACS' limit 1
;
select * from pn_product where id =184;
select * from pn_corpus_data_detail;

select TRIM(b.file_content->'$.kfgzbq') AS kfgzbq,b.file_content->'$.pj' AS pj from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '芙万2.0' and TRIM(b.file_content->'$.kfgzbq') IN ('(洗地机)回收桶无水报水满')

select b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-故障分类' and a.is_valid = 'Y' and a.company = 'TINECO';

select TRIM(b.file_content->'$.kfgzbq') AS kfgzbq,b.file_content->'$.pj' AS pj from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '芙万2.0' and TRIM(b.file_content->'$.kfgzbq') IN ('(洗地机)充电异常');

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件',b.file_content->'$.wxfa' AS '维修方案' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '芙万2.0' and b.file_content->'$.kfgzbq' IN ('(洗地机)充电异常');

select * from pn_corpus_data_detail where file_content like '% %';

update pn_corpus_data_detail set file_content = replace(file_content,' ','')
;
select * from pn_obm_mro_process where sn is not null limit 10000;

select ext1 from knowledge_base_fault_removing_keywords where is_deleted = 0 and keyword_type = 'FAULT_TYPE' and keyword_status = 1 and company='ecovacs'

1010  派恩项目组日报:

排障工作流迁移珊瑚   90%,待对接IOT接口