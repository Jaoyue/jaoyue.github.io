select * from hinton_ecology.plus_forecast_gate_detail where currency is not null;
select * from plus_forecast_gate_detail  where node_id in (select id from plus_report_node where country = 'DOMESTIC')
update plus_forecast_gate_detail set currency = 'CNY' where node_id in (select id from plus_report_node where country = 'DOMESTIC')
select * from plus_report_node where id = 312;
select * from plus_report_node where node_name = '京东自营';
select * from  plus_agent_log a left join plus_agent_request_log b on a.id=b.log_id
        where a.id = '2060735031030972418';

select * from plus_chain_step_data where agent_log_id='2060735031030972418';
select * from plus_chain_step_data where execution_id='850';

select * from plus_function where function_code = 'riesJGSM5330' and company = 'TINECO'


select * from plus_forecast_gate_detail where forecast_date = '2027-05-22';

select * from plus_forecast_gate_detail where channel_lvl2 = '国内电商-抖音';

select * from plus_report_execution;

select * from plus_chain_step_data;

