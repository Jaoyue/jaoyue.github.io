select * from task_schedule_job;
select * from task_instruction where to_data_source_id is not null;
{
    "sourceB_sql":"select source_order_num from dmp_tms.ims_logistics_ec_delivery_order_header where  delete_flag=0 and audit_status !='DISCART'",
    "join_field_a":"order_id",
    "join_field_b":"source_order_num"
}

select * from database_config;
