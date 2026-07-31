select *
from tdm_experience_share_info
where (title = '销售金点子' or
       title = '销售精点子')
  and create_time >= '1761926400000'
  and create_time < '1764518400000';
select *
from tdm_experience_share_info
where title = '销售金点子'
  and create_time >= 1767196800000;
select *
from tdm_experience_share_info
where id = 6746;
update tdm_experience_share_info
set pic_url = 'https://dbu-file.tineco.cn:7443/data/dbu/store/2025-12-02/aa9a0ed0-29b8-4ea6-a19e-d74a5dccf39e.mp4'
where id = 6746;
select *
from tdm_product;
select *
from tdm_sales_order_material_stat
order by sale_time desc
limit 100;
select *
from tdm_ec_sales_import_stat
order by id desc
limit 100;
select *
from tdm_config
where `key` = 'tineco.platform.se.address';
select *
from tdm_sales_order_task;

select *
from tdm_sales_order
order by id desc
limit 100;
select *
from tdm_sales_order
where order_no not like 'FXDD%'
  and order_no not like 'FXF%'
order by id desc
limit 1000;
select *
from tdm_sales_order
where (order_no like 'FXDD%' OR
       order_no like 'FXF%')
order by id desc
limit 1000;
select distinct source
from tdm_sales_order
where order_time >= 1778029749000;

SELECT (unix_timestamp(date_format(
        from_unixtime((order_time / 1000)),
        '%Y-%m-%d')) * 1000)    AS sale_time,
       category,
       shop_code,
       shop_name,
       material_no,
       sum(count)               AS `count`,
       sum(total_amount)        AS total_amount,
       sum(count)               AS order_count,
       count(DISTINCT customer) AS customer_num,
       count(IF((order_status = 'SHIPPED'), 1,
                NULL))          AS send_count
FROM tdm_sales_order
WHERE order_time >= 1778029749000
  AND (source != 'DIST' OR (source = 'DIST' AND
                            order_status IN
                            ('WAIT_SHIPPING',
                             'SHIPPING_COMPLETED',
                             'SHIPPING_PART')))
GROUP BY sale_time, shop_code, material_no;

select *
from tdm_sales_order_material_stat
where material_no IN (
    '109-24671901'
    )
  and sale_time >= 1777564800000;
select *
from tdm_sales_order
where material_no = '';

select *
from tdm_product
where material_no IN (
                      '109-24671901',
                      '109-24670001',
                      '109-24670301',
                      '109-24670201',
                      '109-24112102',
                      '109-24112101'
    );

select so.material_no    code,
       sum(`count`)      `count`,
       sum(total_amount) totalAmount
from tdm_sales_order_material_stat so
         JOIN tdm_shop s on s.`delete` = 0 and
                            so.shop_code =
                            s.shop_code and
                            data_source =
                            'platform'
where so.category = 'online'
  and sale_time >= 1777564800000
  and sale_time < 1780243200000
  and material_no = '109-24671901'
GROUP BY so.material_no;
select *
from tdm_shop
where shop_code = '3008853';

select distinct material_no
from tdm_sales_order_material_stat
where material_no not in
      (select material_no from tdm_product)
  and material_no like '109%';

select *
from tdm_user_shop;
select *
from tdm_user_info
where name = '李二星';
select *
from tdm_user_info
where user_name = 'tina.feng';

select * from tdm_shop where shop_code = '3008853';
select * from tdm_shop where shop_platform = 'UN';
select sum(count) from tdm_sales_order where material_no = '109-24671901' and order_time >= 1777564800000;

select so.material_no    code,
       sum(`count`)      `count`,
       sum(total_amount) totalAmount
from tdm_sales_order_material_stat so
         JOIN tdm_shop s on s.`delete` = 0 and
                            so.shop_code =
                            s.shop_code and
                            data_source =
                            'platform'
