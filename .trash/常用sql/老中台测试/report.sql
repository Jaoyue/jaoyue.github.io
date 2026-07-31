select * from sync_ims_offline_promotion_policy;
select * from sync_ims_product_price_promotion_price_to_b;
select * from sync_ims_product_price_store_promotion_price;
select * from sync_ims_product_price_year_price_to_b;

select distinct effective_status from sync_ims_product_price_store_promotion_price;
select count(1) from sync_ims_product_price_store_promotion_price where effective_status = 'EFFECTIVE';

select * from sync_ims_policy_o2o_apply_detail;


