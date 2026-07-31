select * from plus_report_node where node_name like '%亚马逊%';
select * from plus_report_node where id = 216;
select * from plus_forecast_gate_detail where node_id = 291 and week  in ('2026W24');
select * from plus_forecast_gate_detail where node_id = 270 and week  in ('2026W24') and qty_ai is not null;
select distinct sap_id from plus_forecast_gate_detail where node_id = 270 and week  in ('2026W24');
select distinct sap_id from plus_forecast_gate_detail where node_id = 274 and week  in ('2026W24');
select * from plus_forecast_gate_detail where node_id = 145 and qty_made is not null;
delete from plus_forecast_gate_detail where node_id = 145 and qty_made is null;
select * from plus_forecast_gate_detail where node_id = 299 and sap_id = '109-23761601';
select * from plus_forecast_gate_detail where node_id = 299 and sap_id = '109-23761601' AND forecast_week = '2026W23';
select sap_id,SUM(qty_ai), SUM(qty_made)
from plus_forecast_gate_detail
where node_id = 299
GROUP BY sap_id;
#   and sap_id = '109-23761601'
#   AND forecast_week = '2026W25'; @PostMapping("/approve")
select distinct forecast_week from plus_forecast_gate_detail where node_id = 105;
select *,replace(customer_no,'.0','') from plus_forecast_gate_detail where customer_no like '%.%';
update plus_forecast_gate_detail set customer_no = replace(customer_no,'.0','') where customer_no like '%.%';
select * from plus_agent_log where id = '2062484073471508481';
select * from plus_chain_step_data where agent_log_id='2062089277721096193';
select * from plus_forecast_gate_detail where node_id in (select id from plus_report_node where parent_id = 295);
select * from plus_forecast_gate_detail where node_id = 298 and sap_id = '109-23761601';

select * from plus_forecast_gate_detail where customer_no = '1002599' and sap_id = '108-24150101';
select distinct forecast_week from plus_forecast_gate_detail where customer_no = '1002599' and sap_id = '108-24150101';

select * from plus_forecast_gate_detail group by node_id,forecast_date,sap_id having count(*) > 1;

select * from  plus_chain_step_data where edited_output_json like '%2027W01%';
select * from plus_chain_step_data where period_value = '2026W25';

select a.sap_id,a.拆分合计销量ai,a.拆分合计销量人工,b.预测合计销量ai,b.预测合计销量人工 from
(select sap_id,SUM(qty_ai) 拆分合计销量ai, SUM(qty_made) 拆分合计销量人工
from plus_forecast_gate_detail
where node_id = 165
GROUP BY sap_id) a left join
(SELECT
    t1.sapId,
    SUM(t2.ai) AS 预测合计销量ai,
    SUM(t2.made) AS 预测合计销量人工
FROM plus_chain_step_data,
-- 拆外层data数组
JSON_TABLE(
    edited_output_json->'$.data',
    '$[*]' COLUMNS (
        sapId VARCHAR(50) PATH '$.sapId',
        week52_arr JSON PATH '$.week52'
    )
) t1,
-- 拆内层week52周明细数组
JSON_TABLE(
    t1.week52_arr,
    '$[*]' COLUMNS (
        ai DECIMAL(18,2) PATH '$.ai',
        made DECIMAL(18,2) PATH '$.made'
    )
) t2
WHERE agent_log_id='2061815292575952897'
GROUP BY t1.sapId) b on a.sap_id = b.sapId
;
# having a.拆分合计销量ai != b.预测合计销量ai or a.拆分合计销量人工 != b.预测合计销量人工;

select * from plus_report_node where id in (110,112,114,122,431);
select * from plus_chain_step_data;

