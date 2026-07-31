

-- 最终报表输出的明细总条数（和你最终业务SQL行数对齐）
SELECT COUNT(1) AS total_item_count
FROM `platform-store`.sp_sales_order_item a
INNER JOIN `platform-store`.sp_sales_order b
  ON a.sales_order_no = b.order_no
WHERE
        order_time >= UNIX_TIMESTAMP(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01')) * 1000
        AND order_time < UNIX_TIMESTAMP(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) + INTERVAL 1 DAY) * 1000
  AND b.audit_status = 'SUCCESS'
  AND b.shop_type = 'F'
  AND b.order_type NOT IN ('O2O', 'O2O_DATAO');

SELECT
    a.id                      AS detail_id,
    b.order_no                AS order_no,
    FROM_UNIXTIME(b.order_time / 1000, '%Y-%m-%d') AS order_date,
    FROM_UNIXTIME(b.order_time / 1000, '%Y-%m')   AS order_month,
    '销售'                    AS order_type,
    c.name                    AS clerk_name,
    c.work_no                 AS work_no,
    d.store_no                AS store_no,
    d.name                    AS store_name,
    a.material_no             AS material_no,
    a.product_name            AS product_name,
    a.count                   AS count,
    COALESCE(p.push_money, 0) AS commission_price,
    a.count * COALESCE(p.push_money, 0) AS commission_amount,
    p.activity_type           AS commission_type,
    p.price_code              AS commission_source_no
FROM (
    SELECT
        order_no,
        order_time,
        order_owner,
        store_id,
        FROM_UNIXTIME(order_time / 1000, '%Y-%m-%d') AS order_dt
    FROM `platform-store`.sp_sales_order
    WHERE
        order_time >= UNIX_TIMESTAMP(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01')) * 1000
        AND order_time < UNIX_TIMESTAMP(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) + INTERVAL 1 DAY) * 1000
        AND audit_status = 'SUCCESS'
        AND shop_type = 'F'
        AND order_type NOT IN ('O2O', 'O2O_DATAO')
) b
INNER JOIN `platform-store`.sp_sales_order_item a
    ON a.sales_order_no = b.order_no
INNER JOIN `platform-store`.sp_biz_staff c
    ON c.id = b.order_owner
INNER JOIN `platform-store`.sp_store_info d
    ON d.id = b.store_id

LEFT JOIN (
    SELECT * FROM (
        SELECT
            base.*,
            @row_num := IF(
                @prev_sap = base.product_sap_id AND @prev_store = base.store_code,
                @row_num + 1,
                1
            ) AS rn,
            @prev_sap := base.product_sap_id,
            @prev_store := base.store_code
        FROM (
            SELECT
                product_sap_id,
                store_code,
                push_money,
                activity_type,
                price_code,
                start_date,
                end_date
            FROM sync_ims_product_price_store_promotion_price
            WHERE
                delete_flag = 0
                AND effective_status IN ('EFFECTIVE', 'EXPIRED')
            -- 修正后的排序逻辑
            ORDER BY
                product_sap_id,
                store_code,
                CASE
                    WHEN activity_type = 'BRANCH_ACTIVITY' THEN 1
                    ELSE 2
                END,
                promotion_price_id DESC
        ) base,
        (SELECT @prev_sap := '', @prev_store := '', @row_num := 0) vars
    ) t
    WHERE t.rn = 1
) p
    ON a.material_no = p.product_sap_id
    AND d.store_no = p.store_code
    AND b.order_dt BETWEEN p.start_date AND p.end_date order by a.id
# limit 5000;


select * from sync_ims_product_price_store_promotion_price;

SELECT
    t.detail_id,
    t.order_no,
    t.order_date,
    t.order_month,
    t.order_type,
    c.name                    AS clerk_name,
    c.work_no                 AS work_no,
    d.store_no                AS store_no,
    d.name                    AS store_name,
    t.material_no,
    t.product_name,
    t.count,
    t.commission_price,
    t.commission_amount,
    t.commission_type,
    t.commission_source_no
