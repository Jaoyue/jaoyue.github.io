select * from invoicing_manage where invoice_code = 'FP260100204382';
select max(invoicing_id) from invoicing_manage where invoice_code = 'FP260100204382';
select count(*) from invoicing_manage where invoicing_id < 6933440275087955361;-- 23692868
select count(distinct invoice_code) from invoicing_manage where invoicing_id < 6933440275087955361;-- 23692873
select distinct invoice_source from invoicing_manage;
select distinct invoice_category from invoicing_manage;
select * from invoicing_manage where invoice_category is null order by invoicing_id desc;
select * from invoicing_manage where invoice_date >= '2026-01-01' and invoice_date <= concat('2026-01-31',' 23:59:59')  group by  invoice_code having count(*) >1;

select
  customer_code as company_no,
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-01-01'
  and invoice_date <= concat('2026-01-27', ' 23:59:59')
  and customer_code in ('1000034', '1000046', '1000049')
group by customer_code;

select
*
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2025-01-01'
  and invoice_date <= concat('2025-01-31', ' 23:59:59')
  and customer_code in ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491')
group by customer_code;


select
  customer_code as company_no,
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= DATE_SUB('2026-01-01', INTERVAL 1 YEAR)
  and invoice_date <= DATE_SUB(concat('2026-01-31', ' 23:59:59'), INTERVAL 1 YEAR)
  and customer_code in ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491')
group by customer_code;


select * from invoicing_manage where invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= DATE_SUB('2026-01-01', INTERVAL 1 YEAR)
  and invoice_date <= DATE_SUB(concat('2026-01-31', ' 23:59:59'), INTERVAL 1 YEAR)
  and customer_code in ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491')
 and invoice_category = '红票';
select sum(invoice_amount) from invoicing_manage where invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= DATE_SUB('2026-01-01', INTERVAL 1 YEAR)
  and invoice_date <= DATE_SUB(concat('2026-01-31', ' 23:59:59'), INTERVAL 1 YEAR)
  and customer_code in ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491')
 and invoice_category = '蓝票';

select * from invoicing_manage;
select * from delivery_detail;

select b.material_code,max(b.material_name) as material_name,sum(cny_tax_price) amount
from dmp_finance.invoicing_manage a join delivery_detail b on a.invoicing_id = b.invoicing_id
where invoice_source not in
      ('ZDR1', 'ZCR1', 'CUT', 'DISCOUNT')
  and invoice_date >= '2026-01-01'
  and invoice_date <=
      concat('2026-01-31', ' 23:59:59')
  and customer_code in
      ('1000000')
group by b.material_code order by amount desc;


select
  *
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-03-20 00:00:00'
  and invoice_date <= concat('2026-03-26', ' 23:59:59')
  and customer_code in ('1001624')
;






select
  b.material_code as material_code,b.material_name,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(b.original_currency_amount as signed)
      when a.invoice_category = '红票' then -cast(b.original_currency_amount as signed)
      else 0
    end
  ) as huikuan,
    sum(
    case
      when a.invoice_category = '蓝票' then cast(b.quantity as signed)
      when a.invoice_category = '红票' then -cast(b.quantity as signed)
      else 0
    end
  ) as tai
from dmp_finance.invoicing_manage a
inner join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '2026-02-01'
  and a.invoice_date <= '2026-02-28 23:59:59'
  and a.customer_code = '1000885'
group by b.material_code;


select
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and customer_code = '1000885'
  and invoice_date >= '2026-01-01'
  and invoice_date <= '2026-04-21 23:59:59'; -- 21238576

select
  sum(case
    when invoice_date >= date_format(current_date(), '%Y-01-01')
     and invoice_category = '蓝票' then cast(invoice_amount as signed)
    when invoice_date >= date_format(current_date(), '%Y-01-01')
     and invoice_category = '红票' then -cast(invoice_amount as signed)
    else 0
  end) as huikuan_this_year,
  sum(case
    when invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
     and invoice_date <= date_sub(current_date(), interval 1 day)
     and invoice_category = '蓝票' then cast(invoice_amount as signed)
    when invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
     and invoice_date <= date_sub(current_date(), interval 1 day)
     and invoice_category = '红票' then -cast(invoice_amount as signed)
    else 0
  end) as huikuan_last_year
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and customer_code = '1000885'
  and invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
  and invoice_date <= current_date();
SELECT
    COUNT(*) + 1 AS rank_num
