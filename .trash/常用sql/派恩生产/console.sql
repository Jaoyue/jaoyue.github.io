select *
from pn_agent_log
where id = '1978701156654391298'
;
select *
from pn_obm_mro_process
where process_code = 'MRO251016135452221';
select count(*)
from pn_obm_mro_process
where create_time >= '2025-10-20 00:00:00'
  and create_time < '2025-10-21 00:00:00';

select *
from pn_bom_part_ecovacs
limit 100;
select *
from pn_bom_dev_ecovacs
limit 100;

select p.name
from pn_product p join pn_product_line l on p.id = l.product_id where p.is_enabled = 0 and l.is_deleted = 0 and sap_id = '110-2102-0001';
select * from pn_product where name like 'X1%';
SELECT EXTRACT(HOUR FROM
               create_time) AS hour_of_day,
       COUNT(*)             AS count_per_hour
FROM pn_obm_mro_process
WHERE create_time >= '2025-10-20 00:00:00'
  AND create_time < '2025-10-21 00:00:00'
GROUP BY EXTRACT(HOUR FROM create_time)
ORDER BY hour_of_day;
select *
from pn_obm_mro_process
where type = 'MRO'
  AND content like '%无故障%';

-- 珊瑚排障上线后
select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'OBM'
  and create_time >= '2025-10-17 00:00:00'
  AND create_time < '2025-10-27 00:00:00';


-- 珊瑚排障上线前
select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'OBM'
  and create_time < '2025-10-17 00:00:00';

select *
from pn_config;


-- 珊瑚排障投产前
select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'OBM'
  AND organization = 'ecovacs'
  and create_time >= '2025-10-28 00:00:00'
  AND create_time < '2025-10-28 14:20:00';

select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'MRO'
  AND organization = 'tineco'
  and create_time >= '2025-10-28 00:00:00'
  AND create_time < '2025-10-28 14:20:00';


-- 珊瑚排障投产后
select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'OBM'
  and organization = 'ecovacs'
  and create_time >= '2025-10-30 08:25:00';

select count(*)                          执行总量,
       avg(end_time - start_time) / 1000 `平均执行时间`
from pn_obm_mro_process
where type = 'MRO'
  AND organization = 'tineco'
  and create_time >= '2025-10-30 08:25:00';

select *
from pn_obm_mro_process
where process_code = 'OBM251101170138360';
select distinct company from pn_agent_log;
# 迁移测试时间14:20, 数据查询时间17:10
# 1.添可维修迁移前: 1162 10.0088秒
# 2.添可维修迁移后: 687 5.9257秒
# 3.添可排障迁移前: 1515 45.7092秒
# 4.添可排障迁移后: 624 10.7740秒
# 5.科沃斯排障迁移前: 1936 10.6873秒
# 6.科沃斯排障迁移后: 967 14.8392秒

select *
from pn_agent_log
where create_time > '2025-10-28 00:00:00'
  and scene_type = 'MRO_OBM'
  and app_id is not null
  and status = 'ERROR';
select *
from pn_agent_log
where create_time > '2025-10-28 00:00:00'
  and scene_type = 'MRO_OBM'
  and app_id is null
  and status = 'ERROR';
select *
from pn_agent_log
where create_time > '2025-10-28 00:00:00'
  and scene_type = 'MRO_MRO'
  and app_id is not null
  and status = 'ERROR';
select *
from pn_agent_log
where create_time > '2025-10-28 00:00:00'
  and scene_type = 'MRO_MRO'
  and app_id is null
  and status = 'ERROR';
select *
from pn_agent_log
where id = '1983083390209163265';
select *
from pn_agent_log
where status = '1983083390209163265';
select *
from pn_obm_mro_process
where process_code = 'MRO251029112154074';

select *
from pn_obm_mro_process
where type = 'OBM'
  and organization = 'tineco'
  and sap_id is null
  and source_sys = 'CSS';
select *
from pn_obm_mro_process
where type = 'OBM'
  and organization = 'ecovacs'
  and sap_id is null
  and source_sys = 'doscs';

select (end_time-start_time) tt,process_code
from pn_obm_mro_process
where type = 'OBM'
  and organization = 'tineco'
  and source_sys = 'CSS'
  and create_time > '2025-11-01 00:00:00' order by tt desc;
