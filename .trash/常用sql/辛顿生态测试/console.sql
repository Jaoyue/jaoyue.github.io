select * from  plus_agent_log a left join plus_agent_request_log b on a.id=b.log_id where a.result_type = 'EXCEL';
select * from  plus_agent_log a left join plus_agent_request_log b on a.id=b.log_id where a.id = '2062780700004966402';
select * from plus_agent_log where id = '2062780700004966402';
select * from plus_function where function_name like '%销售预测%';

select * from plus_forecast_gate_detail where node_id = 357 and is_deleted =1;
select count(*) from plus_forecast_gate_detail where node_id = 357 and is_deleted =1;
select count(*) from plus_forecast_gate_detail where node_id = 357 and is_deleted =0 ;
select * from plus_forecast_gate_detail where node_id = 357 and is_deleted =0 and price_made = '9999';

select * from plus_forecast_gate_detail where node_id = 357;
select * from plus_forecast_gate_detail where id = '162388';

select * from plus_forecast_gate_detail where node_id = 357 and is_deleted =0 and qty_made >0;

# ALTER TABLE plus_forecast_gate_detail
#     ADD COLUMN price_step_id bigint NULL COMMENT '价格STEP_ID',
# ADD COLUMN qty_step_id bigint NULL COMMENT '销量STEP_ID';
#
# ALTER TABLE plus_forecast_gate_detail
#
# ADD INDEX idx_price_step_id (price_step_id),
# ADD INDEX idx_qty_step_id (qty_step_id);
select * from plus_chain_step_data where id = 3590;
