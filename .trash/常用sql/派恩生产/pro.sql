select * from pn_agent_log where create_time >= '2025-05-22 09:00:00' and operator in ('doscs'); --
select * from pn_agent_log where create_time >= '2025-07-02 00:00:00' and scene_type = 'MRO_OBM' and operator in ('CSS'); --
select * from pn_agent_log where create_time >= '2025-05-22 09:00:00' and scene_type = 'MRO_MRO' and operator in ('CSS'); --
select * from pn_agent_log where create_time >= '2025-05-22 09:00:00' and `status` = 'WAITING' and operator in ('CSS','doscs'); --
select * from pn_agent_log where scene_type = 'MRO_OBM' and operator = 'CSS' and `status` = 'FINISHED';
select * from pn_agent_log where scene_type = 'MRO_OBM' and operator = 'CSS' and `status` = 'ERROR';
select p.source_code,p.process_code,p.sap_id,p.content,l.error_msg,p.solution from pn_agent_log l join pn_obm_mro_process p on l.process_code = p.process_code where l.scene_type = 'MRO_OBM_RETURN' and l.company = 'ecovacs' and l.`status` = 'ERROR' and l.error_msg is not null;
select * from pn_agent_log where scene_type = 'MRO_OBM_RETURN' and company = 'ecovacs' and `status` = 'ERROR';
# 签名校验失败, sign: 7d701f985aa99a4b5d2b4c991e406fd4
select * from pn_agent_log where id = '1966033829981917185';
select * from pn_agent_log where id = '1966040444550320130';
select * from pn_config;
select * from pn_product where id in (17,22);
select * from pn_product_line;
select * from pn_product_line where sap_id = '110-2498-0501';
SELECT l.* FROM pn_product_line l join pn_product p on l.product_id = p.id
        WHERE p.is_deleted = 0 and l.sap_id = '109-23280002' order by l.id desc limit 1;
select * from pn_repair_assessment_process where product_name like '%T80%';
select * from pn_fake_fault_sop_process;
select * from pn_product_line;
# pn_repair_assessment_process 可维修性评估
# pn_obm_mro_process 维修测试
# pn_part_bom_process 备件BOM
# pn_fake_fault_sop_process 假故障SOP
# pn_repair_sop_process 维修SOP
# pn_opinion_handle_process 舆情处理
select * from pn_agent_log where process_code in
                                 (select pn_obm_mro_process.process_code
                                  from pn_obm_mro_process
                                  where source_code =
                                        'WX20250720337816');

# select * from pn_agent_log where process_code in(
# select * from pn_obm_mro_process where source_sys = 'CSS' AND type = 'OBM' order by id desc limit 1111
# select * from pn_obm_mro_process where source_sys = 'CSS' AND type = 'OBM' order by id desc limit 1111
# select * from pn_obm_mro_process where source_sys = 'CSS' AND type = 'MRO' order by id desc limit 1111
# select * from pn_obm_mro_process where sap_id = '110-2488-0301')
select * from pn_obm_mro_process where source_code = 'WX20250628198844' and sap_id = '110-2488-0301';
select * from pn_obm_mro_process where source_code = 'WX20250720337816';
select * from pn_obm_mro_process where source_sys = 'doscs' and content like '%16434%';
select concat('{"sap_id":"',o.sap_id,'","content_type":"',o.content_type,'","content":',JSON_QUOTE(o.content),',"sn":"',o.sn,'"},') from pn_obm_mro_process o join pn_product p on o.product_id = p.id where o.create_time >= '2025-10-01 15:00:00' and o.type = 'OBM' and o.source_sys = 'CSS' and o.sn is not null limit 3000;
select concat('{"sap_id":"',o.sap_id,'","content_type":"',o.content_type,'","content":"',o.content,'","sn":"',o.sn,'"},') from pn_obm_mro_process o join pn_product p on o.product_id = p.id where o.create_time >= '2025-10-03 15:00:00' and o.type = 'OBM' and o.source_sys = 'doscs' and o.content_type is not null and o.sn is not null limit 3000;
select concat('{"sap_id":"',sap_id,'","content":"',content,'"},') from pn_obm_mro_process where create_time >= '2025-07-21 15:00:00' and type = 'MRO' and source_sys = 'CSS' limit 50;
select concat('{"sap_id":"',sap_id,'","content_type":"',content_type,'","content":"',content,'"},') from pn_obm_mro_process where create_time >= '2025-05-26 15:00:00' and type = 'OBM' and source_sys = 'doscs' and content_type is not null limit 100;
select concat('{"sap_id":"',sap_id,'","content":"',content,'"},') from pn_obm_mro_process where create_time >= '2025-07-21 15:00:00' and type = 'MRO' and source_sys = 'doscs' limit 100;
select * from pn_agent_log where process_code = 'OBM250524150101509';
select * from pn_agent_log where id = '1948295715263434753';
select * from pn_agent_log where agent_type = 'FFS';
select distinct agent_type from pn_agent_log ;
select * from pn_agent_log where process_code in(
select process_code from pn_obm_mro_process where source_code = 'CSRP250722002349');
select * from pn_obm_mro_process where process_code in (
select process_code from pn_obm_mro_process GROUP BY process_code HAVING count(*) >1 ) order by process_code;
select * from pn_config;

