select * from t_business_analysis_process_subject_sql;

SELECT
  CONCAT(fee_class,"费比") AS 'YTM物流费比',
  CONCAT(ROUND(SUM(fee.budget_fee)/SUM(sale.sale_income_budget)*100, 2), '%') AS '预算',
  CONCAT(ROUND(SUM(fee.actual_fee)/SUM(sale.sale_income_actual)*100, 2), '%') AS '实际',
  CONCAT(ROUND(SUM(fee.last_actual_fee)/SUM(sale.last_year_sale_income_actual)*100, 2), '%') AS '同比'
FROM ecovacs_agent.ecovacs_agent_wl_logistics_fee_week_taylor_df fee
LEFT JOIN ecovacs_agent.ecovacs_agent_wl_week_sale_income_taylor_df sale
  ON fee.year = CAST(sale.year AS UNSIGNED) AND fee.week = CAST(sale.week AS UNSIGNED)
 where fee.year=#{year}  and fee.week<=#{week}
GROUP BY fee_class;

SELECT
  CONCAT(fee_class,"费比") AS 'YTM物流费比',
  CONCAT(ROUND(SUM(fee.budget_fee)/SUM(sale.sale_income_budget)*100, 2), '%') AS '预算',
  CONCAT(ROUND(SUM(fee.actual_fee)/SUM(sale.sale_income_actual)*100, 2), '%') AS '实际',
  CONCAT(ROUND(SUM(fee.last_actual_fee)/SUM(sale.last_year_sale_income_actual)*100, 2), '%') AS '同比'
FROM ecovacs_agent.ecovacs_agent_wl_logistics_fee_week_taylor_df fee
LEFT JOIN ecovacs_agent.ecovacs_agent_wl_week_sale_income_taylor_df sale
  ON fee.year = CAST(sale.year AS UNSIGNED) AND fee.week = CAST(sale.week AS UNSIGNED)
 where fee.year= '2025'  and fee.week<= '40'
GROUP BY fee_class;