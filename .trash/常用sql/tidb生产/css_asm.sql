select * from complain_order where id = '2030638352817627137';
select * from complain_order_details where complain_order_no = 'CSTS260308000149';

ALTER TABLE complain_order_details
ADD COLUMN opinion_plan TEXT NULL COMMENT '舆情方案',
ADD COLUMN is_plan_rational CHAR(1) NULL COMMENT '输出方案合理性(Y/N)',
ADD COLUMN is_script_rational CHAR(1) NULL COMMENT '输出话术合理性(Y/N)',
ADD COLUMN is_first_time_resolved CHAR(1) NULL COMMENT '方案一次解决(Y/N)';

select count(*) from complain_order_item where repair_type is not null;

select * from complain_order_item group by  complain_order_no having count(*) >1;

select * from complain_order_item where complain_order_no = 'CSTS240621000164';
select * from cfg_complaint where complaint_name = '赠品/机器已发出';
select * from cfg_complaint where complaint_parent_id = '102';
select * from cfg_complaint group by complaint_code having count(*) >1;

select * from complain_order where processing_results like '%,%' limit 10;