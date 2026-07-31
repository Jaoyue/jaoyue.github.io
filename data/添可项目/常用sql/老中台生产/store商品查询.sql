
select id 序号,material_no 物料号,name 产品名称,
case
when product_classification = 'QXJ' then '洗地机'
when product_classification = 'CFJ' then '吹护机'
when product_classification = 'MYY' then '美眼仪'
when product_classification = 'MFS' then '美发梳'
when product_classification = 'LLJ' then '料理机'
when product_classification = 'JRJ' then '净热一体机'
when product_classification = 'XCQ' then '吸尘器'
when product_classification = 'OTHER' then '其他'
else '' end 标签,
case
when delete_flag = 0 then '上市'
when delete_flag = 2 then '待上市'
when delete_flag = 3 then '清理'
when delete_flag = -1 then '下架'
when delete_flag = 4 then '下市'
when delete_flag = 1 then '禁用'
else '' end 状态,sort_num 排序
 from sp_product