where so.category = 'online' and s.shop_platform = 'UN'
  and sale_time >= 1777564800000
  and sale_time < 1780243200000
  and so.shop_code in
      (
       '3000002',
       '0000008201',
       '0001000707',
       '0001000699',
       '3000118',
       '3000100',
       '0001000968',
       '0000008601',
       '0001001039',
       '3000197',
       '2000028',
       '3000196',
       '3000195',
       '1000031',
       '2000035',
       '2000038',
       '1001569',
       '1000789',
       '2000018',
       '2000031',
       '2000029',
       '3000240',
       '1001689',
       '1001726',
       '2000052',
       '1002711',
       '1002277',
       '1002694',
       '1002696',
       '3000331',
       '2000042',
       '0003333333',
       '2000069',
       '3000333',
       '3000344',
       '3000343',
       '2000071',
       '3000341',
       '3000339',
       '3000342',
       '3000349',
       '3000346',
       '2000073',
       '3008530',
       '2000085',
       '3008529',
       '3008505',
       '3008512',
       '3008516',
       '3008514',
       '3000045',
       '3008538',
       '3008540',
       '3008566',
       '3008567',
       '3008580',
       '3008576',
       '3008581',
       '3008585',
       '3008582',
       '3008583',
       '3008587',
       '3008586',
       '3008589',
       '3008639',
       '8200139',
       '1004917',
       '1004912',
       '1004911',
       '3008868',
       '3008867',
       '1004896',
       '1004895',
       '1004889',
       '3008590',
       '3008596',
       '3008866',
       '3008584',
       '1004880',
       '3008865',
       '1004507',
       '3008863',
       '1000069',
       '1004868',
       '105578',
       '8200302',
       '3008862',
       '3008861',
       '1004853',
       '1004845',
       '3008859',
       '3008857',
       '8200319',
       '8200317',
       '1004829',
       '1001407',
       '1001378',
       '1002337',
       '1002334',
       '1002335',
       '8000013',
       '1004822',
       '1004818',
       '1004817',
       '1004816',
       '3008598',
       '3008853',
       '1001517',
       '1001411',
       '1003551',
       '1001698',
       '1004811',
       '8200307',
       '3008852',
       '1004806',
       '1004803',
       '8200301',
       '8200299',
       '3008851',
       '3008850',
       '1004796',
       '1004789',
       '1004788',
       '3008846',
       '3000205',
       '3008844',
       '3008842',
       '3008843',
       '3008841',
       '3008840',
       '3008839',
       '1004781',
       '1004782',
       '8200225',
       '3008544',
       '3008838',
       '3008837',
       '1004390',
       '2000023',
       '2000077',
       '3008595',
       '1004760',
       '3008834',
       '3008597',
       '1004756',
       '1004741',
       '1004755',
       '3008828',
       '3008831',
       '3008829',
       '1004748',
       '1004747',
       '3008830',
       '1004745',
       '3008821',
       '3008819',
       '1004737',
       '1004716',
       '1004715',
       '1004714',
       '1004713',
       '1004712',
       '1004711',
       '1004710',
       '1004709',
       '1004708',
       '1004705',
       '3008803',
       '1004704',
       '1004702',
       '3008796',
       '3008795',
       '3008794',
       '3008793',
       '1004701',
       '3008792',
       '1004699',
       '1004698',
       '1004697',
       '1004693',
       '1004515',
       '3008782',
       '3008781',
       '3008780',
       '3008779',
       '3008777',
       '3008776',
       '3008774',
       '1004669',
       '1004665',
       '1004664',
       '1004663',
       '3008772',
       '3008771',
       '3008770',
       '3008769',
       '1004654',
       '3008768',
       '3008767',
       '3008764',
       '3008763',
       '3008761',
       '1004649',
       '3008760',
       '3008759',
       '1004647',
       '1004643',
       '3008742',
       '3008741',
       '1001547',
       '3008732',
       '3000356',
       '1004627',
       '1001541',
       '1004626',
       '3008712',
       '3008711',
       '1004624',
       '3008710',
       '3008709',
       '3008708',
       '3008707',
       '8200212',
       '1004619',
       '3008706',
       '1004618',
       '8200210',
       '3000331',
       '3008705',
       '8200209',
       '3008704',
       '3008703',
       '3008702',
       '3008700',
       '3008699',
       '3008698',
       '3008697',
       '1002352',
       '3008696',
       '3008695',
       '3008692',
       '3008691',
       '3008690',
       '3008689',
       '3008687',
       '3008686',
       '3008683',
       '3008682',
       '3008681',
       '3008680',
       '3008679',
       '3008669',
       '3008668',
       '3008666',
       '3008665',
       '3008664',
       '3008663',
       '3008656',
       '1004593',
       '1004592',
       '1004590',
       '1004589',
       'D812',
       '1000787',
       '1002340',
       '1001098',
       '1002330',
       '3008655',
       '3008593',
       '8200192',
       '3008651',
       '3008650',
       '3008591',
       '3008649',
       '3008648',
       '3008647',
       '3008646',
       '3008645',
       '3008642',
       '1004582',
       '3008638',
       '3008637',
       '1004506',
       '3008635',
       '1004577',
       '3008633',
       '1002332',
       '3008563',
       '3008564',
       '1001417',
       '3008559',
       '1001611',
       '1002331',
       '1002339',
       '3008579',
       '3008630',
       '3008629',
       '3008628',
       '3008627',
       '3008626',
       '8000002',
       '3008548',
       '3008625',
       '3008624',
       '8000010',
       '3008621',
       '8200197',
       '3008620',
       '8200196',
       '8200195',
       '3008619',
       '8200194',
       '1001388',
       '1002651',
       '3008615',
       '3008614',
       '3008613',
       '3008612',
       'D806',
       '3008610',
       '3008609',
       '3008608',
       '8000006',
       '3008607',
       '3008606',
       '1004475',
       '1004550',
       '1004498',
       '1004477',
       '1004472',
       '1004471',
       '1004470',
       '1004469',
       '1004466',
       '1004144',
       '1004085',
       '1004084',
       '1004083',
       '1004082',
       '1001290',
       '2000092',
       '2000091',
       '2000090',
       '2000079',
       '2000078',
       '1001766',
       '1002805',
       '2000057',
       '2000065',
       '2000064',
       '0002000062',
       '2000061',
       '2000060',
       '2000059',
       '2000058',
       '1002679',
       '1002509',
       '2000056',
       '2000055',
       '2000054',
       '2000051',
       '1002713',
       '1001442',
       '1001652',
       '1000664',
       '1002347',
       '1001649',
       '1001648',
       '1001443',
       '1001646',
       '1001608',
       '1001258',
       '1001454',
       '1001482',
       '1001157'
          )
GROUP BY so.material_no;
select * from tdm_sales_order where shop_code = '3008581';
select * from tdm_shop where shop_code IN ('3000344','3008576','3000342','3000343','2000071','3000339','3000341','3008581','2000073','3008624','3008649','3008669','3008680','3008639','3008853');
update tdm_shop set shop_platform = 'UN' where shop_code IN ('3000344','3008576','3000342','3000343','2000071','3000339','3000341','3008581','2000073','3008624','3008649','3008669','3008680','3008639','3008853');
;
select * from tdm_task;
select * from tdm_sales_order_task;