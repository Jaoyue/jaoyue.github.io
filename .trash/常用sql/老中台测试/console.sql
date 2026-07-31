-- =============================================
-- 分销商库存费用计算（MySQL 5.6 兼容版）
-- 数量 = 库存数量 + 进货在途 - 退货在途
-- 价格优先级: 有效促销价 > 年度价 > 失效促销价最新
-- 费用 = 数量 * 单台价格 * 费率 / 1.13
-- =============================================

SELECT
    di.distributor_code   AS distributor_code,
    di.distributor_name   AS distributor_name,
    '大区名称'            AS region,
    '客户类型'            AS customer_type,
    di.material_no        AS material_no,
    di.product_name       AS product_name,
    (di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity) AS number,

    -- 单台价格（3级优先级）
    COALESCE(
        pp.pick_up_price,         -- 优先级1: 有效促销价
        yp.pick_up_price,         -- 优先级2: 年度价
        pp_expired.pick_up_price  -- 优先级3: 失效促销价最新
    ) AS 单台价格,

    0.3           AS 费率,        -- 替换为实际费率值

    ROUND(
        (di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity)
        * COALESCE(
            pp.pick_up_price,
            yp.pick_up_price,
            pp_expired.pick_up_price
        )
        * 0.3 / 1.13,
        2
    ) AS 费用

FROM `platform-dist`.dist_inventory di

-- =============================================
-- 优先级1: 有效的促销价
-- =============================================
LEFT JOIN (
    SELECT customer_code, product_sap_id, pick_up_price
    FROM sync_ims_product_price_promotion_price_to_b
    WHERE delete_flag = 0
      AND effective_status = 'EFFECTIVE'
      AND start_date <= NOW()
      AND end_date >= NOW()
      AND (customer_code, product_sap_id, last_update_date) IN (
          SELECT customer_code, product_sap_id, MAX(last_update_date)
          FROM sync_ims_product_price_promotion_price_to_b
          WHERE delete_flag = 0
            AND effective_status = 'EFFECTIVE'
            AND start_date <= NOW()
            AND end_date >= NOW()
          GROUP BY customer_code, product_sap_id
      )
) pp ON di.distributor_code = pp.customer_code
    AND di.material_no = pp.product_sap_id

-- =============================================
-- 优先级2: 年度价（促销价无效时使用，不区分是否有效）
-- =============================================
LEFT JOIN (
    SELECT product_sap_id, pick_up_price
    FROM sync_ims_product_price_year_price_to_b
    WHERE delete_flag = 0
      AND effective_status = 'EFFECTIVE'
      AND (product_sap_id, last_update_date) IN (
          SELECT product_sap_id, MAX(last_update_date)
          FROM sync_ims_product_price_year_price_to_b
          WHERE delete_flag = 0 AND effective_status = 'EFFECTIVE'
          GROUP BY product_sap_id
      )
) yp ON di.material_no = yp.product_sap_id
    AND pp.pick_up_price IS NULL  -- 仅当无有效促销价时

-- =============================================
-- 优先级3: 失效促销价中最新的（最终兜底）
-- =============================================
LEFT JOIN (
    SELECT customer_code, product_sap_id, pick_up_price
    FROM sync_ims_product_price_promotion_price_to_b
    WHERE delete_flag = 0
      AND effective_status <> 'EFFECTIVE'
      AND end_date < NOW()
      AND (customer_code, product_sap_id, end_date) IN (
          SELECT customer_code, product_sap_id, MAX(end_date)
          FROM sync_ims_product_price_promotion_price_to_b
          WHERE delete_flag = 0
            AND effective_status <> 'EFFECTIVE'
            AND end_date < NOW()
          GROUP BY customer_code, product_sap_id
      )
) pp_expired ON di.distributor_code = pp_expired.customer_code
              AND di.material_no = pp_expired.product_sap_id
              AND pp.pick_up_price IS NULL      -- 无有效促销价
              AND yp.pick_up_price IS NULL      -- 无年度价

