# 销量
select
    v1.week,
    v1.node_id,
    v1.拆分合计销量ai,
    v1.拆分合计销量人工,
    v2.预测合计销量ai,
    v2.预测合计销量人工
from
(
    select
        week,
        node_id,
        SUM(qty_ai) 拆分合计销量ai,
        SUM(qty_made) 拆分合计销量人工
    from plus_forecast_gate_detail
    -- 这里可以保留筛选，也可以去掉看所有周
    -- where week = '2026W23'
    GROUP BY week, node_id
) v1
join
(
    SELECT
        d.period_value as week,
        d.node_id,
        SUM(t2.ai) AS 预测合计销量ai,
        SUM(t2.made) AS 预测合计销量人工
    FROM (
        SELECT t.node_id node_id, t.edited_output_json edited_output_json, t.period_value
        FROM (
            SELECT
                d.node_id,
                a.*,
                ROW_NUMBER() OVER (PARTITION BY d.node_id, a.period_value ORDER BY a.id DESC) AS rn
            FROM plus_chain_step_data a
            LEFT JOIN (
                SELECT DISTINCT b.id id, c.node_id node_id
                FROM plus_agent_log b
                JOIN plus_report_execution c ON b.chain_no = c.chain_no
            ) d ON a.agent_log_id = d.id
            WHERE a.step_index = 2
            -- and a.period_value = '2026W23'
        ) t
        WHERE t.rn = 1
    ) d,
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
    GROUP BY d.period_value, d.node_id
) v2
on v1.week = v2.week and v1.node_id = v2.node_id
having
    v1.拆分合计销量ai != v2.预测合计销量ai
    or v1.拆分合计销量人工 != v2.预测合计销量人工
order by v1.week, v1.node_id;

# 价格
SELECT
    v1.node_id,
    v1.week,
    v1.拆分合计价格ai,
    v1.拆分合计价格人工,
    v2.预测合计价格ai,
    v2.预测合计价格人工
FROM
(
    -- 左侧：拆分表 按node_id + week分组
    SELECT
        node_id,
        week,
        SUM(price_ai) 拆分合计价格ai,
        SUM(price_made) 拆分合计价格人工
    FROM plus_forecast_gate_detail
    GROUP BY node_id, week  -- 按节点+周分组
) v1
JOIN
(
    -- 右侧：预测表 按node_id + week分组
    SELECT
        d.node_id,
        d.period_value AS week,  -- 取出周字段
        SUM(t2.ai)*7 AS 预测合计价格ai,
        SUM(t2.made)*7 AS 预测合计价格人工
    FROM (
        SELECT
            d.node_id,
            a.edited_output_json,
            a.period_value,  -- 保留周用于分组
            ROW_NUMBER() OVER (PARTITION BY d.node_id, a.period_value ORDER BY a.id DESC) AS rn
        FROM plus_chain_step_data a
        LEFT JOIN (
            SELECT DISTINCT b.id, c.node_id
            FROM plus_agent_log b
            JOIN plus_report_execution c ON b.chain_no = c.chain_no
        ) d ON a.agent_log_id = d.id
        WHERE a.step_index = 1
    ) d
    -- 解析JSON
    JOIN JSON_TABLE(
        d.edited_output_json->'$.data',
        '$[*]' COLUMNS (
            sapId VARCHAR(50) PATH '$.sapId',
            week52_arr JSON PATH '$.week52'
        )
    ) t1 ON 1=1
    JOIN JSON_TABLE(
        t1.week52_arr,
        '$[*]' COLUMNS (
            ai DECIMAL(18,2) PATH '$.ai',
            made DECIMAL(18,2) PATH '$.made'
        )
    ) t2 ON 1=1
    WHERE d.rn = 1
    GROUP BY d.node_id, d.period_value  -- 按节点+周分组
) v2 ON v1.node_id = v2.node_id AND v1.week = v2.week  -- 双字段关联
-- 筛选不一致的数据
HAVING
    v1.拆分合计价格ai != v2.预测合计价格ai
    OR v1.拆分合计价格人工 != v2.预测合计价格人工
ORDER BY v1.node_id, v1.week;

