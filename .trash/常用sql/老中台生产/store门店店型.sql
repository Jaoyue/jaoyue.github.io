select store_no 门店编码,name 门店名称,shop_code 店型编码,
case
when delete_flag = 1 then '禁用'
when delete_flag = 0 then '启用'
when delete_flag = 2 then '待开业'
when delete_flag = 3 then '冻结'
else delete_flag end
 状态
from sp_store_info order by delete_flag
