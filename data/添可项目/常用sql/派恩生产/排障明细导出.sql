-- 添可排障
select time,count(time) from (
select LEFT(create_time,10) time from pn_obm_mro_process where create_time >= '2025-05-30 00:00:00' and create_time < '2025-06-16 00:00:00' and source_sys = 'CSS' and type = 'OBM')t group by time HAVING time is not null
select time,count(time) from (
select FROM_UNIXTIME(end_time/1000,'%Y-%m-%d') time from pn_obm_mro_process where create_time >= '2025-05-30 00:00:00' and create_time < '2025-06-16 00:00:00' and source_sys = 'CSS' and type = 'OBM')t group by time HAVING time is not null
select time,avg(ec_time) from (
select FROM_UNIXTIME(end_time/1000,'%Y-%m-%d') time,(end_time-start_time)/1000 ec_time from pn_obm_mro_process where create_time >= '2025-05-30 00:00:00' and create_time < '2025-06-16 00:00:00' and source_sys = 'CSS' and type = 'OBM')t group by time HAVING time is not null
-- 添可
select LEFT(create_time, 10)              时间,
       source_code                        售后单号,
       sap_id                             物料号,
       content                            故障类型,
       solution                           智能体结果,
       FROM_UNIXTIME(start_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 开始时间,
       FROM_UNIXTIME(end_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 结束时间,
       (end_time - start_time) / 1000     执行时间
from pn_obm_mro_process
where create_time >= '2026-05-01 00:00:00'
  and create_time < '2026-06-01 00:00:00'
  and source_sys = 'CSS'
  and type = 'MRO';
select LEFT(create_time, 10)              时间,
       source_code                        售后单号,
       sap_id                             物料号,
       content_type                       故障类型,
       content                            故障描述,
       solution                           智能体结果,
       FROM_UNIXTIME(start_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 开始时间,
       FROM_UNIXTIME(end_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 结束时间,
       (end_time - start_time) / 1000     执行时间
from pn_obm_mro_process
where create_time >= '2026-05-01 00:00:00'
  and create_time < '2026-06-01 00:00:00'
  and source_sys = 'CSS'
  and type = 'OBM';
 -- 科沃斯
select LEFT(create_time, 10)              时间,
       source_code                        售后单号,
       sap_id                             物料号,
       content_type                       故障类型,
       content                            故障描述,
       solution                           智能体结果,
       FROM_UNIXTIME(start_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 开始时间,
       FROM_UNIXTIME(end_time / 1000,
                     '%Y-%m-%d %H:%i:%s') 结束时间,
       (end_time - start_time) / 1000     执行时间
from pn_obm_mro_process
where create_time >= '2026-03-10 00:00:00'
  and create_time < '2026-03-11 00:00:00'
  and source_sys = 'doscs'
  and type = 'MRO'
  and sn is not null;

select * from pn_agent_log where process_code in(
select * from pn_obm_mro_process where create_time >= '2025-06-13 00:00:00' and create_time < '2025-06-16 00:00:00' and source_sys = 'CSS' and type = 'MRO') and error_msg is  null

SELECT VERSION();

select time,count(time) from (
select LEFT(create_time,10) time from pn_obm_mro_process where create_time >= '2025-05-22 00:00:00' and create_time < '2025-05-30 00:00:00' and source_sys = 'CSS' and type = 'MRO' and solution is not null)t group by time HAVING time is not null