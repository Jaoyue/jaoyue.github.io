ALTER TABLE complain_order_details
ADD COLUMN opinion_plan TEXT NULL COMMENT '舆情方案',
ADD COLUMN is_plan_rational CHAR(1) NULL COMMENT '输出方案合理性(Y/N)',
ADD COLUMN is_script_rational CHAR(1) NULL COMMENT '输出话术合理性(Y/N)',
ADD COLUMN is_first_time_resolved CHAR(1) NULL COMMENT '方案一次解决(Y/N)';
ALTER TABLE complain_order
ADD COLUMN post_interaction_demands varchar(50) NULL COMMENT '交互后用户诉求';



select * from complain_order where id = '2030895486021414913';
select * from complain_order_details where complain_order_no = 'CSTS260309000001';
select *,repair_type from complain_order_item where complain_order_no = 'CSTS260309000002';
select * from complain_order_item where repair_type is not null;
select * from complain_order_item where complain_order_no = 'CSTS250213000001'
select * from complain_order_item group by  complain_order_no having count(*) >1;

ALTER TABLE complain_order_details
ADD COLUMN opinion_plan TEXT NULL COMMENT '舆情方案',
ADD COLUMN is_plan_rational CHAR(1) NULL COMMENT '输出方案合理性(Y/N)',
ADD COLUMN is_script_rational CHAR(1) NULL COMMENT '输出话术合理性(Y/N)',
ADD COLUMN is_first_time_resolved CHAR(1) NULL COMMENT '方案一次解决(Y/N)',
ADD COLUMN unreasonable_reason VARCHAR(500) NULL COMMENT '不合理原因描述';
ALTER TABLE complain_order_details
ADD COLUMN unreasonable_reason VARCHAR(500) NULL COMMENT '不合理原因描述';

select * from asm_order where order_no in ('CSSH260316000008','CSSH260319000001')