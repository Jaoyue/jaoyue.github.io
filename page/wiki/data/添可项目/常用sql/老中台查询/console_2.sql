SELECT
  CASE d.sale_area
    WHEN 'DONGBEI' THEN '沈阳分部'
    WHEN 'HUANAN' THEN '广州分部'
    WHEN 'HUDONGYI' THEN '济南分部'
    WHEN 'HUDONGER' THEN '西安分部'
    WHEN 'XIBEI' THEN '太原分部'
    WHEN 'XINAN' THEN '成都分部'
    WHEN 'SUZHOU' THEN '苏州分部'
    WHEN 'NHUABEI' THEN '北京分部'
    WHEN 'HUAZHONG' THEN '武汉分部'
    WHEN 'HANZHOU' THEN '杭州分部'
    WHEN 'SHANGHAI' THEN '上海分部'
    WHEN 'NANNING' THEN '南宁分部'
    WHEN 'CHANGSHA' THEN '长沙分部'
    WHEN 'KUNMING' THEN '昆明分部'
    WHEN 'XIAMEN' THEN '福州分部'
    WHEN 'ZHENGZHOU' THEN '郑州分部'
    WHEN 'HEFEI' THEN '合肥分部'
    WHEN 'NANJING' THEN '南京分部'
    WHEN 'CHONGQING' THEN '重庆分部'
    WHEN 'QINGDAO' THEN '青岛分部'
    WHEN 'HAERBIN' THEN '长春分部'
    WHEN 'SHIJIAZHUANG' THEN '津冀大区'
    WHEN 'SELF_EMPLOYED' THEN '城市展厅'
    WHEN 'SHENZHEN' THEN '深圳分部'
    WHEN 'SHENGDAI' THEN '省代'
    WHEN 'BUILDING' THEN '家居'
    WHEN 'JCPT' THEN '集采'
    WHEN 'ZHONGMIAN' THEN '中免'
    WHEN 'SUPERMARKET' THEN '商超'
    WHEN 'SINKCHANNEL' THEN '下沉'
    ELSE d.sale_area
  END AS 业务单元,
  IFNULL(m.month_target, 0) AS 月累目标,
  IFNULL(m.month_achieve, 0) AS 月累达成,
  CONCAT(
    ROUND(
      CASE
        WHEN IFNULL(m.month_target, 0) = 0 THEN 0
        ELSE IFNULL(m.month_achieve, 0) / m.month_target * 100
      END,
      1
    ),
    '%'
  ) AS 月累达成率,
  CONCAT(
    ROUND(
      CASE
        WHEN IFNULL(pm.prev_month_achieve, 0) = 0 THEN 0
        ELSE (IFNULL(m.month_achieve, 0) - pm.prev_month_achieve) / pm.prev_month_achieve * 100
      END,
      1
    ),
    '%'
  ) AS 月累同比,
  IFNULL(w.week_target, 0) AS 本周目标,
  IFNULL(w.week_achieve, 0) AS 本周达成,
  CONCAT(
    ROUND(
      CASE
        WHEN IFNULL(w.week_target, 0) = 0 THEN 0
        ELSE IFNULL(w.week_achieve, 0) / w.week_target * 100
      END,
      1
    ),
    '%'
  ) AS 本周达成率,
  CONCAT(
    ROUND(
      CASE
        WHEN IFNULL(ly.last_year_week_achieve, 0) = 0 THEN 0
        ELSE (IFNULL(w.week_achieve, 0) - ly.last_year_week_achieve) / ly.last_year_week_achieve * 100
      END,
      1
    ),
    '%'
  ) AS 周同比,
  CONCAT(
    ROUND(
      CASE
        WHEN IFNULL(pw.prev_week_achieve, 0) = 0 THEN 0
        ELSE (IFNULL(w.week_achieve, 0) - pw.prev_week_achieve) / pw.prev_week_achieve * 100
      END,
      1
    ),
    '%'
  ) AS 周环比
