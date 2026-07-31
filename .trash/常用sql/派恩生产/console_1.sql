SELECT
    v_total.node_id,
    v_total.week,
    v_total.sap_id,
    v_total.拆分ai销量,
    v_total.预测ai销量,
    v_total.拆分人工销量,
    v_total.预测人工销量,
    '有差异' AS 差异状态
FROM (
    -- 左表：明细拆分数据（按 node_id + week + sap_id 聚合）
    SELECT
        node_id,
        week,
        sap_id,
        SUM(qty_ai) AS 拆分ai销量,
        SUM(qty_made) AS 拆分人工销量,
        0 AS 预测ai销量,
        0 AS 预测人工销量
    FROM plus_forecast_gate_detail
    GROUP BY node_id, week, sap_id

    UNION ALL

    -- 右表：JSON解析后的预测数据（按 node_id + week + sap_id 聚合）
    SELECT
        d.node_id,
        d.period_value AS week,
        t1.sapId AS sap_id,
        0 AS 拆分ai销量,
        0 AS 拆分人工销量,
        SUM(t2.ai) AS 预测ai销量,
        SUM(t2.made) AS 预测人工销量
    FROM (
        -- 取每个 node_id + 周 最新一条业务数据
        SELECT
            t.node_id,
            t.period_value,
            t.edited_output_json
        FROM (
            SELECT
                d.node_id,
                a.period_value,
                a.edited_output_json,
                ROW_NUMBER() OVER (
                    PARTITION BY d.node_id, a.period_value
                    ORDER BY a.id DESC
                ) AS rn
            FROM plus_chain_step_data a
            LEFT JOIN (
                SELECT DISTINCT b.id, c.node_id
                FROM plus_agent_log b
                JOIN plus_report_execution c ON b.chain_no = c.chain_no
            ) d ON a.agent_log_id = d.id
            WHERE a.step_index = 2
        ) t
        WHERE t.rn = 1
    ) d
    -- 解析双层JSON数组
    CROSS JOIN JSON_TABLE(
        d.edited_output_json->'$.data',
        '$[*]' COLUMNS (
            sapId VARCHAR(50) PATH '$.sapId',
            week52_arr JSON PATH '$.week52'
        )
    ) t1
    CROSS JOIN JSON_TABLE(
        t1.week52_arr,
        '$[*]' COLUMNS (
            ai DECIMAL(18,2) PATH '$.ai',
            made DECIMAL(18,2) PATH '$.made'
        )
    ) t2
    GROUP BY d.node_id, d.period_value, t1.sapId
) v_total
-- 合并同维度数据（node_id + week + sap_id）
GROUP BY v_total.node_id, v_total.week, v_total.sap_id
-- 求和得到最终对比值
HAVING
    SUM(v_total.拆分ai销量) <> SUM(v_total.预测ai销量)
    OR SUM(v_total.拆分人工销量) <> SUM(v_total.预测人工销量)
ORDER BY v_total.node_id, v_total.week, v_total.sap_id;