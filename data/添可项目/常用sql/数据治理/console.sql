
select * from v_tineco_agent_pub_agent_business_week_config_dd;

select * from tineco_agent_mkt_customer_product_relation_dd where channel_lvl_2 = '悠尼天猫';
select * from tineco_agent_mkt_customer_product_relation_dd where customer_code = '8200340' and product_sap_id = '107-23420505';

select admin_org, prod_sap_id, week, price_range from tineco_agent.tineco_agent_fin_bu_price_range_dd;
select belong_business_entity, currency, price_range, price_begin, price_end from tineco_agent.tineco_agent_fin_price_range_currency_dd;

select * from tineco_agent_fin_bu_price_range_dd;
select * from tineco_agent_fin_bu_price_range_dd where prod_sap_id like '% %';
select * from tineco_agent_fin_bu_price_range_dd where admin_org = '悠尼' and week = '2026W24' and price_range = '1000-1500';
select * from tineco_agent_fin_price_range_currency_dd;
SELECT * FROM tineco_agent.tineco_agent_fin_price_range_currency_dd where currency = 'GBP'