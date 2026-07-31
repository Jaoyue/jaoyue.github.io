select d.distributor_name,d.distributor_code,FROM_UNIXTIME(d.create_time/1000,'%Y-%m-%d') create_date,o.org_name
from `platform-dist`.dist_distributor d
         join `platform-store`.sp_base_organization o
              on d.org_id = o.id
where d.distributor_code = '1000903';

select sum(i.inventory_quantity) quantity,sum(p.market_status = 'LISTED'),sum(p.orientation = 'STRUCTURAL') from `platform-dist`.dist_inventory i left join `platform-store`.sp_product p on i.material_no = p.material_no
where i.distributor_code = '1000903';

select
  sum(i.inventory_quantity) as total_quantity,
  sum(case when p.market_status = 'LISTED' then i.inventory_quantity else 0 end) as listed_quantity,
  sum(case when p.orientation = 'STRUCTURAL' then i.inventory_quantity else 0 end) as structural_quantity
from `platform-dist`.dist_inventory i
left join `platform-store`.sp_product p
  on i.material_no = p.material_no
where i.distributor_code = '1000903'