FROM (
    -- 内层：只关联 订单 + 订单明细 + 提成
    SELECT
        a.id                      AS detail_id,
        b.order_no                AS order_no,
        FROM_UNIXTIME(b.order_time / 1000, '%Y-%m-%d') AS order_date,
        FROM_UNIXTIME(b.order_time / 1000, '%Y-%m')   AS order_month,
        '销售'                    AS order_type,
        b.order_owner,
        b.store_id,
        b.order_dt,
        a.material_no             AS material_no,
        a.product_name            AS product_name,
        a.count                   AS count,
        COALESCE(p.push_money, 0) AS commission_price,
        a.count * COALESCE(p.push_money, 0) AS commission_amount,
        p.activity_type           AS commission_type,
        p.price_code              AS commission_source_no,
        p.store_code
    FROM (
        SELECT
            order_no,
            order_time,
            order_owner,
            store_id,
            FROM_UNIXTIME(order_time / 1000, '%Y-%m-%d') AS order_dt
        FROM `platform-store`.sp_sales_order
        WHERE
            order_time >= UNIX_TIMESTAMP(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01')) * 1000
            AND order_time < UNIX_TIMESTAMP(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) + INTERVAL 1 DAY) * 1000
            AND audit_status = 'SUCCESS'
            AND shop_type = 'F'
            AND order_type NOT IN ('O2O', 'O2O_DATAO')
    ) b
    INNER JOIN `platform-store`.sp_sales_order_item a
        ON a.sales_order_no = b.order_no
    LEFT JOIN (
        SELECT * FROM (
            SELECT
                base.*,
                @row_num := IF(
                    @prev_sap = base.product_sap_id AND @prev_store = base.store_code,
                    @row_num + 1,
                    1
                ) AS rn,
                @prev_sap := base.product_sap_id,
                @prev_store := base.store_code
            FROM (
                SELECT
                    product_sap_id,
                    store_code,
                    push_money,
                    activity_type,
                    price_code,
                    start_date,
                    end_date
                FROM sync_ims_product_price_store_promotion_price
                WHERE
                    delete_flag = 0
                    AND effective_status IN ('EFFECTIVE', 'EXPIRED')
                ORDER BY
                    product_sap_id,
                    store_code,
                    CASE
                        WHEN activity_type = 'BRANCH_ACTIVITY' THEN 1
                        ELSE 2
                    END,
                    promotion_price_id DESC
            ) base,
            (SELECT @prev_sap := '', @prev_store := '', @row_num := 0) vars
        ) t
        WHERE t.rn = 1
    ) p
        ON a.material_no = p.product_sap_id
        AND b.order_dt BETWEEN p.start_date AND p.end_date
) t
-- 外层最后再联查 门店、店员
INNER JOIN `platform-store`.sp_store_info d
    ON d.id = t.store_id
    AND d.store_no = t.store_code
INNER JOIN `platform-store`.sp_biz_staff c
    ON c.id = t.order_owner

ORDER BY t.detail_id;


SELECT
        a.id                      AS detail_id,
        b.order_no                AS order_no,
        FROM_UNIXTIME(b.order_time / 1000, '%Y-%m-%d') AS order_date,
        FROM_UNIXTIME(b.order_time / 1000, '%Y-%m')   AS order_month,
        '销售'                    AS order_type,
        b.order_owner,
        b.store_id,
        b.order_dt,
        a.material_no             AS material_no,
        a.product_name            AS product_name,
        a.count                   AS count,
        COALESCE(p.push_money, 0) AS commission_price,
        a.count * COALESCE(p.push_money, 0) AS commission_amount,
        p.activity_type           AS commission_type,
        p.price_code              AS commission_source_no,
        p.store_code
    FROM (
        SELECT
            order_no,
            order_time,
            order_owner,
            store_id,
            FROM_UNIXTIME(order_time / 1000, '%Y-%m-%d') AS order_dt,
            r1.store_no,
            r1.name store_name
        FROM `platform-store`.sp_sales_order r join `platform-store`.sp_store_info r1 on r.store_id = r1.id
        WHERE
            order_time >= UNIX_TIMESTAMP(DATE_FORMAT(DATE_SUB(CURDATE(), INTERVAL 1 MONTH), '%Y-%m-01')) * 1000
            AND order_time < UNIX_TIMESTAMP(LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 1 MONTH)) + INTERVAL 1 DAY) * 1000
            AND audit_status = 'SUCCESS'
            AND shop_type = 'F'
            AND order_type NOT IN ('O2O', 'O2O_DATAO')
    ) b
    INNER JOIN `platform-store`.sp_sales_order_item a
        ON a.sales_order_no = b.order_no
    LEFT JOIN (
        SELECT * FROM (
            SELECT
                base.*,
                @row_num := IF(
                    @prev_sap = base.product_sap_id AND @prev_store = base.store_code,
                    @row_num + 1,
                    1
                ) AS rn,
                @prev_sap := base.product_sap_id,
                @prev_store := base.store_code
            FROM (
                SELECT
                    product_sap_id,
                    store_code,
                    push_money,
                    activity_type,
                    price_code,
                    start_date,
                    end_date
                FROM sync_ims_product_price_store_promotion_price
                WHERE
                    delete_flag = 0
                    AND effective_status IN ('EFFECTIVE', 'EXPIRED')
#                     AND start_date
                ORDER BY
                    product_sap_id,
                    store_code,
                    CASE
                        WHEN activity_type = 'BRANCH_ACTIVITY' THEN 1
                        ELSE 2
                    END,
                    promotion_price_id DESC
            ) base,
            (SELECT @prev_sap := '', @prev_store := '', @row_num := 0) vars
        ) t
        WHERE t.rn = 1
    ) p
        ON b.store_no = p.store_code
            AND a.material_no = p.product_sap_id
        AND b.order_dt BETWEEN p.start_date AND p.end_date;