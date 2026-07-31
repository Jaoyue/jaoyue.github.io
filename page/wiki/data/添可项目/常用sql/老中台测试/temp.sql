SELECT t.store_id,
       t.staff_id,
       t3.position,
       t.start_time,
       t.end_time,
       t.status,
       t4.score,
       t.id
FROM sp_patrol_store_record t
         inner join sp_store_info t2
                    on t.store_id = t2.id
         inner join sp_biz_staff t3
                    on t3.id = t.staff_id
         inner join sp_patrol_store_report t4
                    on t4.record_id = t.id
where 1 = 1
  and t.start_time >= 1778428800000
  and t.start_time <= 1778515200000
  and t2.sales_area in
      ('EAST', 'SOUTH', 'WEST', 'NORTH', 'CENTER');
select * from sp_task;
select * from sp_task where classpath like '%PatrolStoreRecordFinishTask%';
select * from `platform-store`.sp_task_log;
select * from `platform-dist`.dist_task_log;

select * from sp_store_prototype_sn where sn_code = 'TW6A77Y6H8359';

