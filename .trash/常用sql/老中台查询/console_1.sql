SELECT t.create_no AS 工号, t.create_user AS 姓名, t.area AS 分部, COUNT(*) AS 参训次数, ROUND(AVG(t.score), 1) AS 销售技巧分数, ROUND(AVG(t.score), 1) AS 产品讲解分数 FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd t WHERE t.company_code = 'tineco' AND t.product_category_code = 'OFFLINE' AND
YEAR(create_time) = '2026'
AND month(create_time) = '01' GROUP BY t.create_no, t.create_user, t.area HAVING COUNT(*) >= 2 ORDER BY AVG(t.score) ASC LIMIT 10

10.109.4.96,10.107.5.59,127.0.0.1,10.109.228.65,10.108.111.13,10.108.224.101,10.108.224.102,10.108.224.103,10.108.224.104,10.108.224.105,10.108.224.106,10.108.224.114,10.108.224.111,10.108.224.112,10.108.111.11,10.10.2.41,10.10.2.31,10.10.2.51,10.10.2.52,10.10.2.53,10.10.2.54,10.88.23.241,10.10.2.102,10.10.2.103,10.107.5.17,10.100.60.68,10.107.5.54,192.168.16.147,192.168.16.144,192.168.16.141,10.107.5.149,10.107.5.26,10.108.131.12,10.107.5.170,10.107.5.166,10.108.128.16,10.107.5.170,10.107.5.132

