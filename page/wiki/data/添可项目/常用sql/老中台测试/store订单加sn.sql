select * from sp_sales_order where order_no = '601764035271669003019'
select * from sp_sales_order_item where sales_order_no = '601770183411303001019'
TG2AYSL4J10XX
select * from sp_sn_list where sales_order_no = '601764035158020001019'

INSERT INTO `platform-store`.`sp_sn_list` (`sales_order_no`,
                                           `item_id`,
                                           `customer_mobile`,
                                           `sn`,
                                           `creater`,
                                           `create_time`,
                                           `modifier`,
                                           `modify_time`,
                                           `version`,
                                           `push_status`,
                                           `push_count`)
VALUES ('601770183411303001019', 2151070,
        '18895325620', 'TSBK47ZXJ7898', '503',
        1664851824877, '503', 1664851824877, 0,
        'WITHOUT', 0);
T25326478C120
INSERT INTO `platform-store`.`sp_sales_order_item` (`material_no`, `sales_order_no`, `product_id`, `store_product_id`, `product_no`, `product_name`, `product_type`, `product_spec`, `product_bar_code`, `product_unit`, `price`, `sale_price_up`, `sale_price_down`, `count`, `total`, `return_count`, `creater`, `create_time`, `modifier`, `modify_time`, `version`, `icon_url`, `sn`, `purchase_price`, `statement_price`, `is_gift`, `average_price`, `product_discount_ratio`, `product_classification`, `price_code`, `if_cash_o2o`) VALUES ( '109-20200003', '601740918122482946263', 118, 433105, '芙万2.0 Slim 增配版', '芙万2.0 Slim 增配版', 'cleaning', NULL, '6972200199218', NULL, 3000, NULL, NULL, 1, 3000, 0, '322', 1745821966330, '322', 1745821976357, 1, 'https://dbu-file.tineco.cn:7443/data/dbu/store/2024-12-13/e831c17c-0246-49ff-9f9d-4e16181359e1.png', 'E0009637811027062535', 4990, 4990, 'N', 3000, 1, 'QXJ', 'IMSSPP2025042500001', 0);
