select * from ims_dist_sales_order where sales_order_no = 'FXDD202508190938520007';
select * from ims_dist_sales_order_item where header_id = '1957618235165306882';
select * from ims_dist_refund_order_sn_check where sn = 'T3VTBKSBJ0783';

select * from ims_delivery_sign_sn where sn = 'T3VTBKSBJ0783';
select * from dmp_tms.ims_logistics_delivery_order_header where delivery_order_num = 'FH250827144676';
select * from dmp_tms.ims_logistics_delivery_order_line where order_header_id = '1960595701045567490';

select * from dmp_product.ims_product_price_year_price_to_b where price_code = 'IMSYRTB2025122600001';
update ims_store_refund_order set push_inventory_flag = 1,push_invoice_flag = null,push_virtual_red_ticket_flag = null where order_no in (
'621754466871669378264',
'621757497893505832266',
'621757322769092159269',
'621756023102371452265',
'621757671291704126252',
'621755923248869492253',
'621727437181494783256',
'621725427206262356251',
'621727427808831401253',
'621728301043946705250'
    );

select count(*) from ims_dist_refund_order_item where sn like '%,%';
select * from ims_dist_refund_order where wms_no is not null and audit_status != 'CLOSED'
select * from ims_dist_refund_order where receive_refund_order_no = 'FXTD202603231530210014';
select *,sn,product_grade,product_sap_id from ims_dist_refund_order_item where header_id = '2035982466136317954';

select *,big_channel_type,manage_type from dmp_customer.customer_info where customer_code = '1000461';
# OFFLINE REGION

select * from ims_ec_sales_order order by id desc limit 100;

select * from ims_prototype_return_line_his order by creation_date desc;

select * from ims_prototype_return_line order by creation_date desc;