FROM (
  SELECT DISTINCT sale_area
  FROM tineco_agent_mkt_dist_distributor_dd
  WHERE sale_mode = 'OFFLINE'
    AND sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
) d
LEFT JOIN (
  SELECT
    dd.sale_area,
    SUM(st.sales_amount) AS month_target,
    SUM(CASE
          WHEN im.gl_date >= '2026-01-01' AND im.gl_date < '2026-02-01' THEN im.invoice_amount
          ELSE 0
        END) AS month_achieve
  FROM tineco_agent_mkt_dist_distributor_dd dd
  LEFT JOIN tineco_agent_mkt_dist_sales_target_day_detail_dd st
    ON dd.distributor_code = st.distributor_code
   AND FROM_UNIXTIME(st.target_date / 1000, '%Y-%m-%d') >= '2026-01-01'
   AND FROM_UNIXTIME(st.target_date / 1000, '%Y-%m-%d') < '2026-02-01'
  LEFT JOIN tineco_agent_mkt_invoicing_manage_di im
    ON dd.distributor_code = im.customer_code
   AND im.gl_date >= '2026-01-01'
   AND im.gl_date < '2026-02-01'
   AND im.invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
  WHERE dd.sale_mode = 'OFFLINE'
    AND dd.sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
  GROUP BY dd.sale_area
) m
  ON d.sale_area = m.sale_area
LEFT JOIN (
  SELECT
    dd.sale_area,
    SUM(im.invoice_amount) AS prev_month_achieve
  FROM tineco_agent_mkt_dist_distributor_dd dd
  LEFT JOIN tineco_agent_mkt_invoicing_manage_di im
    ON dd.distributor_code = im.customer_code
   AND im.gl_date >= '2025-01-01'
   AND im.gl_date < '2025-02-01'
   AND im.invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
  WHERE dd.sale_mode = 'OFFLINE'
    AND dd.sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
  GROUP BY dd.sale_area
) pm
  ON d.sale_area = pm.sale_area
LEFT JOIN (
  SELECT
    dd.sale_area,
    SUM(st.sales_amount) AS week_target,
    SUM(CASE
          WHEN im.gl_date >= '2026-01-09' AND im.gl_date < '2026-01-16' THEN im.invoice_amount
          ELSE 0
        END) AS week_achieve
  FROM tineco_agent_mkt_dist_distributor_dd dd
  LEFT JOIN tineco_agent_mkt_dist_sales_target_day_detail_dd st
    ON dd.distributor_code = st.distributor_code
   AND FROM_UNIXTIME(st.target_date / 1000, '%Y-%m-%d') >= '2026-01-09'
   AND FROM_UNIXTIME(st.target_date / 1000, '%Y-%m-%d') < '2026-01-16'
  LEFT JOIN tineco_agent_mkt_invoicing_manage_di im
    ON dd.distributor_code = im.customer_code
   AND im.gl_date >= '2026-01-09'
   AND im.gl_date < '2026-01-16'
   AND im.invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
  WHERE dd.sale_mode = 'OFFLINE'
    AND dd.sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
  GROUP BY dd.sale_area
) w
  ON d.sale_area = w.sale_area
LEFT JOIN (
  SELECT
    dd.sale_area,
    SUM(im.invoice_amount) AS last_year_week_achieve
  FROM tineco_agent_mkt_dist_distributor_dd dd
  LEFT JOIN tineco_agent_mkt_invoicing_manage_di im
    ON dd.distributor_code = im.customer_code
   AND im.gl_date >= '2025-01-09'
   AND im.gl_date < '2025-01-16'
   AND im.invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
  WHERE dd.sale_mode = 'OFFLINE'
    AND dd.sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
  GROUP BY dd.sale_area
) ly
  ON d.sale_area = ly.sale_area
LEFT JOIN (
  SELECT
    dd.sale_area,
    SUM(im.invoice_amount) AS prev_week_achieve
  FROM tineco_agent_mkt_dist_distributor_dd dd
  LEFT JOIN tineco_agent_mkt_invoicing_manage_di im
    ON dd.distributor_code = im.customer_code
   AND im.gl_date >= '2025-01-02'
   AND im.gl_date < '2025-01-09'
   AND im.invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
  WHERE dd.sale_mode = 'OFFLINE'
    AND dd.sale_area IN (
      'DONGBEI','HUANAN','HUDONGYI','HUDONGER','XIBEI','XINAN','SUZHOU','NHUABEI',
      'HUAZHONG','HANZHOU','SHANGHAI','NANNING','CHANGSHA','KUNMING','XIAMEN',
      'ZHENGZHOU','HEFEI','NANJING','CHONGQING','QINGDAO','HAERBIN','SHIJIAZHUANG',
      'SELF_EMPLOYED','SHENZHEN','SHENGDAI','BUILDING','JCPT','ZHONGMIAN',
      'SUPERMARKET','SINKCHANNEL'
    )
  GROUP BY dd.sale_area
) pw
  ON d.sale_area = pw.sale_area