WHERE di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity > 0;

select * from sync_ims_product_price_year_price_to_b;
select * from `platform-dist`.dist_inventory di where di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity > 0;

select distributor_code,distributor_name from `platform-dist`.dist_distributor;
SELECT
    di.distributor_code   AS distributor_code,
    di.distributor_name   AS distributor_name,
    '大区名称'            AS region,
    '客户类型'            AS customer_type,
    di.material_no        AS material_no,
    di.product_name       AS product_name,
    (di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity) AS number,
    100 AS price,
    0.3           AS fee_rate,
    100 AS fee
FROM `platform-dist`.dist_inventory di;

SELECT
    di.distributor_code   AS distributor_code,
    di.distributor_name   AS distributor_name,
    '大区名称'            AS region,
    '客户类型'            AS customer_type,
    di.material_no        AS material_no,
    di.product_name       AS product_name,
    (di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity) AS number,
    COALESCE(
        pp.pick_up_price,
        yp.pick_up_price,
        pp_expired.pick_up_price
    ) AS price,
    0.3           AS fee_rate,
    ROUND(
        (di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity)
        * COALESCE(
            pp.pick_up_price,
            yp.pick_up_price,
            pp_expired.pick_up_price
        )
        * 0.3 / 1.13,
        2
    ) AS fee
FROM `platform-dist`.dist_inventory di
LEFT JOIN (
    SELECT customer_code, product_sap_id, pick_up_price
    FROM `platform-report`.sync_ims_product_price_promotion_price_to_b
    WHERE delete_flag = 0
      AND effective_status = 'EFFECTIVE'
      AND start_date <= NOW()
      AND end_date >= NOW()
      AND (customer_code, product_sap_id, last_update_date) IN (
          SELECT customer_code, product_sap_id, MAX(last_update_date)
          FROM `platform-report`.sync_ims_product_price_promotion_price_to_b
          WHERE delete_flag = 0
            AND effective_status = 'EFFECTIVE'
            AND start_date <= NOW()
            AND end_date >= NOW()
          GROUP BY customer_code, product_sap_id
      )
) pp ON di.distributor_code = pp.customer_code
    AND di.material_no = pp.product_sap_id
LEFT JOIN (
    SELECT product_sap_id, pick_up_price
    FROM `platform-report`.sync_ims_product_price_year_price_to_b
    WHERE delete_flag = 0
      AND effective_status = 'EFFECTIVE'
      AND (product_sap_id, last_update_date) IN (
          SELECT product_sap_id, MAX(last_update_date)
          FROM `platform-report`.sync_ims_product_price_year_price_to_b
          WHERE delete_flag = 0 AND effective_status = 'EFFECTIVE'
          GROUP BY product_sap_id
      )
) yp ON di.material_no = yp.product_sap_id
    AND pp.pick_up_price IS NULL
LEFT JOIN (
    SELECT customer_code, product_sap_id, pick_up_price
    FROM `platform-report`.sync_ims_product_price_promotion_price_to_b
    WHERE delete_flag = 0
      AND effective_status <> 'EFFECTIVE'
      AND end_date < NOW()
      AND (customer_code, product_sap_id, end_date) IN (
          SELECT customer_code, product_sap_id, MAX(end_date)
          FROM `platform-report`.sync_ims_product_price_promotion_price_to_b
          WHERE delete_flag = 0
            AND effective_status <> 'EFFECTIVE'
            AND end_date < NOW()
          GROUP BY customer_code, product_sap_id
      )
) pp_expired ON di.distributor_code = pp_expired.customer_code
              AND di.material_no = pp_expired.product_sap_id
              AND pp.pick_up_price IS NULL
              AND yp.pick_up_price IS NULL
WHERE di.inventory_quantity + di.received_way_quantity - di.returned_way_quantity > 0;

select * from `platform-store`.sp_store_info;