-- 查询待执行的维修排障
select l.*
from pn_obm_mro_process p
         join pn_agent_log l on p.process_code = l.process_code
where (p.if_return = 0 or p.if_return is null)
  and p.if_execute = 0
  and l.`status` = 'PENDING'
  and p.type = 'OBM'
  and p.organization = 'CSS';
select l.*
from pn_obm_mro_process p
         join pn_agent_log l on p.process_code = l.process_code
where (p.if_return = 0 or p.if_return is null)
  and p.if_execute = 0
  and l.`status` = 'PENDING'
  and p.type = 'MRO';

select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and p.if_execute = 0 and l.`status` = 'WAITING' and p.type = 'OBM' AND l.id <= '1950727556542889986';
select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and p.if_execute = 0 and l.`status` = 'WAITING' and p.type = 'MRO';

select llm,count(*) count,avg(执行时间) from (
select l.id,l.scene_type,l.create_time,l.process_code,l.product_name,l.`status`,l.operator,p.start_time,p.end_time,(p.end_time-p.start_time)/1000 执行时间,p.llm
from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null)
                                                                                  and p.organization = 'ecovacs' and l.scene_type = 'MRO_OBM' and p.type = 'OBM' and p.llm is not null
)t group by llm order by count;

select llm,count(*) count,avg(执行时间) from (
select l.id,l.scene_type,l.create_time,l.process_code,l.product_name,l.`status`,l.operator,p.start_time,p.end_time,(p.end_time-p.start_time)/1000 执行时间,p.llm
from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.create_time >= '2025-09-19 00:00:00'
                                                                                  and p.organization = 'tineco' and l.scene_type = 'MRO_OBM' and p.type = 'OBM' and p.llm is not null
)t group by llm order by count;

select avg(执行时间) from (
select l.id,l.scene_type,l.create_time,l.process_code,l.product_name,l.`status`,l.operator,p.start_time,p.end_time,(p.end_time-p.start_time)/1000 执行时间 from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.scene_type = 'MRO_OBM' and p.type = 'OBM' and p.create_time >= '2025-06-01 00:00:00' and p.create_time < '2025-06-02 00:00:00' order by l.update_time
)t order by 执行时间;

select avg(执行时间) from (
select l.id,l.scene_type,l.create_time,l.process_code,l.product_name,l.`status`,l.operator,p.start_time,p.end_time,(p.end_time-p.start_time)/1000 执行时间 from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where (p.if_return = 0 or p.if_return is null) and l.scene_type = 'MRO_MRO' and p.type = 'MRO' and p.create_time >= '2025-06-01 00:00:00' and p.create_time < '2025-06-02 00:00:00' order by l.update_time
)t order by 执行时间;


