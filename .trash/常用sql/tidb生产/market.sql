select * from ims_policy_bet_cash_apply where bet_cash_apply_code = 'DDTX202604000039';
select * from ims_policy_bet_cash_apply_store where bet_cash_apply_id = '2046877704217284609';
select * from ims_policy_bet_cash_apply_detail where bet_cash_apply_id = '2046877704217284609';

select * from ims_policy_bet_apply where bet_apply_id = 2032350302847799297;

select * from ims_policy_bet_apply_detail where bet_apply_sub_id in (select bet_apply_sub_id from dmp_marketing.ims_policy_bet_cash_apply_detail where bet_cash_apply_id = 2046877704217284609);

update ims_policy_bet_apply_detail set policy_type = 'SALE' where policy_type = '渠道销售补贴';
update ims_policy_bet_apply_detail set policy_type = 'SALES GROWTH' where policy_type = '销售增长奖励';
update ims_policy_bet_apply_detail set policy_type = 'MARKET' where policy_type = '市场地位奖励';
update ims_policy_bet_apply_detail set policy_type = 'MARKET SHARE' where policy_type = '市占控比奖励';
update ims_policy_bet_apply_detail set policy_type = 'YEAR' where policy_type = '年度销售规模奖励';

# imsOfflinePromotionPolicy
select * from ims_offline_promotion_policy;

select p.id,
       p.source_order_number,
       p.store_no,
       p.product_sap_id,
       p.apply_promotion_amount,
       p.price_subsidy_amount,
       p.gift_subsidy_amount,
       p.other_subsidy_amount,
       p.total_subsidy_amount,
       p.limit_num,
       p.self_pick_up_control,
       p.promotion_amount,
       p.start_date,
       p.end_date,
       p.policy_cash_flag,
       p.oa_callback_flag,
       p.delete_flag,
       p.version_num,
       p.created_by,
       p.creation_date,
       p.last_updated_by,
       p.last_update_date,
       p.last_update_login,
       p.per_unit_commission,
       p.sales_incentive_type,
       p.sales_target_min,
       p.sales_target_max,
       p.per_unit_incentive,
       p.is_included_bet_reward_scope,
       p.is_included_bet_reward_policy,
       p.sales_area,
       p.product_oa_line_id,
       b.customer_code as distributor_code
from dmp_marketing.ims_offline_promotion_policy p
join dmp_customer.customer_info a on p.store_no = a.customer_code
         join dmp_customer.customer_info b
              on a.customer_parent_id =
                 b.customer_id
order by p.id;

select * from ims_policy_store_order group by order_no having count(*) > 1;
select * from dmp_product.ims_product_price_store_promotion_price where start_date <= '2026-06-01' and end_date >= '2026-06-01';

select * from dmp_marketing.ims_policy_o2o_apply_detail;
select * from ims_policy_o2o_apply;

SELECT
        d.o2o_apply_details_id,d.is_install,d.o2o_apply_id,d.product_sap_id,d.product_name,d.o2o_mall_commission,d.o2o_mall_subsidy,d.o2o_trade_in_commission,
        d.o2o_trade_in_subsidy,d.o2o_dtb_commission,d.o2o_dtb_subsidy,d.enable_flag,d.invalid_date,d.delete_flag ,a.audit_status,a.o2o_apply_code,a.o2o_apply_name,a.begin_date,a.end_date
        FROM
        dmp_marketing.ims_policy_o2o_apply_detail d
        JOIN dmp_marketing.ims_policy_o2o_apply a ON d.o2o_apply_id = a.o2o_apply_id
        WHERE
        d.delete_flag = 0 and a.delete_flag = 0;

select * from ims_offline_promotion_policy where source_order_number = 'OAIP202604220002';
select * from ims_offline_promotion_policy where product_sap_id = '';