select * from pn_obm_mro_process where process_code = 'OBM251104090341282';
select * from pn_obm_mro_process where type = 'OBM' and create_time > '2025-11-04 00:00:00';
select count(*) from pn_obm_mro_process where type = 'OBM' and create_time > '2025-11-04 00:00:00' and if_execute = 0;
select * from pn_agent_log where process_code = 'OBM251104090341282';
select * from pn_agent_log where id = '1985513245332291586';


SELECT
    DATE_FORMAT(create_time, '%Y-%m-%d %H:00:00') as hour_time,COUNT(*) CT,
    AVG(end_time - start_time) as avg_execution_time
FROM pn_obm_mro_process
    WHERE type = 'MRO'
  AND create_time > '2025-12-18 00:00:00' and organization = 'tineco'
GROUP BY DATE_FORMAT(create_time, '%Y-%m-%d %H')
ORDER BY hour_time;

SELECT
    process_code,(end_time - start_time) as execution_time
FROM pn_obm_mro_process
    WHERE type = 'OBM'
  AND create_time > '2025-12-03 15:00:00';

select * from pn_obm_mro_process where type = 'MRO'
  AND create_time > '2025-12-18 15:00:00';
select * from pn_agent_log where process_code = 'OBM251203150506064';
select * from pn_product_line;

select * from pn_product where name = 'X11S family';

select * from pn_bidata_deming_improvement_tineco where fault_type like '%{%' order by occur_date;
select * from pn_bidata_deming_improvement_tineco where create_time <= '2025-11-06 12:21:03';
select * from pn_bidata_deming_improvement_tineco where create_time > '2025-11-06 12:21:03';
select * from pn_bidata_deming_improvement_tineco where id >= 155623;
delete from pn_bidata_deming_improvement_tineco where create_time > '2025-11-06 12:21:03';

select count(*) from pn_bidata_deming_improvement_tineco where create_time < '2025-11-21 02:15:02';

select * from pn_obm_mro_process where source_sys = 'doscs' and sap_id is not null;
select * from pn_obm_mro_process where source_code = 'CSRP251201000267';

select *from pn_corpus_data where product_line_name = 'Station Pod';
select *from pn_corpus_data_detail where data_id = 236;
select *from pn_agent_log where id = '2008721199398346753';
select * from pn_agent_log where id = '2008745963915534337';

select * from pn_part_bom_process;
select * from pn_config;

select b.file_content->'$.kfgzbq' AS '故障类型',b.file_content->'$.pj' AS '配件',b.file_content from pn_corpus_data a join pn_corpus_data_detail b on a.id = b.data_id where a.corpus_name = 'PINE-维修排障-SOP' and a.is_valid = 'Y' and a.product_line_name = '艺术家Artist系列' and b.file_content->'$.kfgzbq' IN ('地刷部分故障-滚刷电机不转-滚刷电机故障','(洗地机)地面水痕/水渍/水印大','刮条异常')

select * from pn_product where company = 'ecovacs' and name in ('W3','MINI2','GOAT T系列 （AWD四驱）');

INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('W3', 'P00363', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);
INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('MINI2', 'P00364', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);
INSERT INTO pyne_agent.pn_product (name, code, company, version, create_time, create_by, update_time, update_by, is_deleted, dm_code, product_class, is_enabled) VALUES ('GOAT T系列 （AWD四驱）', 'P00365', 'ecovacs', 0, '2026-01-13 13:00:00', 'system', '2026-01-13 13:00:00', 'system', 0, null, null, 0);

select b.file_content->'$.product_family' AS '产品家族',
           b.file_content->'$.type' AS '类型',
           b.file_content->'$.no' as '序号',
           b.file_content->'$.service_type' as '服务类型',
           b.file_content->'$.count' as ' 数量',
           b.file_content->'$.percentage' as '占比'
from pyne_agent.pn_corpus_data a join pyne_agent.pn_corpus_data_detail b on a.id = b.data_id
where a.corpus_name = 'PINE-咨询数据-科沃斯' and a.is_valid = 'Y'
    -- 只取科沃斯数据下的最新文档
    and b.create_time = (
        SELECT MAX(b2.create_time)
        FROM pyne_agent.pn_corpus_data a2
        join pyne_agent.pn_corpus_data_detail b2 on a2.id = b2.data_id
        where a2.corpus_name = 'PINE-咨询数据-科沃斯' and a2.is_valid = 'Y')