select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where p.source_code is not null and (p.if_return = 0 or p.if_return is null) and p.if_execute = 1 and l.`status` = 'FINISHED' and l.scene_type in ('MRO_OBM') AND l.update_time >=  '2025-05-27 00:00:00' and l.update_time <=  '2025-05-28 00:00:00';
select l.* from pn_obm_mro_process p join pn_agent_log l on p.process_code = l.process_code where p.source_code is not null and (p.if_return = 0 or p.if_return is null) and p.if_execute = 1 and l.`status` = 'FINISHED' and l.scene_type in ('MRO_MRO') AND l.update_time >=  '2025-05-27 00:00:00' and l.update_time <=  '2025-05-28 00:00:00';
SELECT id FROM pn_product WHERE company = 'tineco'
select count(*) from pn_agent_log;
select count(*) from pn_obm_mro_process;
select * from pn_obm_mro_process where source_code = 'WX20250616105148';
select * from pn_agent_log where process_code = 'MRO250617174725387';
select * from pn_obm_mro_process where source_sys = 'doscs' and type = 'OBM';
select * from pn_obm_mro_process where source_sys = 'doscs' and type = 'MRO';
select * from pn_obm_mro_process where create_time >= '2025-05-26 00:00:00' and create_time <=  '2025-05-27 00:00:00';
select * from pn_obm_mro_process where llm = 'doubao_thinking' and source_sys = 'CSS' and solution like '>%';
select * from pn_obm_mro_process where llm = 'doubao_thinking' and source_sys = 'CSS' and end_time > 1750993380000;
select * from pn_obm_mro_process where llm = 'deepseek_r1' and source_sys = 'doscs';
select * from pn_obm_mro_process where llm = 'o4_mini' and source_sys = 'doscs';

select * from pn_obm_mro_process where source_sys = 'doscs' and source_code is not null;
select * from pn_obm_mro_process where source_sys = 'CSS' and source_code is not null;
select * from pn_obm_mro_process where source_code = 'CSRP250617001884';


select * from pn_obm_mro_process where source_code = 'CSRP250525001328';
select * from pn_agent_log where scene_type in ('MRO_OBM','MRO_MRO') and create_time > '2025-05-01 00:00:00' and create_time < '2025-05-29 00:00:00';
select * from pn_agent_log where id = '1936583687624806402';
select * from pn_agent_log where error_msg like '签名校验失败%';
select * from pn_agent_log where create_time > '2025-07-18';

select * from pn_obm_mro_process where type = 'OBM';
select * from pn_obm_mro_process where type = 'OBM' and content_type <> '(通用)其他故障,文字说明' and content_type like '%,%';

SELECT * FROM flyway_schema_history WHERE version = '7' and installed_rank = '7';
update flyway_schema_history set success = 1 where version = '7' and installed_rank = '7';
select source_code 维修单号,create_time 时间,sap_id 维修商品编码,if(type='MRO','维修','排障') 类型,content 故障描述,solution 智能体结果 from pn_obm_mro_process where source_sys = 'CSS' and solution is not null AND create_time > '2025-05-22 07:17:27';
select source_code 维修单号,create_time 时间,sap_id 维修商品编码,if(type='MRO','维修','排障') 类型,content 故障描述,solution 智能体结果 from pn_obm_mro_process where source_sys = 'doscs' and solution is not null AND create_time > '2025-05-22 07:17:27';
select source_code 维修单号,create_time 时间,sap_id 维修商品编码,if(type='MRO','维修','排障') 类型,content 故障描述,solution 智能体结果 from pn_obm_mro_process where source_sys = 'CSS' and  create_time > '2025-05-22 07:17:27';
select source_code 维修单号,create_time 时间,sap_id 维修商品编码,if(type='MRO','维修','排障') 类型,content 故障描述,solution 智能体结果 from pn_obm_mro_process where source_sys = 'doscs' and  create_time > '2025-05-22 07:17:27';

select * from pn_config;
UPDATE `pyne_agent`.`pn_config` SET `create_by` = 'system', `create_time` = '2025-04-24 00:00:00', `update_by` = 'system', `update_time` = '2025-04-24 00:00:00', `is_deleted` = 0, `version` = 0, `config_key` = 'agent_function_assApikey', `config_value` = 'app-xuj8sQk2whqVCq0hXsBpJ4JO', `config_desc` = NULL WHERE `id` = 18;
UPDATE `pyne_agent`.`pn_config` SET `create_by` = 'system', `create_time` = '2025-06-04 00:00:00', `update_by` = 'system', `update_time` = '2025-06-04 00:00:00', `is_deleted` = 0, `version` = 0, `config_key` = 'agent_function_mroMroApikey', `config_value` = 'app-H8aKiaoeLMwQlQs18Jsmtftw', `config_desc` = NULL WHERE `id` = 20;

