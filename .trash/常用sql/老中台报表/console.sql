-- 样机销售
SELECT a.id                      AS detail_id,
       b.order_no                AS order_no,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m-%d') AS order_date,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m')    AS order_month,
       '销售'                    AS order_type,
       c.name                    AS clerk_name,
       c.work_no                 AS work_no,
       d.store_no                AS store_no,
       d.name                    AS store_name,
       a.material_no             AS material_no,
       a.product_name            AS product_name,
       a.count                   AS count,
       10                        AS commission_price,
       a.count * 10              AS commission_amount,
       '样机'                    AS commission_type,
       ''                        AS commission_source_no
FROM `platform-store`.sp_sales_order_item a
         LEFT JOIN `platform-store`.sp_sales_order b
                   ON b.order_no = a.sales_order_no
         JOIN `platform-store`.sp_biz_staff c
              ON b.order_owner = c.id
         JOIN `platform-store`.sp_store_info d
              ON b.store_id = d.id
WHERE b.order_time >=
      UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL
                              1 DAY)) * 1000
  AND b.order_time <
      UNIX_TIMESTAMP(CURDATE()) * 1000
  and b.audit_status = 'SUCCESS'
  and b.shop_type = 'P';

-- o2o销售
SELECT a.id                      AS detail_id,
       b.order_no                AS order_no,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m-%d') AS order_date,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m')    AS order_month,
       '销售'                    AS order_type,
       c.name                    AS clerk_name,
       c.work_no                 AS work_no,
       d.store_no                AS store_no,
       d.name                    AS store_name,
       a.material_no             AS material_no,
       a.product_name            AS product_name,
       a.count                   AS count,
       CASE
           WHEN b.order_type = 'O2O'
               THEN COALESCE(
                   policy.o2o_mall_commission, 0)
           WHEN b.order_type = 'O2O_DATAO'
               THEN COALESCE(
                   policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_price,
       a.count *
       CASE
           WHEN b.order_type = 'O2O'
               THEN COALESCE(
                   policy.o2o_mall_commission, 0)
           WHEN b.order_type = 'O2O_DATAO'
               THEN COALESCE(
                   policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_amount,
       CASE
           WHEN b.order_type = 'O2O'
               THEN 'O2O商城提成'
           WHEN b.order_type = 'O2O_DATAO'
               THEN 'O2O大淘提成'
           ELSE ''
           END                   AS commission_type,
       policy.o2o_apply_code     AS commission_source_no
FROM `platform-store`.sp_sales_order_item a
         LEFT JOIN `platform-store`.sp_sales_order b
                   ON b.order_no = a.sales_order_no
         JOIN `platform-store`.sp_biz_staff c
              ON b.order_owner = c.id
         JOIN `platform-store`.sp_store_info d
              ON b.store_id = d.id
         LEFT JOIN sync_ims_policy_o2o_apply_detail policy
                   ON policy.product_sap_id =
                      a.material_no
                       AND
                      policy.enable_flag = 'Y'
                       AND policy.delete_flag = 0
                       AND policy.audit_status =
                           'ALLOW'
                       AND policy.begin_date <=
                           FROM_UNIXTIME(b.order_time / 1000)
                       AND policy.end_date >=
                           FROM_UNIXTIME(b.order_time / 1000)
WHERE b.order_time >=
      UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL
                              1 DAY)) * 1000
  AND b.order_time <
      UNIX_TIMESTAMP(CURDATE()) * 1000
  AND b.audit_status = 'SUCCESS'
  AND b.shop_type = 'F'
  AND b.order_type IN ('O2O', 'O2O_DATAO');

-- 零售销售
SELECT a.id                      AS detail_id,
       b.order_no                AS order_no,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m-%d') AS order_date,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m')    AS order_month,
       '销售'                    AS order_type,
       c.name                    AS clerk_name,
       c.work_no                 AS work_no,
       d.store_no                AS store_no,
       d.name                    AS store_name,
       a.material_no             AS material_no,
       a.product_name            AS product_name,
       a.count                   AS count,
       CASE
           WHEN b.order_type = 'O2O'
               THEN COALESCE(
                   policy.o2o_mall_commission, 0)
           WHEN b.order_type = 'O2O_DATAO'
               THEN COALESCE(
                   policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_price,
       a.count *
       CASE
           WHEN b.order_type = 'O2O'
               THEN COALESCE(
                   policy.o2o_mall_commission, 0)
           WHEN b.order_type = 'O2O_DATAO'
               THEN COALESCE(
                   policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_amount,
       CASE
           WHEN b.order_type = 'O2O'
               THEN 'O2O商城提成'
           WHEN b.order_type = 'O2O_DATAO'
               THEN 'O2O大淘提成'
           ELSE ''
           END                   AS commission_type,
       policy.o2o_apply_code     AS commission_source_no
FROM `platform-store`.sp_sales_order_item a
         LEFT JOIN `platform-store`.sp_sales_order b
                   ON b.order_no = a.sales_order_no
         JOIN `platform-store`.sp_biz_staff c
              ON b.order_owner = c.id
         JOIN `platform-store`.sp_store_info d
              ON b.store_id = d.id
         LEFT JOIN sync_ims_policy_o2o_apply_detail policy
                   ON policy.product_sap_id =
                      a.material_no
                       AND
                      policy.enable_flag = 'Y'
                       AND policy.delete_flag = 0
                       AND policy.audit_status =
                           'ALLOW'
                       AND policy.begin_date <=
                           FROM_UNIXTIME(b.order_time / 1000)
                       AND policy.end_date >=
                           FROM_UNIXTIME(b.order_time / 1000)
WHERE b.order_time >=
      UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL
                              1 DAY)) * 1000
  AND b.order_time <
      UNIX_TIMESTAMP(CURDATE()) * 1000
  AND b.audit_status = 'SUCCESS'
  AND b.shop_type = 'F'
  AND b.order_type NOT IN ('O2O', 'O2O_DATAO');

