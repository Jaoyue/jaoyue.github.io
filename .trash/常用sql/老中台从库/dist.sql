select *
from dist_inventory;

select *
from dist_distributor
where sales_channel = 'LS';

SELECT distributor_code,
       IFNULL(SUM(inventory_quantity),
              0) AS inventory_sum
FROM dist_inventory
GROUP BY distributor_code;

select *
from `platform-oms`.sap_product
where sap_material_no = '109-23281002'
;
SELECT a.material_no,
       IFNULL(SUM(a.inventory_quantity),
              0) AS inventory_sum
FROM dist_distributor b
         LEFT JOIN dist_inventory a
                   ON a.distributor_code =
                      b.distributor_code
WHERE b.sales_channel = 'LS'
  and a.material_no in
      ('107-18730105', '107-18730102',
       '107-18730103', '107-18730301',
       '107-17562003', '107-17562004',
       '109-17620401', '107-17560113',
       '107-17560108', '107-17560102',
       '107-17560105', '107-17690102',
       '107-17690103', '109-17620101',
       '107-16690105', '165-1669-0104',
       '107-16690110', '107-13510022',
       '107-15160112', '107-15160116',
       '109-15090106', '109-15090107',
       '165-1516-0113', '107-13510903',
       '109-17520002', '107-16710201',
       '107-17610401', '107-18990002',
       '165-1516-0008', '109-15090104',
       '107-16690106', '107-19650101',
       '107-14610001', '107-19650103',
       '109-18790101', '111-19600103',
       '109-18790102', '111-19600104',
       '111-19600101', '107-18730106',
       '165-1516-0007', '111-19600106',
       '107-13510902', '165-1351-0018',
       '165-1351-0016', '109-18790103',
       '107-19610106', '107-19610105',
       '107-15160906', '107-13510025',
       '107-19800501', '107-19800101',
       '109-18791201', '109-18791202',
       '112-20130502', '113-20120001',
       '107-20280001', '111-19600601',
       '113-20120002', '113-20120004',
       '109-20190401', '109-20190001',
       '109-20190002', '112-20130501',
       '109-20200001', '109-20200002',
       '109-20200003', '103-20420101',
       '110-20500001', '109-20290001',
       '109-18791203', '107-14060002',
       '109-20200102', '109-15090112',
       '107-15100001', '110-20500101',
       '110-21080001', '109-21230001',
       '112-20131102', '115-20450001',
       '109-20191301', '112-21220001',
       '112-21220002', '109-20201203',
       '110-21080101', '109-22190001',
       '111-21420001', '109-21250001',
       '109-20110001', '111-21420002',
       '111-21420003', '111-21420004',
       '111-21420005', '114-22020000',
       '109-22030001', '112-20131101',
       '114-21420000', '109-22230101',
       '109-21230901', '108-21381101',
       '118-21400001', '109-22200001',
       '109-22230001', '109-18790304',
       '109-20201202', '109-22030902',
       '110-21081601', '109-21230903',
       '109-23310001', '109-23350001',
       '109-22200601', '109-23160101',
       '109-23160002', '107-02020002',
       '162-2223-0001', '110-0713-0008',
       '110-21081801',
       '114-20200001,114-22200000',
       '109-23350201', '109-23760202',
       '109-23430604', '109-23430001')
  and b.distributor_code in
      ('3000400', '3000372', '3000391', '3008501',
       '3008502', '1000920', '1000049', '3000182',
       '8600000002', '1001677', '1001371',
       '1003660', '1004371', '1000034', '1001693',
       '1001711', '1002516', '1004064', '1002667',
       '1004217', '1001144', '1001755', '1002282',
       '1003678', '1004245', '1000898', '1000058',
       '1000885', '1002311', '1002665', '1004033',
       '1004027', '1004059', '1004121', '1001278',
       '1000046', '1004093', '1001307', '1001280',
       '3000450028', '1001763', '1002287',
       '1000830', '1002285', '1002656', '1004298',
       '1001255', '1001719', '1001705', '1003672',
       '1004120', '1000132', '1000804', '3000100',
       '1001510', '1002280', '1002360', '1002789',
       '1003601', '1000131', '1001381', '1001594',
       '1002717', '1002716', '1001683', '1001128',
       '1001624', '1001707', '1002739', '1004024',
       '1004131', '1004297', '3000104', '1001533',
       '1001697', '1001245', '1000111', '1001309',
       '1000109', '1000198', '1001147', '1000112',
       '3000215', '1001581', '1001679', '1001162',
       '1002663', '1002684', '1002718', '1001583',
       '502491', '1004259', '1004286', '1004350',
       '1001709', '1001769', '1002508', '1002714',
       '1002715', '1004075', '1001222', '1001534',
       '1001497', '1002608', '1001167', '1001185',
       '1001429', '1000105', '1002315', '1003669',
       '1003683', '1000837', '1001149', '1001686',
       '1002616', '1002666', '1004232', '1001296',
       '1000903', '1000101', '3000162001',
       '1002321', '1002611', '1001243', '1001516',
       '1000461', '1002513', '1002526', '1000068',
       '1001680', '1001718', '1001767', '1004076',
       '1004132', '1004257', '1001744', '1000000',
       '1000080', '1001743', '1004134', '1004149',
       '1004423', '1001695', '1004127', '1004000',
       '3000153', '3000147', '1004001', '3000162',
       '1004086', '1004394', '1003603', '1004574',
       '1004126', '1004559', '1004600', '1002303',
       '2000063', '3008550', '1002710', '1004645',
       '1002312', '1002664', '3008787', '1004728',
       '1004729', '1004722', '1004721', '1004719',
       '1001528', '1001730', '1001146', '1004735',
       '1004736', '1004718', '1004726', '1004723',
       '1004720', '1001201', '1001527', '1004240',
       '1002319', '1004734', '1004732', '1004731',
       '1004730', '1004727', '1004725', '1004724',
       '1004717', '1004405', '1004773', '1001572',
       '1004621', '1004746', '1004749', '1000253',
       '1001326', '1001720', '1002792', '1001725',
       '8200', '1001537', '1001392', '1004312',
       '1000098', '1004129', '1004130', '1004552',
       '1004553', '1004053', '1004576', '1004556',
       '1002511', '1003560', '1004616', '1004146',
       '1004625', '1004628', '1004641', '1004646',
       '503324', '503323', '1003637', '1004687',
       '1004695', '1004733', '1001532', '1004754',
       '1004522', '3008605', '2000042', '1004770',
       '1003682', '2000094', '3000045', '1004411')