# zhaoyue.zy,mingxin.ji,desheng.li,xiao.hang,changchun.xu,zhongfan.chen,kathy.cui,clover.tian,vance.shi
update pn_config set config_value = 'zhaoyue.zy,mingxin.ji,desheng.li,xiao.hang,changchun.xu,zhongfan.chen,kathy.cui,clover.tian,Vance.shi' where id = 4;

select * from flyway_schema_history where version = '8' and installed_rank = '8';

select source_code,type,FROM_UNIXTIME(start_time/1000,'%Y-%m-%d %H:%i:%s') from pn_obm_mro_process where source_code = 'CSRP250608002932';
select source_code,type,FROM_UNIXTIME(start_time/1000,'%Y-%m-%d %H:%i:%s') from pn_obm_mro_process where source_code = 'CSRP250605001203';
select * from pn_obm_mro_process where source_code = 'CSRP250605001203';

# 109-20191301

select * from pn_repair_history_tineco where sap_id = '109-20191301' and actual_fault = '地刷部分故障-滚刷电机不转-滚刷电机故障';
select * from pn_config;

select * from pn_obm_mro_process where source_sys = 'doscs';


SELECT * FROM pn_repair_history_ecovacs where order_no = '8015140328690329749110'


select * from pn_bom_dev_tineco where product_sap_id = '109-23281011';
select * from pn_bom_part_tineco where product_sap_id in (
select part_code from pn_bom_part_tineco where customer_type = 'OBM-国内') and customer_type = 'OBM-国内';
select * from pn_bom_part_tineco where product_sap_id = part_code;
select * from pn_bom_part_tineco where part_code like '114%';
select * from pn_bom_part_tineco where product_sap_id like '114%';
select * from pn_bom_dev_ecovacs;
select * from pn_bom_part_ecovacs;
SELECT * FROM pn_bom_part_ecovacs where code like '4%';
select product_name,result_file_url,create_time from pn_repair_assessment_process
select * from pn_repair_history_ecovacs order by id desc limit 11;
select * from pn_repair_history_tineco limit 11;
select count(*) from pn_repair_history_ecovacs where order_no like 'WX%';
select * from pn_agent_log where id = '1965300482045194241';

select * from pn_agent_log limit 10
select * from pn_agent_log where status = 'ERROR' and create_time >= '2025-08-25';
select * from pn_config;
select * from pn_product where is_deleted = 0 and company = 'ecovacs'; -- 8
select * from pn_product where is_deleted = 1 and company = 'ecovacs'; -- 8
select * from pn_product where name in (
'X5系列'
    ) and id in (
        9
    );
select * from pn_product_line where product_id = 20
update pn_product set is_deleted = 0 where name in (
'X5系列'
    ) and id in (
        9
    );


select * from pn_agent_log where create_time >= '2025-06-01 00:00:00';
select * from pn_part_bom_process where company = 'tineco';
select * from pn_part_bom_process where product_name = '109-25520101';

create table pn_tineco_agent_cs_service_tag_dd
(
    id           bigint auto_increment comment 'id'
        primary key,
    create_time  datetime     null comment '创建时间',
    category     varchar(255) null comment '品类',
    service_type varchar(255) null comment '服务类型',
    model        varchar(255) null comment '型号',
    fault_tag    varchar(255) null comment '故障标签'
)
    comment '添可售后服务标签';
create table pn_ecovacs_agent_fault_tag_df
(
    id            bigint auto_increment comment 'id'
        primary key,
    create_time   datetime     null comment '创建时间',
    class_type    varchar(100) null comment '类别',
    svc_type      varchar(200) null comment '服务类型',
    crm_fault_tag varchar(200) null comment 'CRM故障标签'
)
    comment '科沃斯故障标签';

    alter table pyne_agent.pn_product
    add is_enabled int default 1 not null comment '是否启用';

select  * from pn_product where company = 'ecovacs' and create_time >= '2025-08-22 15:45:10' and pn_product.is_enabled = '1'
select  * from pn_product where company = 'ecovacs' and pn_product.is_enabled = '1' and is_deleted = 0
select  * from pn_product where company = 'tineco' and pn_product.is_enabled = '1' and is_deleted = 0