-- 样机退货
SELECT a.id                      AS detail_id,
       b.order_no                AS order_no,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m-%d') AS order_date,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m')    AS order_month,
       '退货'                    AS order_type,
       c.name                    AS clerk_name,
       c.work_no                 AS work_no,
       d.store_no                AS store_no,
       d.name                    AS store_name,
       a.material_no             AS material_no,
       a.product_name            AS product_name,
       a.count                   AS count,
       10                        AS commission_price,
       a.count * 10              AS commission_amount,
       '样机'                    AS commission_type,
       ''                        AS commission_source_no
FROM `platform-store`.sp_refund_order_item a
         LEFT JOIN `platform-store`.sp_refund_order b
                   ON b.order_no =
                      a.refund_order_no
         JOIN `platform-store`.sp_sales_order e
              on b.sales_order_no = e.order_no
         JOIN `platform-store`.sp_biz_staff c
              ON b.order_owner = c.id
         JOIN `platform-store`.sp_store_info d
              ON b.store_id = d.id
WHERE b.order_time >=
      UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL
                              1 DAY)) * 1000
  AND b.order_time <
      UNIX_TIMESTAMP(CURDATE()) * 1000
  and b.status = 'FINISHED'
  and e.shop_type = 'P';

-- o2o退货
SELECT a.id                      AS detail_id,
       b.order_no                AS order_no,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m-%d') AS order_date,
       FROM_UNIXTIME(b.order_time / 1000,
                     '%Y-%m')    AS order_month,
       '退货'                    AS order_type,
       c.name                    AS clerk_name,
       c.work_no                 AS work_no,
       d.store_no                AS store_no,
       d.name                    AS store_name,
       a.material_no             AS material_no,
       a.product_name            AS product_name,
       a.count                   AS count,
       -- 提成单价 对齐销售逻辑
       CASE
           WHEN e.order_type = 'O2O'
               THEN COALESCE(policy.o2o_mall_commission, 0)
           WHEN e.order_type = 'O2O_DATAO'
               THEN COALESCE(policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_price,
       -- 提成金额 对齐销售逻辑
       -a.count *
       CASE
           WHEN e.order_type = 'O2O'
               THEN COALESCE(policy.o2o_mall_commission, 0)
           WHEN e.order_type = 'O2O_DATAO'
               THEN COALESCE(policy.o2o_dtb_commission, 0)
           ELSE 0
           END                   AS commission_amount,
       CASE
           WHEN e.order_type = 'O2O'
               THEN 'O2O商城提成'
           WHEN e.order_type = 'O2O_DATAO'
               THEN 'O2O大淘提成'
           ELSE ''
           END                   AS commission_type,
       policy.o2o_apply_code     AS commission_source_no
FROM `platform-store`.sp_refund_order_item a
         LEFT JOIN `platform-store`.sp_refund_order b
                   ON b.order_no = a.refund_order_no
         JOIN `platform-store`.sp_sales_order e
              ON b.sales_order_no = e.order_no
         JOIN `platform-store`.sp_biz_staff c
              ON b.order_owner = c.id
         JOIN `platform-store`.sp_store_info d
              ON b.store_id = d.id
         LEFT JOIN sync_ims_policy_o2o_apply_detail policy
                   ON policy.product_sap_id = a.material_no
                      AND policy.enable_flag = 'Y'
                      AND policy.delete_flag = 0
                      AND policy.audit_status = 'ALLOW'
                      AND policy.begin_date <= FROM_UNIXTIME(b.order_time / 1000)
                      AND policy.end_date >= FROM_UNIXTIME(b.order_time / 1000)
WHERE b.order_time >= UNIX_TIMESTAMP(DATE_SUB(CURDATE(), INTERVAL 1 DAY)) * 1000
  AND b.order_time < UNIX_TIMESTAMP(CURDATE()) * 1000
  AND b.status = 'FINISHED'
  AND e.shop_type = 'F'
  AND e.order_type IN ('O2O', 'O2O_DATAO');