FROM (
    SELECT
        customer_code,
        SUM(
            CASE
                WHEN invoice_category = '蓝票' THEN CAST(invoice_amount AS SIGNED)
                WHEN invoice_category = '红票' THEN -CAST(invoice_amount AS SIGNED)
                ELSE 0
            END
        ) AS huikuan
    FROM dmp_finance.invoicing_manage
    WHERE
        invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
        AND invoice_date >= DATE_FORMAT(CURDATE(), '%Y-01-01')
        AND invoice_date <= CURDATE()
    GROUP BY customer_code
) AS all_cus
WHERE all_cus.huikuan > (
    SELECT
        SUM(
            CASE
                WHEN invoice_category = '蓝票' THEN CAST(invoice_amount AS SIGNED)
                WHEN invoice_category = '红票' THEN -CAST(invoice_amount AS SIGNED)
                ELSE 0
            END
        )
    FROM dmp_finance.invoicing_manage
    WHERE
        invoice_source NOT IN ('ZDR1','ZCR1','CUT','DISCOUNT')
        AND customer_code = '1000885'
        AND invoice_date >= DATE_FORMAT(CURDATE(), '%Y-01-01')
        AND invoice_date <= CURDATE()
);
select
  sum(case
    when invoice_date >= date_format(current_date(), '%Y-01-01')
     and invoice_category = '蓝票' then cast(invoice_amount as signed)
    when invoice_date >= date_format(current_date(), '%Y-01-01')
     and invoice_category = '红票' then -cast(invoice_amount as signed)
    else 0
  end) as huikuan_this_year,
  sum(case
    when invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
     and invoice_date <= date_sub(current_date(), interval 1 day)
     and invoice_category = '蓝票' then cast(invoice_amount as signed)
    when invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
     and invoice_date <= date_sub(current_date(), interval 1 day)
     and invoice_category = '红票' then -cast(invoice_amount as signed)
    else 0
  end) as huikuan_last_year
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and customer_code = '1000885'
  and invoice_date >= date_format(date_sub(current_date(), interval 1 year), '%Y-01-01')
  and invoice_date <= current_date();

select
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-01-01'
  and invoice_date <= concat('2026-04-22', ' 23:59:59')
  and customer_code = '1000903';

select
  date_format(invoice_date, '%Y-%m') as month,
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-01-01'
  and invoice_date <= concat('2026-04-22', ' 23:59:59')
  and customer_code = '1000885'
group by date_format(invoice_date, '%Y-%m');

select *,customer_name from dmp_finance.invoicing_manage where customer_code = '1000885';

select b.material_code,max(b.material_name) as material_name,sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as amount
from dmp_finance.invoicing_manage a join dmp_finance.delivery_detail b on a.invoicing_id = b.invoicing_id
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '#{['form']['startTime']}'
  and invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and customer_code in ('#{['session']['company_nos']}')
group by b.material_code order by amount desc;

select
  customer_code as company_no,
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '#{['form']['startTime']}'
  and invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and customer_code in ('#{['session']['company_nos']}')
group by customer_code;

select b.material_code,
       max(b.material_name) as material_name,
       sum(case
               when invoice_category = '蓝票'
                   then cast(invoice_amount as signed)
               when invoice_category = '红票'
                   then -cast(invoice_amount as signed)
               else 0 end)  as amount
from dmp_finance.invoicing_manage a
         join dmp_finance.delivery_detail b
              on a.invoicing_id = b.invoicing_id
where invoice_source not in
      ('ZDR1', 'ZCR1', 'CUT', 'DISCOUNT')
  and invoice_date >= '2026-04-01'
  and invoice_date <=
      concat('2026-04-30', ' 23:59:59')
  and customer_code in
      ('1000000', '1000034', '1000046', '1000049',
       '1000058', '1000068', '1000080', '1000098',
       '1000101', '1000105', '1000109', '1000111',
       '1000112', '1000131', '1000132', '1000198',
       '1000253', '1000461', '1000804', '1000830',
       '1000837', '1000885', '1000903', '1000920',
       '1001128', '1001144', '1001146', '1001147',
       '1001149', '1001162', '1001185', '1001201',
       '1001222', '1001243', '1001245', '1001255',
       '1001278', '1001280', '1001296', '1001307',
       '1001309', '1001326', '1001371', '1001381',
       '1001392', '1001429', '1001497', '1001510',
       '1001516', '1001527', '1001528', '1001532',
       '1001534', '1001537', '1001572', '1001581',
       '1001583', '1001594', '1001624', '1001677',
       '1001679', '1001680', '1001683', '1001686',
       '1001693', '1001695', '1001697', '1001705',
       '1001709', '1001711', '1001719', '1001720',
       '1001725', '1001743', '1001744', '1001755',
       '1001763', '1001769', '1002280', '1002285',
       '1002287', '1002303', '1002311', '1002315',
       '1002321', '1002360', '1002508', '1002511',
       '1002513', '1002516', '1002526', '1002611',
       '1002616', '1002656', '1002663', '1002664',
       '1002665', '1002666', '1002684', '1002710',
       '1002715', '1002716', '1002718', '1002739',
       '1002740', '1002789', '1002792', '1003560',
       '1003601', '1003660', '1003669', '1003672',
       '1003678', '1003682', '1003683', '1004024',
       '1004033', '1004053', '1004059', '1004064',
       '1004075', '1004120', '1004121', '1004126',
       '1004130', '1004134', '1004139', '1004146',
       '1004149', '1004217', '1004232', '1004245',
       '1004259', '1004286', '1004297', '1004312',
       '1004350', '1004371', '1004372', '1004394',
       '1004411', '1004423', '1004503', '1004522',
       '1004552', '1004556', '1004559', '1004574',
       '1004576', '1004600', '1004616', '1004621',
       '1004628', '1004641', '1004645', '1004646',
       '1004687', '1004695', '1004719', '1004746',
       '1004749', '1004754', '1004770', '1004773',
       '1004795', '1004815', '1004846', '1004855',
       '1004857', '1004869', '1004872', '1004888',
       '1004891', '1004900', '1004901', '1004916',
       '1004921', '2000042', '2000063', '3000100',
       '3000104', '3000162001', '3000182',
       '3000215', '3000372', '3000391', '3000400',
       '3000450028', '3008501', '3008502',
       '3008550', '3008605', '3008787', '3008849',
       '502491', '503323', '503324', '8200',
       '8600000002')
