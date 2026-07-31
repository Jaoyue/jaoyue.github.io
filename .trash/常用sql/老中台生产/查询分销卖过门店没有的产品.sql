select distinct material_no from
(select distinct material_no from dist_ship_sales_order_item i join dist_ship_sales_order o on i.sales_order_no = o.sales_order_no where
 o.distributor_code in (select customer_code from `platform-store`.sp_base_organization_customer) and o.order_time >= 1735660800000
union all
select distinct material_no from dist_ship_receive_refund_order_item i join dist_ship_receive_refund_order o on i.receive_refund_order_no = o.receive_refund_order_no
where o.distributor_code in (select customer_code from `platform-store`.sp_base_organization_customer)  and o.order_time >= 1735660800000                           ) t where material_no not in
                                                                        (select distinct material_no from `platform-store`.sp_product)