
select * from ims_policy_bet_apply_detail ;

update ims_policy_bet_apply_detail set policy_type = 'SALE' where policy_type = '渠道销售补贴';
update ims_policy_bet_apply_detail set policy_type = 'SALES GROWTH' where policy_type = '销售增长奖励';
update ims_policy_bet_apply_detail set policy_type = 'MARKET' where policy_type = '市场地位奖励';
update ims_policy_bet_apply_detail set policy_type = 'MARKET SHARE' where policy_type = '市占控比奖励';
update ims_policy_bet_apply_detail set policy_type = 'YEAR' where policy_type = '年度销售规模奖励';