group by b.material_code
order by amount desc;


select
  b.material_code as material_code,b.material_name,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(b.original_currency_amount as signed)
      when a.invoice_category = '红票' then -cast(b.original_currency_amount as signed)
      else 0
    end
  ) as huikuan,
    sum(
    case
      when a.invoice_category = '蓝票' then cast(b.quantity as signed)
      when a.invoice_category = '红票' then -cast(b.quantity as signed)
      else 0
    end
  ) as tai
from dmp_finance.invoicing_manage a
 join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '2026-04-01'
  and a.invoice_date <= concat('2026-04-30', ' 23:59:59')
  and a.customer_code = '1001743'
group by b.material_code order by huikuan desc;

select
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-04-01'
  and invoice_date <= concat('2026-04-30', ' 23:59:59')
  and customer_code = '1001743'
group by customer_code;


select
   a.*
from dmp_finance.invoicing_manage a
 join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where

  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '2026-04-01'
  and a.invoice_date <= concat('2026-04-30', ' 23:59:59')
  and a.customer_code = '1001743';

select b.material_code,max(b.material_name) as material_name,sum(
    case
      when invoice_category = '蓝票' then cast(-b.no_fee_discount_amount as signed)
      when invoice_category = '红票' then -cast(-b.original_currency_amount as signed)
      else 0
    end
  ) as amount
from dmp_finance.invoicing_manage a join dmp_finance.delivery_detail b on a.invoicing_id = b.invoicing_id
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '#{['form']['startTime']}'
  and invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and customer_code in ('#{['session']['company_nos']}')
group by b.material_code order by amount desc

select * from delivery_detail where invoicing_id = '2044976771586400258'
select * from invoicing_manage where invoicing_id = '2044976771586400258';

select
  b.material_code as material_code,b.material_name,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(b.cny_no_tax_amount+b.fee_discount_amount+b.no_fee_discount_amount as signed)
      when a.invoice_category = '红票' then -cast(b.cny_no_tax_amount+b.fee_discount_amount+b.no_fee_discount_amount as signed)
      else 0
    end
  ) as huikuan,
    sum(
    case
      when a.invoice_category = '蓝票' then cast(b.quantity as signed)
      when a.invoice_category = '红票' then -cast(b.quantity as signed)
      else 0
    end
  ) as tai
from dmp_finance.invoicing_manage a
inner join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '#{['form']['startTime']}'
  and a.invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and a.customer_code = '#{['form']['companyNo']}'
group by b.material_code order by huikuan desc

select
  b.material_code as material_code,
  b.material_name,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(
        ifnull(b.cny_no_tax_amount, 0)
        + ifnull(b.fee_discount_amount, 0)
        + ifnull(b.no_fee_discount_amount, 0)
      as signed)
      when a.invoice_category = '红票' then -cast(
        ifnull(b.cny_no_tax_amount, 0)
        + ifnull(b.fee_discount_amount, 0)
        + ifnull(b.no_fee_discount_amount, 0)
      as signed)
      else 0
    end
  ) as huikuan,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(b.quantity as signed)
      when a.invoice_category = '红票' then -cast(b.quantity as signed)
      else 0
    end
  ) as tai
from dmp_finance.invoicing_manage a
inner join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '#{['form']['startTime']}'
  and a.invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and a.customer_code = '#{['form']['companyNo']}'
group by b.material_code, b.material_name
order by huikuan desc;


