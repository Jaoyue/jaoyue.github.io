select customer_code,sum(invoice_amount) from invoicing_manage where invoice_date >= '2026-01-01' and invoice_date <= concat('2026-01-27',' 23:59:59') and customer_code in ('1000034','1000046','1000049','1000058','1000109','1000111','1000112','1000131','1000132','1000198','1000804','1000830','1000885','1000898','1001128','1001144','1001147','1001162','1001222','1001245','1001255','1001278','1001280','1001307','1001309','1001371','1001381','1001497','1001510','1001533','1001534','1001581','1001583','1001594','1001624','1001683','1001693','1001697','1001705','1001707','1001709','1001711','1001719','1001755','1001763','1001769','1002280','1002282','1002285','1002287','1002311','1002360','1002508','1002516','1002608','1002656','1002663','1002665','1002667','1002684','1002714','1002715','1002716','1002717','1002718','1002739','1002789','1003601','1003660','1003672','1003678','1004024','1004027','1004033','1004059','1004064','1004075','1004093','1004120','1004121','1004131','1004217','1004245','1004259','1004286','1004297','1004298','1004350','1004371','3000100','3000104','3000182','3000215','3000372','3000391','3000400','3000450028','3008501','3008502','502491') group by customer_code

select * from invoicing_manage where invoice_code = 'FP260100493874';


SELECT *
FROM invoicing_manage_his
WHERE invoice_code = 'FP260100493874'
LIMIT 1;

select
  b.material_code,
  max(b.material_name) as material_name,
  sum(cny_tax_price) amount
from dmp_finance.invoicing_manage a
join dmp_finance.delivery_detail b on a.invoicing_id = b.invoicing_id
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= DATE_SUB('2025-02-01', INTERVAL 1 YEAR)
  and invoice_date <= DATE_SUB(concat('2026-02-28', ' 23:59:59'), INTERVAL 1 YEAR)
  and customer_code in ('1000049','1000920','1001371','1003660','1004001','1004127','3000182')
group by b.material_code
order by amount desc;
select
  a.customer_code,sum(invoice_amount) amount
from dmp_finance.invoicing_manage a
join dmp_finance.delivery_detail b on a.invoicing_id = b.invoicing_id
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= DATE_SUB('2025-02-01', INTERVAL 1 YEAR)
  and invoice_date <= DATE_SUB(concat('2026-02-28', ' 23:59:59'), INTERVAL 1 YEAR)
  and customer_code in ('1000049','1000920','1001371','1003660','1004001','1004127','3000182')
group by a.customer_code
order by amount desc;

select * from delivery_detail where invoicing_id in (
select
  invoicing_id
from dmp_finance.invoicing_manage
where
  invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and invoice_date >= '2025-02-01'
  and invoice_date <= concat('2026-02-28', ' 23:59:59')
  and customer_code in ('1000049','1000920','1001371','1003660','1004001','1004127','3000182')
group by customer_code);

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
group by b.material_code order by huikuan desc;

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
  and invoice_date >= '2026-02-01'
  and invoice_date <= '2026-02-28 23:59:59'
  and customer_code = '1000885'
group by customer_code;

select
  sum()
from dmp_finance.invoicing_manage a
inner join dmp_finance.delivery_detail b
    on a.invoicing_id = b.invoicing_id
where
  a.invoice_source not in ('ZDR1','ZCR1','CUT','DISCOUNT')
  and a.invoice_date >= '2026-02-01'
  and a.invoice_date <= '2026-02-28 23:59:59'
  and a.customer_code = '1000885';

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
  and customer_code = '1000903'
group by date_format(invoice_date, '%Y-%m')
