# 比较两个表是否有缺少的字段

```
SELECT 
    'ims_prototype_return_line_copy318' AS table_name,
    c2.COLUMN_NAME AS missing_column,
    c2.DATA_TYPE AS data_type,
    c2.CHARACTER_MAXIMUM_LENGTH AS max_length
FROM 
    information_schema.COLUMNS c2
LEFT JOIN 
    information_schema.COLUMNS c1
    ON c1.COLUMN_NAME = c2.COLUMN_NAME
    AND c1.TABLE_SCHEMA = c2.TABLE_SCHEMA
    AND c1.TABLE_NAME = 'ims_prototype_return_line_copy318'
WHERE 
    c2.TABLE_NAME = 'ims_prototype_return_line'
    AND c2.TABLE_SCHEMA = 'dmp_sales_order'
    AND c1.COLUMN_NAME IS NULL
UNION
SELECT 
    'ims_prototype_return_line' AS table_name,
    c1.COLUMN_NAME AS missing_column,
    c1.DATA_TYPE AS data_type,
    c1.CHARACTER_MAXIMUM_LENGTH AS max_length
FROM 
    information_schema.COLUMNS c1
LEFT JOIN 
    information_schema.COLUMNS c2
    ON c1.COLUMN_NAME = c2.COLUMN_NAME
    AND c1.TABLE_SCHEMA = c2.TABLE_SCHEMA
    AND c2.TABLE_NAME = 'ims_prototype_return_line'
WHERE 
    c1.TABLE_NAME = 'ims_prototype_return_line_copy318'
    AND c1.TABLE_SCHEMA = 'dmp_sales_order'
    AND c2.COLUMN_NAME IS NULL;
```

# 生成insert SQL

```
SELECT CONCAT(
    'INSERT INTO ims_prototype_return (',
    GROUP_CONCAT(c2.COLUMN_NAME ORDER BY c2.ORDINAL_POSITION SEPARATOR ', '),
    ') SELECT ',
    GROUP_CONCAT(c2.COLUMN_NAME ORDER BY c2.ORDINAL_POSITION SEPARATOR ', '),
    ' FROM ims_prototype_return_copy318;'
) AS generated_sql
FROM 
    information_schema.COLUMNS c2
WHERE 
    c2.TABLE_NAME = 'ims_prototype_return'
    AND c2.TABLE_SCHEMA = 'dmp_sales_order'; 
```

# 样机申请

```
INSERT INTO ims_prototype_order (prototype_order_id, prototype_order_code, prototype_order_type, org_id, source_id, source_type, return_flag, use_class, use_remark, apply_person_id, apply_person_number, apply_person_name, person_dept_code, apply_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name, apply_reason_code, apply_reason, business_type, move_type, fee_dept_code, cost_center_code, internal_order_no, product_type, reject_reason, activities_code, audit_status, customer_code, customer_name, budget_amount, total_quantity, total_amount, lock_stock_flag, delivery_flag, sub_stock_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, gl_date, order_delivery_type, ship_flag, center_type, ims_prototype_order_safekeep_configure_id, inside_order_code, audit_time, free_giveaway, prototype_scene, supplier_code, supplier_name) SELECT prototype_order_id, prototype_order_code, prototype_order_type, org_id, source_id, source_type, return_flag, use_class, use_remark, apply_person_id, apply_person_number, apply_person_name, person_dept_code, apply_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name, apply_reason_code, left(apply_reason,200) apply_reason, business_type, move_type, fee_dept_code, cost_center_code, internal_order_no, product_type, reject_reason, activities_code, audit_status, customer_code, customer_name, budget_amount, total_quantity, total_amount, lock_stock_flag, delivery_flag, sub_stock_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, gl_date, order_delivery_type, ship_flag, center_type, ims_prototype_order_safekeep_configure_id, inside_order_code, audit_time, free_giveaway, prototype_scene, supplier_code, supplier_name FROM ims_prototype_order_copy318
WHERE
	creation_date > '2025-02-01 00:00:00' 
	AND creation_date < '2025-03-01 00:00:00';
```

