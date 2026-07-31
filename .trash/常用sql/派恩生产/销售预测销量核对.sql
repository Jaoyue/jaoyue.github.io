SET @p_node_id = 155;
SET @p_week = '2026W24';

SELECT
    COALESCE(a.sap_id, b.sapId) AS sap_id,
    IFNULL(a.拆分合计销量ai, 0) AS 拆分合计销量ai,
    IFNULL(a.拆分合计销量人工, 0) AS 拆分合计销量人工,
    IFNULL(b.预测合计销量ai, 0) AS 预测合计销量ai,
    IFNULL(b.预测合计销量人工, 0) AS 预测合计销量人工,
    CASE
        WHEN IFNULL(a.拆分合计销量ai, 0) != IFNULL(b.预测合计销量ai, 0)
             OR IFNULL(a.拆分合计销量人工, 0) != IFNULL(b.预测合计销量人工, 0)
        THEN '有差异' ELSE '一致'
    END AS 差异状态
FROM
(
    SELECT
        sap_id,
        SUM(qty_ai) AS 拆分合计销量ai,
        SUM(qty_made) AS 拆分合计销量人工
    FROM plus_forecast_gate_detail
    WHERE node_id = @p_node_id
      AND week = @p_week
    GROUP BY sap_id
) a
LEFT JOIN
(
    SELECT
        t1.sapId,
        SUM(t2.ai) AS 预测合计销量ai,
        SUM(t2.made) AS 预测合计销量人工
    FROM (
        SELECT t.edited_output_json
        FROM (
            SELECT
                a.edited_output_json,
                ROW_NUMBER() OVER (ORDER BY a.id DESC) AS rn
            FROM plus_chain_step_data a
            LEFT JOIN (
                SELECT DISTINCT b.id, c.node_id
                FROM plus_agent_log b
                JOIN plus_report_execution c ON b.chain_no = c.chain_no
            ) d ON a.agent_log_id = d.id
            WHERE a.step_index = 2
              AND a.period_value = @p_week
              AND d.node_id = @p_node_id
        ) t
        WHERE t.rn = 1
    ) d,
    JSON_TABLE(
        d.edited_output_json->'$.data',
        '$[*]' COLUMNS (
            sapId VARCHAR(50) PATH '$.sapId',
            week52_arr JSON PATH '$.week52'
        )
    ) t1,
    JSON_TABLE(
        t1.week52_arr,
        '$[*]' COLUMNS (
            ai DECIMAL(18,2) PATH '$.ai',
            made DECIMAL(18,2) PATH '$.made'
        )
    ) t2
    GROUP BY t1.sapId
) b ON a.sap_id = b.sapId
HAVING 拆分合计销量ai != 预测合计销量ai OR 拆分合计销量人工 != 预测合计销量人工
ORDER BY sap_id;