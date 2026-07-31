select * from customer_info where customer_code in ('1004846','1003682');

select * from customer_info where customer_name = '添可智能苏宁自营旗舰店';
select * from customer_info where customer_code = '1000789';

select * from (
select h.customer_code,h.customer_name,h.customer_classify,h.status,l.*
from customer_info  h left join customer_account l  on  concat(h.customer_id,'') = concat(l.customer_id,'')
and l.delete_flag = 0

where
h.business_division = 'DOMESTIC'  and h.delete_flag = 0
-- and h.customer_id= 202208201709200287
)  aa
where  aa.payment_clause <>'立即到期'

and aa.status <> 'DISABLED'  and aa.customer_classify <> 'INTERIOR'
and aa.customer_code in ('3008857')
;
select * from customer_account where customer_id = '1988504166644490242'