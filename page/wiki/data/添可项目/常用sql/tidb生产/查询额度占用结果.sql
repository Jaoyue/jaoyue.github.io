select * from consumer_goods_credit_details where release_ori_order_no = '121745589660787734004';
select release_ori_order_no,count(*) from consumer_goods_credit_details where release_ori_order_no in (select account_lock_no from dmp_sales_order.ims_ec_sales_order_ext where account_unlock_flag = 3 and account_unlock_msg = '原单释放失败，未查询到可释放的占用单据或单据已被释放！'
) group by release_ori_order_no;
select release_ori_order_no,count(*)  from consumer_goods_credit_details where release_ori_order_no in (select account_lock_no from dmp_sales_order.ims_ec_sales_order_ext where account_lock_flag = 3 and account_lock_msg like '%占用过额度，不能重复操作！%'
) group by release_ori_order_no;

select * from consumer_goods_credit_details where release_ori_order_no in (
'121748232660878753005'    );

# 121743069900789703009
# 121744561800771738006
# 121745165700871883008
# 121745584080992916005
# 121745589660787734004
# 121748232660878753005