```
INSERT INTO ims_prototype_order_line (prototype_line_id, prototype_order_id, terminal_code, terminal_name, product_id, product_sap_id, product_sku, product_name, product_category, product_grade, use_sub, coop_platform, kol_id, kol_name, fee_asc_code, fee_asc_name, cost_center_id, cost_center_code, cost_center_name, quantity, price, amount, tax_rate, ship_company_code, ship_inventory_id, ship_inventory_code, ship_location_id, ship_location_code, ship_location_name, location_attr_code, sales_order_no, order_line_no, location_attr_name, shipment_no, courier_no, sn_code, expense_quantity, return_quantity, plan_delivery_date, actual_delivery_date, actual_delivery_qty, plan_return_date, big_channel_type, manage_type, sales_area, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, receiver, receiver_mobile, province_id, city_id, area_id, province, city, area, receiver_addr, deliver_line_type, return_factory_flag, remark, line_type, source_line_id, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, to_sap_flag, to_sap_msg, to_sap16_flag, to_sap16_msg, to_fee_flag, to_fee_error, keep_inv_flag, to_store_flag, prototype_order_line_code, delivery_flag, gl_date, ablad, return_flag, safekeep_company_code, virtual_warehouse_code, virtual_location_code, plan_order_code, insider_trading_back_flag, status, ori_proof, proof, ori_gl_date, regarded_sales_category, price_on_invoice, push_finance_share, fiance_share_bill_code, resist_quantity, old_sales_order_no, old_order_line_no, cn_location_id, cn_location_code, cn_location_name) SELECT prototype_line_id, prototype_order_id, terminal_code, terminal_name, product_id, product_sap_id, product_sku, product_name, product_category, product_grade, use_sub, coop_platform, kol_id, kol_name, fee_asc_code, fee_asc_name, cost_center_id, cost_center_code, cost_center_name, quantity, price, amount, tax_rate, ship_company_code, ship_inventory_id, ship_inventory_code, ship_location_id, ship_location_code, ship_location_name, location_attr_code, sales_order_no, order_line_no, location_attr_name, shipment_no, courier_no, sn_code, expense_quantity, return_quantity, plan_delivery_date, actual_delivery_date, actual_delivery_qty, plan_return_date, big_channel_type, manage_type, sales_area, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, receiver, receiver_mobile, province_id, city_id, area_id, province, city, area, receiver_addr, deliver_line_type, return_factory_flag, remark, line_type, source_line_id, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, to_sap_flag, to_sap_msg, to_sap16_flag, to_sap16_msg, to_fee_flag, to_fee_error, keep_inv_flag, to_store_flag, prototype_order_line_code, delivery_flag, gl_date, ablad, return_flag, safekeep_company_code, virtual_warehouse_code, virtual_location_code, plan_order_code, insider_trading_back_flag, status, ori_proof, proof, ori_gl_date, regarded_sales_category, price_on_invoice, push_finance_share, fiance_share_bill_code, resist_quantity, old_sales_order_no, old_order_line_no, cn_location_id, cn_location_code, cn_location_name FROM ims_prototype_order_line_copy318 where prototype_order_id in (select prototype_order_id from ims_prototype_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00');
```

```
INSERT INTO ims_prototype_order_detail (prototype_detail_id, prototype_line_id, line_properity_id, prototype_order_id, sn_code, expense_quantity, return_quantity, delay_return_date, delay_return_time, shipment_no, courier_no, plan_delivery_date, actual_delivery_date, return_factory_flag, receipt_no, receipt_date, to_sap_flag, to_sap_msg, to_sap16_flag, to_sap16_msg, to_fee_flag, to_fee_error, keep_inv_flag, to_store_flag, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, resist_quantity) SELECT prototype_detail_id, prototype_line_id, line_properity_id, prototype_order_id, sn_code, expense_quantity, return_quantity, delay_return_date, delay_return_time, shipment_no, courier_no, plan_delivery_date, actual_delivery_date, return_factory_flag, receipt_no, receipt_date, to_sap_flag, to_sap_msg, to_sap16_flag, to_sap16_msg, to_fee_flag, to_fee_error, keep_inv_flag, to_store_flag, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, resist_quantity FROM ims_prototype_order_detail_copy318 where prototype_order_id in (select prototype_order_id from ims_prototype_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00');
```

