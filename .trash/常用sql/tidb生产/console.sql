# imsDistSalesOrder
select * from ims_dist_sales_order where sales_order_no = 'FXDD202604171025500004';
select * from ims_dist_sales_order_item where header_id = '2044965530552320002';

select * from ims_dist_sales_order where sales_order_no = 'FXDD202604171023070002';
select * from ims_dist_sales_order_item where header_id = '2044964843772788737';

select * from ims_dist_sales_order where sales_order_no = 'FXDD202604151043390005';
select * from ims_dist_sales_order_item where header_id = '2044245236597714945';

select * from ims_dist_sales_order_item where sn is not null;

select * from ims_in_stock_sn where sn in (
'TVPLMGJBL5093',
'T4GVYUJCL4685',
'TUHJHNJCL3247',
'TRGFKFJCL9452',
'TR8Q3MJCL2325',
'TQZDFUJCL1112',
'TJGABZJCL8645',
'THL5VFJCL1318',
'TGPVJCJCL7448',
'TG8JLQJCL8157',
'TFSR3GJCL3339',
'TDNXZBJCL6023',
'T99CSQJCL7255',
'T8LXUJJCL8727',
'T88P3ZJCL2601',
'T3YTEPJCL5894',
'TWZCZVJCL6001',
'T2AANBJCL4269',
'TWNLTFJCL0381',
'TVSRZVJCL9766'
    );

select * from ims_in_stock_sn where sn in (
'TG3LD2JTL7328',
'TJZFGRJUL4583',
'T8BA3MJUL2402',
'T7FMKGJTL6962',
'T7TRKHJUL8515',
'TR99L8JUL7656',
'TZNBRSJTL9727',
'TB29LSJTL0777',
'TUMYV4JUL0852',
'TP6VL3JUL1338',
'TBGME5JUL8703',
'THH84NJTL0211',
'TUE3L3JTL9684',
'TV8N74JUL5389',
'TCDBKYJUL4898',
'TX8D4JJUL3571',
'TB7WF7JTL5388',
'TSYLTMJTL7234',
'TSK5YFJTL4331',
'TZCYH6JTL5402'
    );

select * from ims_dist_sales_order_item where sn like '%TVPLMGJBL5093%';
select * from ims_dist_sales_order_item where sn like '%T4GVYUJCL4685%';
select * from ims_dist_sales_order_item where sn like '%TUHJHNJCL3247%';
select * from ims_dist_sales_order_item where sn like '%TRGFKFJCL9452%';
select * from ims_dist_sales_order_item where sn like '%TR8Q3MJCL2325%';
select * from ims_dist_sales_order_item where sn like '%TQZDFUJCL1112%';
select * from ims_dist_sales_order_item where sn like '%TJGABZJCL8645%';
select * from ims_dist_sales_order_item where sn like '%THL5VFJCL1318%';
select * from ims_dist_sales_order_item where sn like '%TGPVJCJCL7448%';
select * from ims_dist_sales_order_item where sn like '%TG8JLQJCL8157%';
select * from ims_dist_sales_order_item where sn like '%TFSR3GJCL3339%';
select * from ims_dist_sales_order_item where sn like '%TDNXZBJCL6023%';
select * from ims_dist_sales_order_item where sn like '%T99CSQJCL7255%';
select * from ims_dist_sales_order_item where sn like '%T8LXUJJCL8727%';
select * from ims_dist_sales_order_item where sn like '%T88P3ZJCL2601%';
select * from ims_dist_sales_order_item where sn like '%T3YTEPJCL5894%';
select * from ims_dist_sales_order_item where sn like '%TWZCZVJCL6001%';
select * from ims_dist_sales_order_item where sn like '%T2AANBJCL4269%';
select * from ims_dist_sales_order_item where sn like '%TWNLTFJCL0381%';
select * from ims_dist_sales_order_item where sn like '%TVSRZVJCL9766%';