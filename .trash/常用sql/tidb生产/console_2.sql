WITH temp AS
(SELECT
  '占用异常',
  a.out_sales_order_no '渠道订单号',
  a.sales_order_no '电商订单号',
  b.product_no '物料号',
  b.product_name '物料名称',
  c.`account_lock_msg` '占用异常信息',
  c.`account_unlock_msg` '释放异常信息',
  c.account_lock_flag, c.account_unlock_flag
FROM
  `dmp_sales_order`.ims_ec_sales_order a
  JOIN `dmp_sales_order`.ims_ec_sales_order_item b
    ON a.id = b.ec_sales_order_id
  JOIN dmp_sales_order.ims_ec_sales_order_ext c
    ON a.sales_order_no = c.sales_order_no
WHERE c.account_lock_flag = 3
  AND a.delete_flag = 0
  AND a.order_status = 'WAIT_SHIPPING'
  AND a.order_type = 'PRODUCT'
  AND a.`last_update_date` < DATE_SUB(NOW(), INTERVAL 15 MINUTE)
UNION
ALL
SELECT
  '释放异常',
  a.out_sales_order_no '渠道订单号',
  a.sales_order_no '电商订单号',
  b.product_no '物料号',
  b.product_name '物料名称',
  c.`account_lock_msg` '占用异常信息',
  c.`account_unlock_msg` '释放异常信息',
  c.account_lock_flag, c.account_unlock_flag
FROM
  `dmp_sales_order`.ims_ec_sales_order a
  JOIN `dmp_sales_order`.ims_ec_sales_order_item b
    ON a.id = b.ec_sales_order_id
  JOIN dmp_sales_order.ims_ec_sales_order_ext c
    ON a.sales_order_no = c.sales_order_no
WHERE c.account_unlock_flag = 3
  AND a.delete_flag = 0
  AND a.order_status = 'WAIT_SHIPPING'
  AND a.order_type = 'PRODUCT'
  AND a.`last_update_date` < DATE_SUB(NOW(), INTERVAL 15 MINUTE)

  UNION
ALL
SELECT
  '作废订单 未释放',
  a.out_sales_order_no '渠道订单号',
  a.sales_order_no '电商订单号',
  b.product_no '物料号',
  b.product_name '物料名称',
  c.`account_lock_msg` '占用异常信息',
  c.`account_unlock_msg` '释放异常信息',
  c.account_lock_flag, c.account_unlock_flag
FROM
  `dmp_sales_order`.ims_ec_sales_order a
  JOIN `dmp_sales_order`.ims_ec_sales_order_item b
    ON a.id = b.ec_sales_order_id
  JOIN dmp_sales_order.ims_ec_sales_order_ext c
    ON a.sales_order_no = c.sales_order_no
WHERE c.account_lock_flag = 2 AND  c.account_unlock_flag != 2
  AND a.delete_flag = 0
  AND a.order_status = 'CANCEL'
  AND a.order_type = 'PRODUCT'
  AND a.`last_update_date` < DATE_SUB(NOW(), INTERVAL 15 MINUTE)
  )
SELECT
  *
FROM
  temp
HAVING
  (SELECT
    COUNT(1)
  FROM
    temp) > 5