GROUP BY a.material_no;

select distinct sale_area
from dist_distributor
where sale_area = 'sinkChannel';
select distinct *
from dist_distributor
where sale_area = 'sinkChannel';
select *
from dist_distributor
where distributor_code in
      ('2000042', '3008605', '1004770',
       '1004815');
update dist_distributor
set sale_area = 'KA'
where distributor_code in
      ('2000042', '3008605', '1004770',
       '1004815');
select *
from dist_distributor
where distributor_code in
      ('1001725', '1004414', '1004621', '1004746',
       '1004749');
update dist_distributor
set sale_area = 'NEWCHANNEL'
where distributor_code in
      ('1001725', '1004414', '1004621', '1004746',
       '1004749');

select *
from dist_ship_receive_refund_order
where distributor_code = '2000042'

update dist_ship_sales_order
set sale_area = 'KA'
where distributor_code in
      ('2000042', '3008605', '1004770',
       '1004815');
update dist_ship_receive_refund_order
set sale_area = 'KA'
where distributor_code in
      ('2000042', '3008605', '1004770',
       '1004815');
update dist_ship_sales_order
set sale_area = 'NEWCHANNEL'
where distributor_code in
      ('1001725', '1004414', '1004621', '1004746',
       '1004749');
update dist_ship_receive_refund_order
set sale_area = 'NEWCHANNEL'
where distributor_code in
      ('1001725', '1004414', '1004621', '1004746',
       '1004749');

select *
from dist_distributor
where sales_channel = 'SINK_CHANNEL';

select *
from dist_ship_sales_order;

