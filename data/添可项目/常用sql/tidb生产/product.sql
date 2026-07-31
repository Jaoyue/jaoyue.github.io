# imsProductPricePromotionPriceToB
select * from ims_product_price_promotion_price_to_b;
# imsProductPriceYearPriceToB
select * from ims_product_price_year_price_to_b;
# imsProductPriceStorePromotionPrice
select * from ims_product_price_store_promotion_price where effective_status = 'EFFECTIVE';
select count(*) from ims_product_price_store_promotion_price;

select p.promotion_price_id,
       p.product_sap_id,
       p.store_code,
       p.customer_code,
       p.start_date,
       p.end_date,
       p.promotion_price,
       p.effective_status,
       p.price_code,
       p.delete_flag,
       p.version_num,
       p.created_by,
       p.creation_date,
       p.last_updated_by,
       p.last_update_date,
       p.last_update_login,
       p.push_money,
       p.activity_type,
       p.makeup_amount,
       p.single_install_reward,
       p.install_subsidy,
       p.other_subsidy,
       b.customer_code as distributor_code
from dmp_product.ims_product_price_store_promotion_price p
join dmp_customer.customer_info a on p.store_code = a.customer_code
         join dmp_customer.customer_info b
              on a.customer_parent_id =
                 b.customer_id
where p.end_date >= '2026-01-01 00:00:00'
order by p.promotion_price_id;

select * from dmp_product.ims_product_price_store_promotion_price where effective_status = 'EFFECTIVE';