select sum(huikuan) from (
select
       sum(cast(ifnull(
                                     b.cny_no_tax_amount,
                                     0) + ifnull(
                                     b.fee_discount_amount,
                                     0) + ifnull(
                                     b.no_fee_discount_amount,
                                     0) as signed)
               ) as huikuan
from dmp_finance.invoicing_manage a
         inner join dmp_finance.delivery_detail b
                    on a.invoicing_id =
                       b.invoicing_id
where a.invoice_source not in
      ('ZDR1', 'ZCR1', 'CUT', 'DISCOUNT')
  and a.invoice_date >= '2026-04-01'
  and a.invoice_date <=
      concat('2026-04-30', ' 23:59:59')
  and a.customer_code = '1004574'
group by b.material_code
order by huikuan desc ) t;

select
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-04-01'
  and invoice_date <= concat('2026-04-30', ' 23:59:59')
  and customer_code = '1004574'
;

select b.* ,b.cny_no_tax_amount,b.fee_discount_amount,b.no_fee_discount_amount
from dmp_finance.invoicing_manage a
         inner join dmp_finance.delivery_detail b
                    on a.invoicing_id =
                       b.invoicing_id
where a.invoice_source not in
      ('ZDR1', 'ZCR1', 'CUT', 'DISCOUNT')
  and a.invoice_date >= '2026-04-01'
  and a.invoice_date <=
      concat('2026-04-30', ' 23:59:59')
  and a.customer_code = '1004574'；


select sum(huikuan) from (select a.invoicing_id,
                                 b.material_code,
                                 sum(
                                         case
                                             when a.invoice_category = '蓝票'
                                                 then
                                                 cast(ifnull(
                                                              b.original_currency_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.fee_discount_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.no_fee_discount_amount,
                                                              0) as signed)
                                             when a.invoice_category = '红票'
                                                 then
                                                 -cast(ifnull(
                                                               b.original_currency_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.fee_discount_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.no_fee_discount_amount,
                                                               0) as signed)
                                             else 0
                                             end
                                     ) as huikuan
                          from dmp_finance.invoicing_manage a
                                   inner join dmp_finance.delivery_detail b
                                              on a.invoicing_id =
                                                 b.invoicing_id
                          where a.invoice_source not in
                                ('ZDR1', 'ZCR1',
                                 'CUT',
                                 'DISCOUNT')
                            and a.invoice_date >= '2026-04-01'
                            and a.invoice_date <=
                                concat(
                                        '2026-04-30',
                                        ' 23:59:59')
                            and a.customer_code = '1004574') t;

select b.material_code,max(b.material_name) as material_name,
       sum(
                                         case
                                             when a.invoice_category = '蓝票'
                                                 then
                                                 cast(ifnull(
                                                              b.original_currency_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.fee_discount_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.no_fee_discount_amount,
                                                              0) as signed)
                                             when a.invoice_category = '红票'
                                                 then
                                                 -cast(ifnull(
                                                               b.original_currency_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.fee_discount_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.no_fee_discount_amount,
                                                               0) as signed)
                                             else 0
                                             end
                                     ) as amount
from dmp_finance.invoicing_manage a join dmp_finance.delivery_detail b on a.invoicing_id = b.invoicing_id
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '#{['form']['startTime']}'
  and invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and customer_code in ('#{['session']['company_nos']}')
group by b.material_code order by amount desc;


select
  b.material_code as material_code,
  b.material_name,
  sum(
                                         case
                                             when a.invoice_category = '蓝票'
                                                 then
                                                 cast(ifnull(
                                                              b.original_currency_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.fee_discount_amount,
                                                              0)
                                                     +
                                                      ifnull(
                                                              b.no_fee_discount_amount,
                                                              0) as signed)
                                             when a.invoice_category = '红票'
                                                 then
                                                 -cast(ifnull(
                                                               b.original_currency_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.fee_discount_amount,
                                                               0)
                                                     +
                                                       ifnull(
                                                               b.no_fee_discount_amount,
                                                               0) as signed)
                                             else 0
                                             end
                                     ) as huikuan,
  sum(
    case
      when a.invoice_category = '蓝票' then cast(b.quantity as signed)
      when a.invoice_category = '红票' then -cast(b.quantity as signed)
      else 0
    end
  ) as tai
from dmp_finance.invoicing_manage a
inner join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '#{['form']['startTime']}'
  and a.invoice_date <= concat('#{['form']['endTime']}', ' 23:59:59')
  and a.customer_code = '#{['form']['companyNo']}'
group by b.material_code, b.material_name
order by huikuan desc;

select
  date_format(invoice_date, '%Y-%m') as month,
  sum(
    case
      when invoice_category = '蓝票' then cast(invoice_amount as signed)
      when invoice_category = '红票' then -cast(invoice_amount as signed)
      else 0
    end
  ) as huikuan
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2026-01-01'
  and invoice_date <= concat('2026-04-27', ' 23:59:59')
  and customer_code = '-'
group by date_format(invoice_date, '%Y-%m');