# 样机归还

```
INSERT INTO ims_prototype_return (prototype_return_id, prototype_return_code, prototype_order_id, prototype_order_code, prototype_return_type, use_class, return_form, org_id, audit_status, apply_type, apply_person_id, apply_person_name, apply_date, customer_code, customer_name, total_quantity, total_amount, return_quantity, expense_quantity, budget_amount, reject_reason, to_fee_flag, to_store_flag, in_inv_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, split_flag, return_logistics_order_no, to_sap_flag, audit_time, ori_proof, proof, fiance_share_bill_code, to_fee_error, resist_quantity, push_procurement_flag, procurement_flag, procurement_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name) SELECT prototype_return_id, prototype_return_code, prototype_order_id, prototype_order_code, prototype_return_type, use_class, return_form, org_id, audit_status, apply_type, apply_person_id, apply_person_name, apply_date, customer_code, customer_name, total_quantity, total_amount, return_quantity, expense_quantity, budget_amount, reject_reason, to_fee_flag, to_store_flag, in_inv_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, split_flag, return_logistics_order_no, to_sap_flag, audit_time, ori_proof, proof, fiance_share_bill_code, to_fee_error, resist_quantity, 0 push_procurement_flag, procurement_flag, procurement_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name FROM ims_prototype_return_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO ims_prototype_return_line (return_line_id, prototype_return_id, prototype_line_id, prototype_detail_id, delivery_order_no, receive_header_id, delivery_header_id, receive_order_no, terminal_code, terminal_name, product_id, product_sap_id, product_sku, product_name, product_grade, brand_en, use_sub, coop_platform, kol_id, kol_name, cost_center_id, cost_center_code, cost_center_name, quantity, prototype_return_reason, price, amount, province_id, city_id, area_id, province, city, area, ship_addr, ship_name, ship_mobile, logistics_company, courier_no, receiver_addr, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, shipment_no, delivery_date, sn_code, expense_flag, return_kind_flag, plan_return_date, delay_return_date, delay_return_time, return_location_id, return_location_code, return_location_name, receipt_no, actual_return_date, scrap_reason, after_sales_opinion, to_logistic_flag, to_store_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, gl_date, ablad, actual_delivery_qty, actual_delivery_date, receipt_qty, back_delivery_flag, back_delivery_time, push_procurement_flag, push_procurement_time, push_procurement_msg, to_sap_flag, to_sap_time, to_sap_msg, safekeep_company_code, return_logistics_order_no, ori_gl_date, resist_flag) SELECT return_line_id, prototype_return_id, prototype_line_id, prototype_detail_id,null delivery_order_no,null receive_header_id,null delivery_header_id, null receive_order_no, terminal_code, terminal_name, product_id, product_sap_id, product_sku, product_name, product_grade, brand_en, use_sub, coop_platform, kol_id, kol_name, cost_center_id, cost_center_code, cost_center_name, quantity, prototype_return_reason, price, amount, province_id, city_id, area_id, province, city, area, ship_addr, ship_name, ship_mobile, logistics_company, courier_no, receiver_addr, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, shipment_no, delivery_date, sn_code, expense_flag, return_kind_flag, plan_return_date, delay_return_date, delay_return_time, return_location_id, return_location_code, return_location_name, receipt_no, actual_return_date, scrap_reason, after_sales_opinion, to_logistic_flag, to_store_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, gl_date, ablad, actual_delivery_qty, actual_delivery_date, receipt_qty, back_delivery_flag, back_delivery_time, push_procurement_flag, push_procurement_time, push_procurement_msg, to_sap_flag, to_sap_time, to_sap_msg, safekeep_company_code, return_logistics_order_no, ori_gl_date, resist_flag FROM ims_prototype_return_line_copy318 where prototype_return_id in (select prototype_return_id from ims_prototype_return_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO ims_prototype_order_his (prototype_his_id, prototype_order_id, prototype_order_code, prototype_order_type, org_id, source_id, source_type, return_flag, use_class, use_remark, apply_person_id, apply_person_number, apply_person_name, person_dept_code, apply_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name, apply_reason_code, apply_reason, business_type, move_type, fee_dept_code, cost_center_code, internal_order_no, product_type, reject_reason, activities_code, audit_status, customer_code, customer_name, budget_amount, total_quantity, total_amount, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login) SELECT prototype_his_id, prototype_order_id, prototype_order_code, prototype_order_type, org_id, source_id, source_type, return_flag, use_class, use_remark, apply_person_id, apply_person_number, apply_person_name, person_dept_code, apply_date, org_level1_id, org_level2_id, org_level3_id, org_level4_id, org_level1_name, org_level2_name, org_level3_name, org_level4_name, apply_reason_code, left(apply_reason,200) apply_reason, business_type, move_type, fee_dept_code, cost_center_code, internal_order_no, product_type, reject_reason, activities_code, audit_status, customer_code, customer_name, budget_amount, total_quantity, total_amount, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login FROM ims_prototype_order_his_copy318 where prototype_order_id in (select prototype_order_id from ims_prototype_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO ims_prototype_order_safekeep_configure (ims_prototype_order_safekeep_configure_id, dept_id, dept_code, dept_name, fee_asc_code, fee_asc_name, cost_center_id, cost_center_code, cost_center_name, safekeep_company_code, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, parent_org_code, parent_org_name) SELECT ims_prototype_order_safekeep_configure_id, dept_id, dept_code, dept_name, fee_asc_code, fee_asc_name, cost_center_id, cost_center_code, cost_center_name, safekeep_company_code, safekeep_inventory_code, safekeep_location_id, safekeep_location_code, safekeep_location_name, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, parent_org_code, parent_org_name FROM ims_prototype_order_safekeep_configure_copy318;
```

