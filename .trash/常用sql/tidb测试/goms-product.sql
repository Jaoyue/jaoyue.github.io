SELECT
        ipppptb.promotion_price_id,
        ipppptb.product_sap_id,
        ipppptb.customer_code,
        ipppptb.start_date,
        ipppptb.end_date,
        ipppptb.pick_up_price,
        ipppptb.num_toplimit,
        ipppptb.num_lowerlimit,
        ipppptb.effective_status,
        ipppptb.price_code,
        ipppptb.delete_flag,
        ipppptb.version_num,
        ipppptb.created_by,
        ipppptb.creation_date,
        ipppptb.last_updated_by,
        ipppptb.last_update_date,
        ipppptb.last_update_login,
        pi.product_sku as productSku,
        pi.product_name as productName,
        pi.product_series_model as productSeriesModel,
        pi.product_big_type as productBigType,
        pi.product_middle_type as productMiddleType,
        pi.product_small_type as productSmallType,
        pi.brand_cn as brandCn
        FROM
        ims_product_price_promotion_price_to_b ipppptb
        left join product_info pi
        on ipppptb.product_sap_id = pi.product_sap_id
        and pi.delete_flag = 0
        inner join ims_product_price_promotion_price_header_to_b ipppphtb
        on ipppphtb.promotion_price_code = ipppptb.price_code
        and ipppphtb.delete_flag = 0
        WHERE
        ipppptb.delete_flag = 0
        and ipppptb.effective_status = 'EFFECTIVE'
and ipppptb.product_sap_id in ('') and ipppptb.customer_code in ('');

select * from ims_product_price_promotion_price_to_b where effective_status = 'EFFECTIVE';

select * from product_info where product_sap_id = '109-23281011'; -- 1946075850337873921
select * from product_info where product_sap_id = '109-23281006'; -- 1946075850337873921
select * from ims_product_status_manage where product_sap_id = '109-23281011';
select * from ims_product_status_manage where product_sap_id = '109-23281006';
select * from ims_product_shelves_status where customer_code = '1000000';

select * from ims_product_price_promotion_price_to_b where customer_code = '1000000';
select * from ims_product_price_promotion_price_to_b where product_sap_id = '109-23281011';
select * from ims_product_price_promotion_price_to_b where product_sap_id = '109-23281006';