select distinct currency from plus_forecast_gate_detail;
select * from plus_report_node where id in (
select distinct node_id from plus_forecast_gate_detail where currency is null);
select * from plus_forecast_gate_detail where node_id in (114) and price_period_made is null;
select distinct customer_name,sap_id from plus_forecast_gate_detail where node_id in (114) and price_period_made is null;
select distinct channel_lvl2,sap_id from plus_forecast_gate_detail where node_id in (112) and price_period_made is null;
select * from plus_forecast_gate_detail where node_id in (110,112,114,122,431);
delete from plus_forecast_gate_detail where node_id in (110,112,114,122,431);
select * from plus_forecast_gate_detail where node_id = 217 group by sap_id  having count(*) > 364;
select * from plus_forecast_gate_detail where node_id = 223 group by sap_id  having count(*) > 364;
select * from plus_forecast_gate_detail where node_id = 266 and sap_id = '109-24820101' and qty_made > 0;
select sum(qty_ai),sum(qty_made) from plus_forecast_gate_detail where node_id = 217;
select * from plus_report_node where id = 280;
select * from plus_chain_step_data where agent_log_id = '2062403821384257537';
SELECT
    t1.sapId,
    SUM(t2.ai) AS 预测合计销量ai,
    SUM(t2.made) AS 预测合计销量人工
FROM plus_chain_step_data,
-- 拆外层data数组
JSON_TABLE(
    edited_output_json->'$.data',
    '$[*]' COLUMNS (
        sapId VARCHAR(50) PATH '$.sapId',
        week52_arr JSON PATH '$.week52'
    )
) t1,
-- 拆内层week52周明细数组
JSON_TABLE(
    t1.week52_arr,
    '$[*]' COLUMNS (
        ai DECIMAL(18,2) PATH '$.ai',
        made DECIMAL(18,2) PATH '$.made'
    )
) t2
WHERE agent_log_id='2062403821384257537'
GROUP BY t1.sapId;
select distinct node_id,sap_id,channel_lvl2,customer_name,customer_no from plus_forecast_gate_detail where currency is null;
select * from plus_forecast_gate_detail where currency is null and node_id = 112 ;
select count(1) from plus_forecast_gate_detail where currency is null and node_id = 112 ;
select count(1) from plus_forecast_gate_detail where node_id = 112 ;

select * from (SELECT d.node_id,
                      a.*,
                      ROW_NUMBER() OVER (PARTITION BY d.node_id ORDER BY a.id DESC) AS rn
               FROM plus_chain_step_data a
                        LEFT JOIN (SELECT DISTINCT b.id      id,
                                                   c.node_id node_id
                                   FROM plus_agent_log b
                                            JOIN plus_report_execution c
                                                 ON b.chain_no = c.chain_no) d
                                  ON a.agent_log_id = d.id
               WHERE a.step_index = 1 and d.node_id  in (select id from plus_report_node where country = 'INTERNATIONAL')
                 and d.node_id in
                     (select distinct node_id
                      from plus_forecast_gate_detail
                      where price_period_made is null and week = '2026W24' AND sales_channel= 'ONLINE' )) tt
where rn = 1;

select * from plus_report_node where node_name = '抖音';

select * from flyway_schema_history;

select * from plus_agent_log where id = '2064341466205655041';
select * from plus_report_execution where chain_no = 'riesTKGNMXXXZXLCC260609204407701';

   SELECT *
        FROM plus_report_execution
        WHERE chain_no = 'riesTKGNMXXXZXLCC260609204407701'
          AND is_deleted = 0
        ORDER BY create_time DESC
        LIMIT 1;

delete from plus_forecast_gate_detail where  week  = '2026W24' and node_id = 216;
insert into plus_forecast_gate_detail (node_id, week, forecast_week, sales_channel, forecast_date, channel_lvl2, customer_no, customer_name, sap_id, spu, product_name, delivery_model, currency, price_ai, price_made, qty_ai, qty_made, price_period_ai, price_period_made, admin_org, version, create_time, create_by, update_time, update_by, is_deleted, price_step_id, qty_step_id)
select 216 as node_id, week, forecast_week, sales_channel, forecast_date, channel_lvl2, customer_no, customer_name, sap_id, spu, product_name, delivery_model, currency, price_ai, price_made, qty_ai, qty_made, price_period_ai, price_period_made, admin_org, version, create_time, create_by, update_time, update_by, is_deleted, price_step_id, qty_step_id from plus_forecast_gate_detail where  week  = '2026W24' and node_id = 217;

