-- 添可维修
select time,count(time) from (
select LEFT(create_time,10) time from pn_obm_mro_process where create_time >= '2025-06-20 00:00:00' and create_time < '2025-07-02 00:00:00' and source_sys = 'CSS' and type = 'MRO')t group by time
select time,count(time) from (
select FROM_UNIXTIME(end_time/1000,'%Y-%m-%d') time from pn_obm_mro_process where create_time >= '2025-06-20 00:00:00' and create_time < '2025-07-02 00:00:00' and source_sys = 'CSS' and type = 'MRO')t group by time HAVING time is not null
select time,avg(ec_time) from (
select FROM_UNIXTIME(end_time/1000,'%Y-%m-%d') time,(end_time-start_time)/1000 ec_time from pn_obm_mro_process where create_time >= '2025-06-20 00:00:00' and create_time < '2025-07-02 00:00:00' and source_sys = 'CSS' and type = 'MRO')t group by time HAVING time is not null