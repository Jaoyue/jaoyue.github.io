select distinct c.order_no,c.distributor_code,c.distributor_name,i.material_no,i.product_name,
                r.sn,if(r.`status`=0,'正常','异常') 状态,r.error_dis_code,r.error_dis_name,snt.sales_order_no '销售单',
                snr.refund_order_no '退货单',snr.order_no '退货单对应销售单'
from dist_inventory_check c
join dist_inventory_check_item i on c.order_no = i.inventory_check_order_no
join dist_sn_record r on c.order_no = r.order_no and r.material_no = i.material_no
left join
(select sl.sn,sl.sales_order_no from `platform-store`.sp_sn_list sl where sl.sn in
                                             (select distinct r.sn from dist_inventory_check c
join dist_inventory_check_item i on c.order_no = i.inventory_check_order_no
join dist_sn_record r on c.order_no = r.order_no and r.material_no = i.material_no
where c.create_time >= 1767542400000 and c.`status` = 'WAIT_MANAGER_AUDIT')) snt on r.sn = snt.sn
left join
(select sl.sn,sl.refund_order_no,sl.order_no from `platform-store`.sp_refund_sn_list sl where sl.sn in
                                             (select distinct r.sn from dist_inventory_check c
join dist_inventory_check_item i on c.order_no = i.inventory_check_order_no
join dist_sn_record r on c.order_no = r.order_no and r.material_no = i.material_no
where c.create_time >= 1767542400000 and c.`status` = 'WAIT_MANAGER_AUDIT')) snr on r.sn = snr.sn
where c.create_time >= 1767542400000 and c.`status` = 'WAIT_MANAGER_AUDIT';



select distinct c.order_no,c.distributor_code,c.distributor_name,i.material_no,i.product_name,
                r.sn,if(r.`status`=0,'正常','异常') 状态,r.error_dis_code,r.error_dis_name
from dist_inventory_check c
join dist_inventory_check_item i on c.order_no = i.inventory_check_order_no
join dist_sn_record r on c.order_no = r.order_no and r.material_no = i.material_no
where c.create_time >= 1767542400000 and c.`status` = 'WAIT_MANAGER_AUDIT';



select * from dist_inventory_check where order_no = '541752661954965024165';

select * from dist_sn_record where sn = 'TXWBUMXUH3774';