select *
from `platform-dist`.dist_distributor;
select *
from `platform-dist`.dist_inventory;
select *
from `platform-dist`.dist_sales_target_day_detail
where target_date >=
      UNIX_TIMESTAMP('2026-01-01') * 1000
  AND target_date <=
      (UNIX_TIMESTAMP('2026-01-31') * 1000 +
       86399999)
  and distributor_code in
      ('1000034', '1000046', '1000049', '1000058',
       '1000109', '1000111', '1000112', '1000131',
       '1000132', '1000198', '1000804', '1000830',
       '1000885', '1000898', '1001128', '1001144',
       '1001147', '1001162', '1001222', '1001245',
       '1001255', '1001278', '1001280', '1001307',
       '1001309', '1001371', '1001381', '1001497',
       '1001510', '1001533', '1001534', '1001581',
       '1001583', '1001594', '1001624', '1001683',
       '1001693', '1001697', '1001705', '1001707',
       '1001709', '1001711', '1001719', '1001755',
       '1001763', '1001769', '1002280', '1002282',
       '1002285', '1002287', '1002311', '1002360',
       '1002508', '1002516', '1002608', '1002656',
       '1002663', '1002665', '1002667', '1002684',
       '1002714', '1002715', '1002716', '1002717',
       '1002718', '1002739', '1002789', '1003601',
       '1003660', '1003672', '1003678', '1004024',
       '1004027', '1004033', '1004059', '1004064',
       '1004075', '1004093', '1004120', '1004121',
       '1004131', '1004217', '1004245', '1004259',
       '1004286', '1004297', '1004298', '1004350',
       '1004371', '3000100', '3000104', '3000182',
       '3000215', '3000372', '3000391', '3000400',
       '3000450028', '3008501', '3008502',
       '502491')
group by distributor_code;
;
select *
from dist_sales_budget_day_detail;
select *
from dist_sales_budget_detail;
select distributor_code, customer_short_name
from dist_distributor;

select *
from dist_sales_target_day_detail
where distributor_code = '1002511'
  AND target_date = '1767542400000';
select *
from dist_ship_sales_order
where distributor_code = '1002511'
  AND order_time >= '1767542400000'
  and order_time < 1767628800000;
select target_date, distributor_code, sales_amount
from dist_sales_target_day_detail;

select *
from dist_distributor
where sales_channel in ('BUILDING', 'JCPT')
  and status <> 'DISABLED';

select distinct material_no
from dist_product
where material_no in (select distinct material_no
                      from `platform-store`.sp_store_product_stat)
  and on_flag = 0
order by material_no;

select distinct material_no
from `platform-store`.sp_store_product_stat
order by material_no;

select distinct material_no
from `platform-store`.sp_store_product_stat
where material_no in (select material_no
                      from dist_product
                      where product_classification is null);

select *
from dist_distributor
where distributor_code = '3008605';

select *
from dist_distributor
where sales_channel = 'sinkChannel';

