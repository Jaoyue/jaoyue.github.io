SELECT
        d.install_sn_code AS sn_code,
        d3.region AS 大区,
        d2.servicer_name AS 网点名称,
        d2.clerk_name AS 服务师傅,
        d.product_name AS 产品名称,
        d2.repair_order_no AS 服务单号,
        d2.finished_time AS 完成时间,
        d2.remark_info AS 上门安装备注,
        '' AS 上门维修检测备注,
        '上门安装' AS 上门服务类型
    FROM
        tineco_agent.tineco_agent_cs_ms_door_installation_order_item_dd d
    JOIN tineco_agent.tineco_agent_cs_css_ms_door_installation_order_dd d2
        ON d.repair_order_no = d2.repair_order_no
    JOIN tineco_agent_cs_servicer_dd d3
        ON d2.servicer_code = d3.servicer_code
    WHERE
        d2.status = 'FINISHED'
        AND d.warranty_type = 'IN_WARRANTY'
        AND d.install_sn_code IS NOT NULL
        AND d.install_sn_code != ''
        AND d.install_sn_code != '空'
        AND LENGTH(d.install_sn_code) > 6;

select * FROM
        tineco_agent.tineco_agent_cs_ms_door_installation_order_item_dd d
    JOIN tineco_agent.tineco_agent_cs_css_ms_door_installation_order_dd d2
        ON d.repair_order_no = d2.repair_order_no