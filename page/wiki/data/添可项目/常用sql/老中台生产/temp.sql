select * from `temp`.temp_slow_sql where exec_time >= '2026-05-10 00:00:00';
select * from `temp`.temp_slow_sql where sql_text = 'delete from sp_store_promotion_product_price';