select *
from dist_product
where material_no in (select *
                      from dist_product
                      where material_no = '114-22200501';
select *
from dist_product
where material_no = '109-23160201';
select *
from dist_product
where material_no = '109-23430503';
select *
from dist_product
where material_no = '109-25370001';
select *
from dist_product
where material_no = '109-23312505';
select *
from dist_product
where material_no = '109-23281703';
select *
from dist_product
where material_no = '114-23160027';
select *
from dist_product
where material_no = '109-23350201';
select *
from dist_product
where material_no = '109-23430805';

select *
from dist_inventory_operation_log
where distributor_code = '1003672'
  and material_no = '109-24280001'
  and operate_type = 'inventory_quantity'
group by source_no
having count(*) > 1;

select *
from dist_inventory_operation_log
where source_no = 'FXTD202512031354400016';
select *
from dist_inventory_operation_log
where superior_source_no =
      'FXTD202512031354400016';
select *
from dist_inventory_operation_log
where operate_type = 'returned_inventory_quantity'
  and quantity < 0;
select *
from dist_inventory_operation_log
where operate_type = 'returned_way_quantity'
  and quantity > 0
group by concat(source_no, material_no)
having count(*) > 1;

select dist_product.material_no
from dist_product
where material_no not in
      (select sp_product.material_no
       from `platform-store`.sp_product)
;
select *
from dist_product
where material_no = '109-23281004';
select sum(sales_amount)
from dist_sales_target_day_detail
where target_date >= 1767196800000
  and target_date < 1769875200000

SELECT dd.sale_area,
       SUM(st.sales_amount) AS month_target
FROM dist_distributor dd
         LEFT JOIN dist_sales_target_day_detail st
                   ON dd.distributor_code =
                      st.distributor_code
                       AND FROM_UNIXTIME(
                                       st.target_date /
                                       1000,
                                       '%Y-%m-%d') >=
                           '2026-01-01'
                       AND FROM_UNIXTIME(
                                       st.target_date /
                                       1000,
                                       '%Y-%m-%d') <
                           '2026-02-01'
WHERE dd.sale_mode = 'OFFLINE'
  AND dd.sale_area IN (
                       'DONGBEI', 'HUANAN',
                       'HUDONGYI', 'HUDONGER',
                       'XIBEI', 'XINAN', 'SUZHOU',
                       'NHUABEI',
                       'HUAZHONG', 'HANZHOU',
                       'SHANGHAI', 'NANNING',
                       'CHANGSHA', 'KUNMING',
                       'XIAMEN',
                       'ZHENGZHOU', 'HEFEI',
                       'NANJING', 'CHONGQING',
                       'QINGDAO', 'HAERBIN',
                       'SHIJIAZHUANG',
                       'SELF_EMPLOYED',
                       'SHENZHEN', 'SHENGDAI',
                       'BUILDING', 'JCPT',
                       'ZHONGMIAN',
                       'SUPERMARKET',
                       'SINKCHANNEL'
    )
GROUP BY dd.sale_area;

select *
from dist_distributor
where sales_channel = 'SINK_CHANNEL'
  and distributor_code = '3008605';
select *
from dist_distributor
where sales_channel = 'SINK_CHANNEL'
  and distributor_code = '3008605';
select *
from dist_user
where name = '赵越';

select *
from dist_inventory
where distributor_code = '1004297'
  and material_no = '115-24470001';
select *
from dist_inventory_operation_log
where distributor_code = '1004297'
  and material_no = '115-24470001';
select *
from dist_inventory_operation_log
where source_no = '621773565276113135262'
  and material_no = '115-24470001';

select *
from dist_inventory;

select sum(sales_amount) target
from `platform-dist`.dist_sales_target_day_detail
where target_date >= 1767196800000
  AND target_date < 1798732800000
  and distributor_code = '1000885';
SELECT SUM(sales_amount) AS target
FROM `platform-dist`.dist_sales_target_day_detail
WHERE target_date >=
      UNIX_TIMESTAMP(MAKEDATE(YEAR(CURDATE()),
                              1)) * 1000
  AND target_date <
      UNIX_TIMESTAMP(MAKEDATE(YEAR(CURDATE()) + 1,
                              1)) * 1000
  AND distributor_code = '1000885';

SELECT distributor_name,
       CASE status
           WHEN 'DISABLED' THEN '关闭'
           WHEN 'FREEZE' THEN '冻结'
           WHEN 'TAKE_EFFECT' THEN '正常'
           ELSE status END AS status,
       distributor_code
FROM `platform-dist`.dist_distributor
where distributor_code in
      ('1000000', '1000034', '1000046', '1000049')
  and if('REGION' != null and '' != '',
         manage_class in ('REGION'), 1 = 1);

select * from dist_ship_sales_order where distributor_code = '1004921';
select * from dist_distributor where distributor_code = '3008639';
select * from dist_distributor where sales_channel = 'SINK_CHANNEL' and distributor_code = 1004921;

select * from dist_product where material_no = '109-23481501';
select * from dist_sales_order_item order by id desc;

select d.*,i.* from dist_sales_order d join dist_sales_order_item i on d.sales_order_no = i.sales_order_no where distributor_code in ('2000078','2000056','1001537') and finance_audit_time < 1664553600000;
select distinct d.sales_order_no from dist_sales_order d join dist_sales_order_item i on d.sales_order_no = i.sales_order_no where distributor_code in ('2000078','2000056','1001537') and finance_audit_time < 1664553600000;