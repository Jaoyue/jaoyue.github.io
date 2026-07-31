SELECT
        ipppptb.product_sap_id,
        ipppptb.customer_code,
        ipppptb.pick_up_price,
        ipppptb.price_code,
        pi.product_category
        FROM
        ims_product_price_promotion_price_to_b ipppptb
        left join product_info pi
        on ipppptb.product_sap_id = pi.product_sap_id
        and pi.delete_flag = 0
        WHERE
        ipppptb.delete_flag = 0
and ipppptb.product_sap_id= '109-25630101' and ipppptb.customer_code= '1000461';

-- 门店促销价目表
select distinct effective_status from dmp_product.ims_product_price_store_promotion_price;
select * from dmp_product.ims_product_price_store_promotion_price where effective_status = 'EFFECTIVE' and delete_flag = 0 and start_date <= now() and end_date >= now();
select count(1) from dmp_product.ims_product_price_store_promotion_price where effective_status = 'EFFECTIVE' and delete_flag = 0 and start_date <= now() and end_date >= now();

select * from dmp_marketing.ims_offline_promotion_policy;