# 分销订单/退单

```
INSERT INTO ims_dist_sales_order (id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, ship_flag, ship_status, memo, invoice_type, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, location_id, warehouse_id, pre_pay_amount, rebate_expense_amount, rebate_nonexpense_amount, old_pre_pay_amount, old_rebate_expense_amount, old_rebate_nonexpense_amount, sale_count, sale_amount, sale_discount, sale_discount_rate, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, delivery_flag, delivery_msg, deduction_flag, deduction_msg, release_diff_flag, contract_flag, pre_pay_amount_balance, rebate_expense_amount_balance, rebate_nonexpense_amount_balance, out_credit_balance, inner_credit_balance, out_credit, inner_credit, old_out_credit, old_inner_credit, violation_order_flag) SELECT id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, ship_flag, ship_status, memo, invoice_type, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, location_id, warehouse_id, pre_pay_amount, rebate_expense_amount, rebate_nonexpense_amount, old_pre_pay_amount, old_rebate_expense_amount, old_rebate_nonexpense_amount, sale_count, sale_amount, sale_discount, sale_discount_rate, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, delivery_flag, delivery_msg, deduction_flag, deduction_msg, release_diff_flag, contract_flag, pre_pay_amount_balance, rebate_expense_amount_balance, rebate_nonexpense_amount_balance, out_credit_balance, inner_credit_balance, out_credit, inner_credit, old_out_credit, old_inner_credit, violation_order_flag FROM ims_dist_sales_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO ims_dist_sales_order_item (id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, audit_count, audit_amount, tax_rate, rebate_expense_amount, rebate_nonexpense_amount, old_rebate_expense_amount, old_rebate_nonexpense_amount, submission_count, total_count, unsend_count, not_send_count, send_count, release_count, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, out_credit, inner_credit, old_out_credit, old_inner_credit, delivery_line_id, sn, usable_count) SELECT id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, audit_count, audit_amount, tax_rate, rebate_expense_amount, rebate_nonexpense_amount, old_rebate_expense_amount, old_rebate_nonexpense_amount, submission_count, total_count, unsend_count, not_send_count, send_count, release_count, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, out_credit, inner_credit, old_out_credit, old_inner_credit, delivery_line_id, sn, usable_count FROM ims_dist_sales_order_item_copy318 where header_id in (select id from ims_dist_sales_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO ims_dist_refund_order (id, receive_refund_order_no, customer_code, customer_name, sale_company_code, sale_company_name, return_type, receive_warehouse, receive_location, memo, transport_company, transport_company_name, transport_number, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, location_id, warehouse_id, total_return_amount, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, self_mailing_flag, push_procurement_flag, push_procurement_msg, push_procurement_time, invoice_back_flag, refund_receipt_flag, refund_receipt_msg, refund_receipt_time, cn_warehouse_flag, cn_warehouse_code, cn_warehouse_name, quota_flag, delivery_order_no, sales_order_no, push_adjust_bill) SELECT id, receive_refund_order_no, customer_code, customer_name, sale_company_code, sale_company_name, return_type, receive_warehouse, receive_location, memo, transport_company, transport_company_name, transport_number, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, location_id, warehouse_id, total_return_amount, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, self_mailing_flag, push_procurement_flag, push_procurement_msg, push_procurement_time, invoice_back_flag, refund_receipt_flag, refund_receipt_msg, refund_receipt_time, cn_warehouse_flag, cn_warehouse_code, cn_warehouse_name, quota_flag, delivery_order_no, sales_order_no, push_adjust_bill FROM ims_dist_refund_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO ims_dist_refund_order_item (id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, return_count, change_price, return_amount, tax_rate, return_store_count, sn, receive_sn, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, audit_amount, receive_transport_number, sales_order_no, invoice_code, ori_price, ori_pre_pay_price, ori_rebate_expense_price, ori_rebate_nonexpense_price, ori_out_credit, ori_inner_credit, ori_line_id) SELECT id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, return_count, change_price, return_amount, tax_rate, return_store_count, sn, receive_sn, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, audit_amount, receive_transport_number, sales_order_no, invoice_code, ori_price, ori_pre_pay_price, ori_rebate_expense_price, ori_rebate_nonexpense_price, ori_out_credit, ori_inner_credit, ori_line_id FROM ims_dist_refund_order_item_copy318 where header_id in (select id from ims_dist_refund_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO ims_dist_refund_order_sn_check (id, refund_order_id, sn, traceability_consistency, product_sap_id, product_name, product_grade, remote_identify_form, remote_identify_form_no, remote_identify_form_time, latest_out_time, latest_out_no, traceable_customer_code, traceable_customer_name, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, product_consistency, sn_match_product) SELECT id, refund_order_id, sn, traceability_consistency, product_sap_id, product_name, product_grade, remote_identify_form, remote_identify_form_no, remote_identify_form_time, latest_out_time, latest_out_no, traceable_customer_code, traceable_customer_name, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, product_consistency, sn_match_product FROM ims_dist_refund_order_sn_check_copy318 where refund_order_id in (select id from ims_dist_refund_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

# 分销寄售

```
INSERT INTO ims_consign_sales_order (id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, ship_flag, ship_status, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, memo, sale_count, sale_amount, settlement_amount, settlement_code, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, consign_order_type, warehouse_code, warehouse_name, warehouse_id, location_id, location_code, location_name, consign_push_flag, consign_push_msg) SELECT id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, ship_flag, ship_status, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, memo, sale_count, sale_amount, settlement_amount, settlement_code, audit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, push_old_flag, consign_order_type, warehouse_code, warehouse_name, warehouse_id, location_id, location_code, location_name, consign_push_flag, consign_push_msg FROM ims_consign_sales_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO ims_consign_sales_order_item (id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, audit_count, audit_amount, tax_rate, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, settlement_price, apply_settlement_amount, audit_settlement_amount, deduction_share_price, settlement_account_price, as_spare_partcode, sn_text) SELECT id, deliver_line_type, header_id, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, audit_count, audit_amount, tax_rate, memo, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, settlement_price, apply_settlement_amount, audit_settlement_amount, deduction_share_price, settlement_account_price, as_spare_partcode, sn_text FROM ims_consign_sales_order_item_copy318 where header_id in (select id from ims_consign_sales_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

# 一件代发

```
INSERT INTO ims_dist_dropshipping_order (id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, remark, pre_pay_amount, rebate_expense_amount, rebate_nonexpense_amount, sale_count, sale_amount, sale_discount, sale_discount_rate, audit_status, push_old_flag, delivery_flag, delivery_status, delivery_type, contract_flag, pre_pay_amount_balance, rebate_expense_amount_balance, rebate_nonexpense_amount_balance, out_credit_balance, inner_credit_balance, out_credit, inner_credit, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login) SELECT id, delivery_order_no, sales_order_no, customer_code, customer_name, sale_company_code, sale_company_name, remark, pre_pay_amount, rebate_expense_amount, rebate_nonexpense_amount, sale_count, sale_amount, sale_discount, sale_discount_rate, audit_status, push_old_flag, delivery_flag, delivery_status, delivery_type, contract_flag, pre_pay_amount_balance, rebate_expense_amount_balance, rebate_nonexpense_amount_balance, out_credit_balance, inner_credit_balance, out_credit, inner_credit, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login FROM ims_dist_dropshipping_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO ims_dist_dropshipping_order_item (id, header_id, line_order_no, line_type, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, send_count, not_send_count, pre_pay_amount, tax_rate, rebate_expense_amount, rebate_nonexpense_amount, out_credit, inner_credit, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, delivery_line_id, delivery_order_no, express_no, line_status, delivery_flag, delivery_status, push_old_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, usable_count) SELECT id, header_id, line_order_no, line_type, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, approval_no, price, apply_count, apply_amount, send_count, not_send_count, pre_pay_amount, tax_rate, rebate_expense_amount, rebate_nonexpense_amount, out_credit, inner_credit, province_id, province_name, city_id, city_name, area_id, area_name, receive_addr, receiver, receive_mobile, delivery_line_id, delivery_order_no, express_no, line_status, delivery_flag, delivery_status, push_old_flag, remark, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, usable_count FROM ims_dist_dropshipping_order_item_copy318 where header_id in (select id from ims_dist_dropshipping_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO ims_dist_dropshipping_order_gift (id, line_id, line_order_no, line_type, gift_apply_no, gift_code, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, price, quantity, send_count, not_send_count, amount, cost, gift_status, delivery_flag, delivery_line_id, delivery_order_no, express_no, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, push_sap_msg, gl_date, abl_id, insider_trading_flag, insider_trading_back_flag, push_sap_flag, virtual_warehouse_code, virtual_location_code, location_code, warehouse_code) SELECT id, line_id, line_order_no, line_type, gift_apply_no, gift_code, product_big_type, product_middle_type, product_small_type, product_name, brand_cn, product_series_model, product_sku, product_sap_id, product_type, product_grade, price, quantity, send_count, not_send_count, amount, cost, gift_status, delivery_flag, delivery_line_id, delivery_order_no, express_no, delete_flag, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, push_sap_msg, gl_date, abl_id, insider_trading_flag, insider_trading_back_flag, push_sap_flag, virtual_warehouse_code, virtual_location_code, location_code, warehouse_code FROM ims_dist_dropshipping_order_gift_copy318 where line_id in (select id from ims_dist_dropshipping_order_item_copy318 where header_id in (select id from ims_dist_dropshipping_order_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'))
```

# 财务金税

```
INSERT INTO gold_info (id, invoice_id, apply_code, operate_type, invoice_category, status, fail_cause, pdf_url, picture_url, invoice_time, invoice_no, invoice_form, invoice_dm, invoice_code, clerk, old_invoice_no, notify_phone, notify_email, create_time, buyer_name, buyer_taxpayer_no, buyer_addr, buyer_tel, seller_name, seller_taxpayer_no, remarks, invoice_amount, no_tax_amount, tax, red_remaining_amount, red_remaining_no_tax_amount, red_remaining_tax, digital_resp, seller_addr, seller_tel, seller_bank, seller_bank_account, buyer_bank, buyer_bank_account, xml_url, invoice_type, handle_status, diff_tax_label, old_invoice_time, full_red_flag, red_confirm_no, delete_flag, creation_date, created_by, last_updated_by, last_update_date, last_update_login, version_num, apply_order_no, source_platform) SELECT id, invoice_id, apply_code, operate_type, invoice_category, status, fail_cause, pdf_url, picture_url, invoice_time, invoice_no, invoice_form, invoice_dm, invoice_code, clerk, old_invoice_no, notify_phone, notify_email, create_time, buyer_name, buyer_taxpayer_no, buyer_addr, buyer_tel, seller_name, seller_taxpayer_no, remarks, invoice_amount, no_tax_amount, tax, red_remaining_amount, red_remaining_no_tax_amount, red_remaining_tax, digital_resp, seller_addr, seller_tel, seller_bank, seller_bank_account, buyer_bank, buyer_bank_account, xml_url, invoice_type, handle_status, diff_tax_label, old_invoice_time, full_red_flag, red_confirm_no, delete_flag, creation_date, created_by, last_updated_by, last_update_date, last_update_login, version_num, apply_order_no, source_platform FROM gold_info_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00'
```

```
INSERT INTO gold_info_line (id, header_id, invoice_no, line_id, ymx_line_id, line_nature, standard_code, material_code, material_name, invoice_name, model, uom, quantity, price, amount, rate, tax, amount_tax, delete_flag, created_by, last_updated_by, last_update_date, last_update_login, version_num, good_project_no, relate_blue_good_project_no, write_off_remain_no_tax_amount, standard_name, standard_name1, deduction_amount, write_off_remain_tax, write_off_remain_amount, project_name, creation_date) SELECT id, header_id, invoice_no, line_id, ymx_line_id, line_nature, standard_code, material_code, material_name, invoice_name, model, uom, quantity, price, amount, rate, tax, amount_tax, delete_flag, created_by, last_updated_by, last_update_date, last_update_login, version_num, good_project_no, relate_blue_good_project_no, write_off_remain_no_tax_amount, standard_name, standard_name1, deduction_amount, write_off_remain_tax, write_off_remain_amount, project_name, creation_date FROM gold_info_line_copy318 where header_id in (select id from gold_info_copy318 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00')
```

```
INSERT INTO consumer_goods_position (header_id, company_code, company_name, customer_id, customer_code, customer_name, currency, prepayment_balance, fees_discount_balance, no_discount_balance, total_amount, credit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag) SELECT header_id, company_code, company_name, customer_id, customer_code, customer_name, currency, prepayment_balance, fees_discount_balance, no_discount_balance, total_amount, credit_status, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag FROM consumer_goods_position_copy318;
```

```
INSERT INTO prepayment_details (prepayment_id, header_id, balance_type, prepayment_type, doc_number, source_doc_type, prepayment_amount, trading_date, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, invoicing_id) SELECT prepayment_id, header_id, balance_type, prepayment_type, doc_number, source_doc_type, prepayment_amount, trading_date, version_num, created_by, creation_date, last_updated_by, last_update_date, last_update_login, delete_flag, invoicing_id FROM prepayment_details_copy318;
```

# 刷新状态

#### 样机申请单: 审核状态改为草稿

```
update ims_prototype_order set audit_status = 'DRAFT' where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
```

#### 样机归还单: 审核状态改为草稿

```
update ims_prototype_return set audit_status = 'DRAFT' where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
```

#### 分销渠道订单: 审核状态改为草稿,发货状态改为待发货,订单发货标识改为未处理,app推送标识改为未推送

```
update ims_dist_sales_order set audit_status = 'DRAFT',ship_status='WAITDELIVER',ship_flag='N',push_old_flag = null where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
```

#### 分销渠道退单: 审核状态改为草稿,app推送标识改为未推送,推送收款改为未推送,是否入库改为否(明细行入库数量改为0)

```
update ims_dist_refund_order set audit_status = 'DRAFT',refund_receipt_flag='0',push_old_flag = null where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
update ims_dist_refund_order_item set return_store_count = '0' where header_id in (select id from ims_dist_refund_order where  creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00');
```

#### 寄售订单: 审核状态改为草稿,推送状态改为未处理

```
update ims_consign_sales_order set audit_status = 'DRAFT',consign_push_flag = null where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
```

#### 一件代发订单: 审核状态改为草稿,app推送标识改为未推送

```
update ims_dist_dropshipping_order set audit_status = 'DRAFT',push_old_flag = 0 where creation_date > '2025-02-01 00:00:00' and creation_date < '2025-03-01 00:00:00';
```