# select v1.node_id,v1.拆分合计销量ai,v1.拆分合计销量人工,v2.预测合计销量ai,v2.预测合计销量人工 from
# (select node_id,SUM(qty_ai) 拆分合计销量ai, SUM(qty_made) 拆分合计销量人工
# from plus_forecast_gate_detail where week = '2026W23'
# GROUP BY node_id) v1
# join
# (SELECT
#     d.node_id,
#     SUM(t2.ai) AS 预测合计销量ai,
#     SUM(t2.made) AS 预测合计销量人工
# FROM (
#     SELECT t.node_id node_id, t.edited_output_json edited_output_json
# FROM (
#     SELECT
#         d.node_id,
#         a.*,
#         ROW_NUMBER() OVER (PARTITION BY d.node_id ORDER BY a.id DESC) AS rn
#     FROM plus_chain_step_data a
#     LEFT JOIN (
#         SELECT DISTINCT b.id id, c.node_id node_id
#         FROM plus_agent_log b
#         JOIN plus_report_execution c ON b.chain_no = c.chain_no
#     ) d ON a.agent_log_id = d.id
#     WHERE a.step_index = 2 AND a.period_value = '2026W23'
# ) t
# WHERE t.rn = 1
#      ) d,
# -- 拆外层data数组
# JSON_TABLE(
#     edited_output_json->'$.data',
#     '$[*]' COLUMNS (
#         sapId VARCHAR(50) PATH '$.sapId',
#         week52_arr JSON PATH '$.week52'
#     )
# ) t1,
# -- 拆内层week52周明细数组
# JSON_TABLE(
#     t1.week52_arr,
#     '$[*]' COLUMNS (
#         ai DECIMAL(18,2) PATH '$.ai',
#         made DECIMAL(18,2) PATH '$.made'
#     )
# ) t2
# GROUP BY d.node_id) v2
# on v1.node_id = v2.node_id
# having v1.拆分合计销量ai != v2.预测合计销量ai or v1.拆分合计销量人工 != v2.预测合计销量人工;
#
#
#
# select v1.node_id,v1.拆分合计价格ai,v1.拆分合计价格人工,v2.预测合计价格ai,v2.预测合计价格人工 from
# (select node_id,SUM(price_ai) 拆分合计价格ai, SUM(price_made) 拆分合计价格人工
# from plus_forecast_gate_detail where week = '2026W23'
# GROUP BY node_id) v1
# join
# (SELECT
#     d.node_id,
#     SUM(t2.ai)*7 AS 预测合计价格ai,
#     SUM(t2.made)*7 AS 预测合计价格人工
# FROM (
#     SELECT t.node_id node_id, t.edited_output_json edited_output_json
# FROM (
#     SELECT
#         d.node_id,
#         a.*,
#         ROW_NUMBER() OVER (PARTITION BY d.node_id ORDER BY a.id DESC) AS rn
#     FROM plus_chain_step_data a
#     LEFT JOIN (
#         SELECT DISTINCT b.id id, c.node_id node_id
#         FROM plus_agent_log b
#         JOIN plus_report_execution c ON b.chain_no = c.chain_no
#     ) d ON a.agent_log_id = d.id
#     WHERE a.step_index = 1 AND a.period_value = '2026W23'
# ) t
# WHERE t.rn = 1
#      ) d,
# -- 拆外层data数组
# JSON_TABLE(
#     edited_output_json->'$.data',
#     '$[*]' COLUMNS (
#         sapId VARCHAR(50) PATH '$.sapId',
#         week52_arr JSON PATH '$.week52'
#     )
# ) t1,
# -- 拆内层week52周明细数组
# JSON_TABLE(
#     t1.week52_arr,
#     '$[*]' COLUMNS (
#         ai DECIMAL(18,2) PATH '$.ai',
#         made DECIMAL(18,2) PATH '$.made'
#     )
# ) t2
# GROUP BY d.node_id) v2
# on v1.node_id = v2.node_id
# having v1.拆分合计价格ai != v2.预测合计价格ai or v1.拆分合计价格人工 != v2.预测合计价格人工;