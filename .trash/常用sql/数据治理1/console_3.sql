WITH sn_base_data AS (
    SELECT
        install_sn_code sn_code,
        d2.finished_time,
        DATEDIFF(
            d2.finished_time,
            LAG(d2.finished_time, 1) OVER (PARTITION BY install_sn_code ORDER BY d2.finished_time ASC)
        ) AS 与上一次出现间隔天数
    FROM
        tineco_agent_cs_ms_door_installation_order_item_dd d
        JOIN tineco_agent_cs_css_ms_door_installation_order_dd d2
        ON d.repair_order_no = d2.repair_order_no
    WHERE
        d2.status = 'FINISHED'
        AND install_sn_code IS NOT NULL
        AND install_sn_code != '' -- 过滤空SN/空字符串SN
        -- 核心修改1：先筛选出2026-01-01至2026-02-01范围内的记录
        AND d2.finished_time >= '2026-01-01'
        AND d2.finished_time < '2026-02-02' -- 用小于2月2日避免漏算2月1日全天数据
),
-- 步骤2：筛选出30天内有重复的SN记录（未去重）
dup_sn_detail AS (
    SELECT
        sn_code
    FROM
        sn_base_data
    WHERE
        与上一次出现间隔天数 <= 30
        AND 与上一次出现间隔天数 IS NOT NULL
)
-- 步骤3：最终返回去重后的重复SN列表 + 总数统计
SELECT
    sn_code AS 30天内重复的SN,
    COUNT(sn_code) AS 重复SN次数
FROM
    dup_sn_detail
GROUP BY
    sn_code;

select * from tineco_agent_cs_css_ms_service_order_dd where repair_order_no = 'CSDI260228000437';
select * from tineco_agent_cs_css_ms_door_installation_order_dd where repair_order_no = 'CSDI260228000437';
select distinct on_door_service_type from tineco_agent_cs_css_ms_service_order_dd order by id desc;
select distinct repair_order_type from tineco_agent_cs_css_ms_service_order_dd;
select * from tineco_agent_cs_css_ms_service_order_dd where repair_order_status = 'FINISHED' order by id desc;
select * from tineco_agent_cs_ms_service_order_fee_servicer_dd order by id desc;
select * from tineco_agent_cs_ms_door_installation_settle_fee_dd where repair_order_no = 'CSDI260303000494';
select * from tineco_agent_cs_css_ms_service_order_dd order by id desc ;
select * from tineco_agent_cs_css_ms_repair_order_di where repair_order_status = 'FINISH' order by id desc;


select sum(total_amount)/sum(count) 单台费用 from (select sum(d.total_amount) total_amount,count(distinct d.repair_order_no) count
                               from tineco_agent_cs_ms_service_order_fee_servicer_dd d
                                        join tineco_agent_cs_css_ms_service_order_dd d2
                                             on d.repair_order_no =
                                                d2.repair_order_no
                               where d2.repair_order_status =
                                     'FINISHED'
                                 and d2.region = 'Eastern_Region'
                                 and year(d2.finish_time) = #{year}
                                 and week(d2.finish_time, 1) = #{week}
                               union all
                               select sum(d.total_amount) total_amount,count(distinct d.repair_order_no) count
                               from tineco_agent_cs_ms_door_installation_settle_fee_dd d
                                        join tineco_agent_cs_css_ms_door_installation_order_dd d2
                                             on d.repair_order_no =
                                                d2.repair_order_no
                                        join tineco_agent_cs_servicer_dd d3
                                             on d2.servicer_code =
                                                d3.servicer_code
                               where d2.status = 'FINISHED'
                                 and d3.region = 'Eastern_Region'
                                 and year(d2.finished_time) = #{year}
                                 and week(d2.finished_time, 1) = #{week}) t;