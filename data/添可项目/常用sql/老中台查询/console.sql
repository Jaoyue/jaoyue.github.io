SELECT (SELECT COUNT(*)
        FROM tineco_agent.tineco_agent_mkt_sp_biz_staff_dd
        WHERE staff_status = 'ENABLED'
          AND user_type = 'CLERK'
          AND position =
              'OFFICIAL_SALES_CONSULTANT')                                                            AS 总人数,
       (SELECT COUNT(DISTINCT create_no)
        FROM (SELECT create_no
              FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
              WHERE company_code = 'tineco'
                AND product_category_code =
                    'OFFLINE'
                AND YEAR(create_time) = '2025'
           AND month(create_time) = '12'
              UNION ALL
              SELECT create_no
              FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
              WHERE company_code = 'tineco'
                AND product_category_code =
                    'OFFLINE'
                AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') AS combined) AS 总参训人数,
       (SELECT COUNT(*)
        FROM (SELECT id
              FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
              WHERE company_code = 'tineco'
                AND product_category_code =
                    'OFFLINE'
                AND quality_type = 'video_quality'
                AND YEAR(create_time) = '2025'
           AND month(create_time) = '12'
              UNION ALL
              SELECT id
              FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
              WHERE company_code = 'tineco'
                AND product_category_code =
                    'OFFLINE'
                AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') AS combined) AS 总参训人次,
       CONCAT(LEAST(ROUND(
                                    (SELECT COUNT(DISTINCT create_no)
                                     FROM (SELECT create_no
                                           FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
                                           WHERE company_code = 'tineco'
                                             AND product_category_code =
                                                 'OFFLINE'
                                             AND quality_type = 'video_quality'
                                             AND YEAR(create_time) = '2025'
           AND month(create_time) = '12'
                                           UNION ALL
                                           SELECT create_no
                                           FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
                                           WHERE company_code = 'tineco'
                                             AND product_category_code =
                                                 'OFFLINE'
                                             AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') AS combined) *
                                    100.0 /
                                    NULLIF(
                                            (SELECT COUNT(*)
                                             FROM tineco_agent.tineco_agent_mkt_sp_biz_staff_dd
                                             WHERE staff_status = 'ENABLED'
                                               AND user_type = 'CLERK'
                                               AND position =
                                                   'OFFICIAL_SALES_CONSULTANT'),
                                            0),
                                    1), 100),
              '%')                                                                                    AS 覆盖率,
       CONCAT(ROUND(((SELECT COUNT(*)
                      FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
                      WHERE company_code = 'tineco'
                        AND quality_type = 'video_quality'
                        AND product_category_code =
                            'OFFLINE'
                        AND CAST(score AS INT) >= 90
                        AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') +
                     (SELECT COUNT(*)
                      FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
                      WHERE company_code = 'tineco'
                        AND product_category_code =
                            'OFFLINE'
                        AND CAST(score AS INT) >= 85
                        AND YEAR(create_time) = '2025'
           AND month(create_time) = '12')) *
                    100.0 /
                    NULLIF((SELECT COUNT(*)
                            FROM (SELECT id
                                  FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
                                  WHERE company_code = 'tineco'
                                    AND quality_type = 'video_quality'
                                    AND product_category_code =
                                        'OFFLINE'
                                    AND YEAR(create_time) = '2025'
           AND month(create_time) = '12'
                                  UNION ALL
                                  SELECT id
                                  FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
                                  WHERE company_code = 'tineco'
                                    AND product_category_code =
                                        'OFFLINE'
                                    AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') AS combined),
                           0), 1),
              '%')                                                                                    AS 合格率,
       ROUND((SELECT COUNT(*)
              FROM (SELECT id
                    FROM tineco_agent.tineco_agent_mkt_carnegie_quality_record_dd
                    WHERE company_code = 'tineco'
                      AND quality_type = 'video_quality'
                      AND product_category_code =
                          'OFFLINE'
                      AND YEAR(create_time) = '2025'
           AND month(create_time) = '12'
                    UNION ALL
                    SELECT id
                    FROM tineco_agent.tineco_agent_mkt_agent_carnegie_train_record_dd
                    WHERE company_code = 'tineco'
                      AND product_category_code =
                          'OFFLINE'
                      AND YEAR(create_time) = '2025'
           AND month(create_time) = '12') AS combined) *
             0.88,
             1)                                                                                       AS `Token花费/元`,
       0                                                                                              AS `总差旅费/元`