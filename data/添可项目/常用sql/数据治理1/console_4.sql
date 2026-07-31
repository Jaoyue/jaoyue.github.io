SELECT *
FROM tineco_agent_hr_pine_hr_cost_dd;
SELECT *
FROM tineco_agent_hr_pine_hr_cost_dd
WHERE YEAR(begin_time) = #{year}
  AND month(begin_time) = #{month}
  AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10;


select
    sum(本周)     as 本周,
    sum(上周)     as 上周,
    sum(上上周)   as 上上周,
    concat(
        round(
            case when sum(上周) = 0 then 0
                 else (sum(本周) - sum(上周)) / sum(上周) * 100
            end,
        2),
    '%') as 周环比
from (
    SELECT
        SUM(IFNULL(tot_labor_cost, 0)) AS 本周,
        0 AS 上周,
        0 AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND WEEK(begin_time, 1) = 18
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本周,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上周,
        0 AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND WEEK(begin_time, 1) = 17
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本周,
        0 AS 上周,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND WEEK(begin_time, 1) = 16
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
) t;

select
    sum(本周)     as 本周,
    sum(上周)     as 上周,
    sum(上上周)   as 上上周,
    concat(
        round(
            case when sum(上周) = 0 then 0
                 else (sum(本周) - sum(上周)) / sum(上周) * 100
            end,
        2),
    '%') as 周环比
from (
    SELECT
        SUM(IFNULL(tot_labor_cost, 0)) AS 本周,
        0 AS 上周,
        0 AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND WEEK(begin_time, 1) = #{week}
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本周,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上周,
        0 AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND WEEK(begin_time, 1) = #{week}-1
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本周,
        0 AS 上周,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上上周
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND WEEK(begin_time, 1) = #{week}-2
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) < 10
      AND identity_class = '管理人员'
) t;

select
    sum(本月)     as 本月,
    sum(上月)     as 上月,
    sum(上上月)   as 上上月,
    concat(
        round(
            case when sum(上月) = 0 then 0
                 else (sum(本月) - sum(上月)) / sum(上月) * 100
            end,
        2),
    '%') as 月环比
from (
    SELECT
        SUM(IFNULL(tot_labor_cost, 0)) AS 本月,
        0 AS 上月,
        0 AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND MONTH(begin_time) = 4
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本月,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上月,
        0 AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND MONTH(begin_time) = 3
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本月,
        0 AS 上月,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = 2026
      AND MONTH(begin_time) = 2
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
) t;

select
    sum(本月)     as 本月,
    sum(上月)     as 上月,
    sum(上上月)   as 上上月,
    concat(
        round(
            case when sum(上月) = 0 then 0
                 else (sum(本月) - sum(上月)) / sum(上月) * 100
            end,
        2),
    '%') as 月环比
from (
    SELECT
        SUM(IFNULL(tot_labor_cost, 0)) AS 本月,
        0 AS 上月,
        0 AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND MONTH(begin_time) = #{month}
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本月,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上月,
        0 AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND MONTH(begin_time) = #{month}-1
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
    union all
    SELECT
        0 AS 本月,
        0 AS 上月,
        SUM(IFNULL(tot_labor_cost, 0)) AS 上上月
    FROM tineco_agent_hr_pine_hr_cost_dd
    WHERE YEAR(begin_time) = #{year}
      AND MONTH(begin_time) = #{month}-2
      AND TIMESTAMPDIFF(DAY, begin_time, finish_time) > 10
        AND identity_class = '管理人员'
) t;