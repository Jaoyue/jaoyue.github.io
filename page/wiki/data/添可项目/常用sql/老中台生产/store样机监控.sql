select r.store_no, r.material_no, sum(r.stock_amount) stock_amount, sum(r.stock) stock
from (select a.store_no, a.material_no, a.stock_amount, b.stock
      from sp_prototype_store_stock a,
           (select store_no, material_no, count(*) stock
            from sp_store_prototype_sn
            where delete_flag = 0
            group by store_no, material_no) b
      where a.store_no = b.store_no
        and a.material_no = b.material_no
      HAVING stock_amount <> stock
      union all
      select c.ex_store_no store_no, d.material_no material_no, d.amount stock_amount, 0 stock
      from sp_prototype_allot c
               join sp_prototype_allot_detail d on c.no = d.no
      where c.`status` = 4
        and c.type = 2
        and c.create_time > 1735660800000
      group by c.ex_store_no, d.material_no) r
GROUP BY r.store_no, r.material_no
HAVING stock_amount <> stock