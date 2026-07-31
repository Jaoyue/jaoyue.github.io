SELECT r1.stat_time `日期`, r1.amount `计算销售额`, r2.amount `统计表销售额`
FROM (SELECT stat_time, SUM(amount) amount
      FROM (SELECT CAST(SUM(i.count * i.average_price) AS DECIMAL(15, 3)) AS amount, 2025 stat_time
            FROM `platform-store`.sp_sales_order o
                     LEFT JOIN `platform-store`.sp_sales_order_item i ON i.sales_order_no = o.order_no
            WHERE o.order_time >= 1754841600000
              AND o.`status` IN ('FINISHED', 'WAITING_PICK_UP')
            UNION ALL
            SELECT -CAST(SUM(i.count * i.average_price) AS DECIMAL(15, 3)) AS amount, 2025 stat_time
            FROM `platform-store`.sp_refund_order o
                     LEFT JOIN `platform-store`.sp_refund_order_item i ON i.refund_order_no = o.order_no
                     LEFT JOIN `platform-store`.sp_sales_order so ON o.sales_order_no = so.order_no
            WHERE o.order_time >= 1754841600000
              AND o.`status` = 'FINISHED') t
      GROUP BY stat_time) r1
         JOIN (SELECT 2025 stat_time, SUM(sales_amount) amount
               FROM `platform-store`.sp_store_product_stat
               WHERE stat_time >= 1754841600000) r2 ON r1.stat_time = r2.stat_time
HAVING ABS(r1.amount - r2.amount) > 1