select * from pn_bom_dev_tineco limit 1111
select * from pn_bom_part_tineco limit 1000

select * from pn_obm_mro_process where organization = 'ecovacs' and content_type = '边刷不转/自转'

select * from pn_agent_log where  `status` = 'ERROR' and create_time < '2025-09-15 10:50:00'
select * from pn_agent_log where  `status` = 'ERROR' and create_time > '2025-09-15 10:50:00'
update pn_agent_log set is_deleted = 1 where `status` = 'ERROR' and create_time < '2025-09-15 10:50:00';

select * from pn_agent_log where id = '1967468968833544194'
select * from pn_obm_mro_process where process_code = 'OBM250915131202874'
select * from pn_repair_assessment_process where process_code = 'ASS250911091510457'
update pn_agent_log set create_time = '2025-09-15 13:01:51',update_time = '2025-09-15 13:08:12' where id = '1965938300849557506';
update pn_agent_log set create_time = '2025-09-15 13:03:10',update_time = '2025-09-15 13:09:38' where id = '1965947190844657666';
update pn_repair_assessment_process set create_time = '2025-09-15 13:01:51',update_time = '2025-09-15 13:01:51' where id = '1965940152701882370' and process_code = 'ASS250911083950174';
update pn_repair_assessment_process set create_time = '2025-09-15 13:03:10',update_time = '2025-09-15 13:03:10' where id = '1965948817362194434' and process_code = 'ASS250911091510457';
select * from pn_repair_history_tineco
select l.*
        from pn_obm_mro_process p
                 join pn_agent_log l on p.process_code = l.process_code
        where (p.if_return = 0 or p.if_return is null)
          and p.if_execute = 0
          and l.`status` = 'PENDING'
          and p.`organization` = 'tineco'
          and p.type = 'OBM'
          and l.id%10 = 9 and l.id = ''
        order by l.id limit 1

select l.id,l.create_time,l.agent_type,l.scene_type,l.process_code,l.product_id,
               l.product_name,l.status,l.file_url,l.file_version,l.company,l.operator,l.update_time,l.push_sap_id
        from pn_agent_log l where l.is_deleted = 0 and id < '1968907574647287810' order by id desc limit 20

select * from pn_product where id >= 222 and id <= 270
update pn_product set is_deleted = 1 where id >= 222 and id <= 270;

select avg(end_time-start_time)/1000 from pn_obm_mro_process where source_sys = 'CSS' and type = 'OBM' and create_time > '2025-10-15 09:00:00';
select avg(end_time-start_time)/1000 from pn_obm_mro_process where source_sys = 'doscs' and type = 'OBM' and create_time > '2025-10-15 09:00:00';

select * from pn_obm_mro_process where create_time > '2025-10-15 09:00:00' and source_sys = 'CSS' and type = 'OBM' and if_execute = 1 and sn is not null

select * from pn_agent_log where scene_type = 'MRO_OBM' and process_code in (select process_code from pn_obm_mro_process where create_time > '2025-10-15 09:00:00' and source_sys = 'doscs' and type = 'OBM' and solution like '%天%' and if_execute = 1 and sn is not null
)
;
select * from pn_agent_log where id = '1978660584493293569';
select * from pn_agent_log where process_code = 'OBM251016111244470';

select * from pn_obm_mro_process where sn = 'E03734628G5241P10278';

select * from pn_dataset_upload_record where type = 'DISASSEMBLY_GUIDE' and data_url like '%pdf%';
select * from pn_obm_mro_process where source_code = 'CSRP251020002000';

select * from pn_agent_log where process_code = 'OBM251020183355175';
select * from pn_product_line;

select  *  from  pyne_agent.pn_bom_part_tineco  where  product_sap_id ='114-23432207';

select * from pn_obm_mro_process where source_code = 'CSRP260530000748';
select * from pn_agent_log where process_code = 'OBM260601103107827';

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件' from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = 'Station Pod' and b.file_content->'$.kfgzbq' = '污水桶损坏或不良' and b.file_content->'$.kfgzbq' != ''