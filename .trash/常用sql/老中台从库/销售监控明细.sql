SELECT r1.store_id `门店`, r1.amount `计算销售额`, r2.amount `统计表销售额`
FROM (SELECT store_id, SUM(amount) amount
      FROM (SELECT CAST(SUM(i.count * i.average_price) AS DECIMAL(15, 3)) AS amount, o.store_id
            FROM `platform-store`.sp_sales_order o
                     LEFT JOIN `platform-store`.sp_sales_order_item i ON i.sales_order_no = o.order_no
            WHERE o.order_time >= 1754841600000 and o.order_time < 1754928000000
              AND o.`status` IN ('FINISHED', 'WAITING_PICK_UP') group by o.store_id
            UNION ALL
            SELECT -CAST(SUM(i.count * i.average_price) AS DECIMAL(15, 3)) AS amount, o.store_id
            FROM `platform-store`.sp_refund_order o
                     LEFT JOIN `platform-store`.sp_refund_order_item i ON i.refund_order_no = o.order_no
                     LEFT JOIN `platform-store`.sp_sales_order so ON o.sales_order_no = so.order_no
            WHERE o.order_time >= 1754841600000 and o.order_time < 1754928000000
              AND o.`status` = 'FINISHED' group by o.store_id) t
      GROUP BY store_id) r1
         JOIN (SELECT store_id, SUM(sales_amount) amount
               FROM `platform-store`.sp_store_product_stat
               WHERE stat_time = 1754841600000 group by store_id) r2 ON r1.store_id = r2.store_id
HAVING ABS(r1.amount - r2.amount) > 1;

select * from sp_store_info where id = 1820