and b.file_content->'$.type' like '%产品问题%'
ORDER BY CAST(b.file_content->'$.count' AS UNSIGNED) DESC
limit 10;
select * from pn_agent_log where function_name is null order by id desc;
select *,agent_type from pn_agent_log where function_name is not null order by id desc;
select distinct function_code,function_name from pn_agent_log where function_name is not null order by id desc;

select * from pn_config where config_key = 'agent_gantt_taskDetailApikey';
UPDATE pyne_agent.pn_config SET create_by = 'system', create_time = '2025-12-26 00:00:00', update_by = 'system', update_time = '2025-12-26 00:00:00', is_deleted = 0, version = 0, config_key = 'push_gantt_config', config_value = '[{"label":"ASS_P1","code":"ASS","project":"P1-方案设计&评审","taskNo":"P1T055","deliverNo":"P1P070","taskName":"评估DFS","deliverable":"可维修性评估表","projectPhase":"P1"},{"label":"ASS_P2","code":"ASS","project":"P2-详细设计&验证","taskNo":"P2T113","deliverNo":"P2P080","taskName":"检查第二轮手板DFS","deliverable":"可维修性评估表","projectPhase":"P2"},{"label":"ASS_P3","code":"ASS","project":"P3.2-EB试制","taskNo":"P4T132","deliverNo":"P4P078","taskName":"评估EB样机可维修性","deliverable":"产品可维修性评估表","projectPhase":"P3.2"},{"label":"ASS_P4","code":"ASS","project":"P4-PP试产","taskNo":"P6T021","deliverNo":"P7P008","taskName":"评估PP样机可维修性","deliverable":"产品可维修性评估表","projectPhase":"P4"},{"label":"ASS_P5","code":"ASS","project":"P5-MP量产","taskNo":"P6T026","deliverNo":"P7P013","taskName":"受控发布可维修性评估表","deliverable":"可维修性评估表","projectPhase":"P5"},{"label":"BOM_P5","code":"BOM","project":"P5-MP量产","taskNo":"P6T023","deliverNo":"P7P010","taskName":"受控发布备件清单","deliverable":"备件清单","projectPhase":"P5"},{"label":"SPP_P5","code":"SPP","project":"P5-MP量产","taskNo":"P6T022","deliverNo":"P7P009","taskName":"受控发布售后服务政策","deliverable":"售后服务政策","projectPhase":"P5"},{"label":"RES_P5","code":"RES","project":"P5-MP量产","taskNo":"P6T024","deliverNo":"P7P011","taskName":"受控发布维修SOP","deliverable":"维修SOP","projectPhase":"P5"},{"label":"FFS_P5","code":"FFS","project":"P5-MP量产","taskNo":"P6T025","deliverNo":"P7P012","taskName":"受控发布假故障SOP","deliverable":"假故障SOP","projectPhase":"P5"}]', config_desc = '推送甘特配置' WHERE id = 39;

select * from pn_agent_log where process_code = 'OBM260324154201602';

select * from pn_product where  name = '芙万2.0';

select * from pn_product_line where product_id = 65;

select distinct status from pn_agent_log;

select p.name,l.sap_id from pn_product_line l join pn_product p on p.id = l.product_id where p.company = 'tineco';

select count(*) from pn_agent_log where scene_type = 'MRO_OBM' AND status NOT IN  ('ERROR','WAITING')
select count(*) from pn_agent_log where scene_type = 'MRO_MRO' AND status NOT IN  ('ERROR','WAITING')

select distinct scene_type from pn_agent_log;

select * from pn_product_line where sap_id = '109-21230001';

select distinct sap_id from pn_obm_mro_param_err where create_time > '2026-04-01' and company = 'tineco'
select distinct sap_id from pn_obm_mro_param_err where create_time > '2026-04-01' and company = 'ecovacs';

select * from pn_hinton_task;
update pn_hinton_task set call_id = '15ed9f7e23f44235b3b15d5f0690870d_del' where id = '10';

select * from pn_obm_mro_process where source_code = 'CJ202606083134825';
select * from pn_obm_mro_process where source_code like 'CJ%';

select * from pn_agent_log where process_code = 'OBM260514195202082';

select * from pn_obm_mro_param_err where source_code = 'CJ202606083134825';

select * from pn_obm_mro_process where region = 'INTERNATIONAL' order by id desc;
select * from pn_obm_mro_process where id = '2064599596556963841';
