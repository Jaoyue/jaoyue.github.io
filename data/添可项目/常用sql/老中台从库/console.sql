select sum(target) from (select distributor_code  company_no,
                                sum(sales_amount) target
                         from `platform-dist`.dist_sales_target_day_detail
                         where target_date >=
                               UNIX_TIMESTAMP('2026-04-01') *
                               1000
                           AND target_date <=
                               (UNIX_TIMESTAMP('2026-04-30') *
                                1000 + 86399999)
                           and distributor_code in
                               (1000049, 3000182,
                                8600000002,
                                1003660, 1000034,
                                1001693, 1004217,
                                1001144, 1001755,
                                1000058, 1002311,
                                1002665, 1004059,
                                1004121, 1001307,
                                1001280,
                                3000450028,
                                1001763, 1002287,
                                1000830, 1002285,
                                1002656, 1001255,
                                1001719, 1001705,
                                1004120, 1000132,
                                1000804, 3000100,
                                1001510, 1002280,
                                1002360, 1001381,
                                1001128, 1002739,
                                1004024, 1001697,
                                1001245, 1000111,
                                1001309, 1000109,
                                1000198, 1001147,
                                1000112, 3000215,
                                1001581, 1001162,
                                1002663, 1002684,
                                1002718, 1004350,
                                1001709, 1002508,
                                1002715, 1001222,
                                1000105, 1002315,
                                1003669, 1003683,
                                1001149, 1002616,
                                1002666, 1004232,
                                1000101,
                                3000162001,
                                1001516, 1001744,
                                1000000, 1004134,
                                1004423, 1004394,
                                1004574, 1004126,
                                1004600, 1002303,
                                2000063, 3008550,
                                1002710, 1004645,
                                1002664, 3008787,
                                1001528, 1001201,
                                1001527, 1000903,
                                1001278, 1000920,
                                1001683, 1000131,
                                1001429, 1000837,
                                1000080, 1000885,
                                1001243, 3000104,
                                1001534, 1001497,
                                1001679, 1000461,
                                1001769, 1001594,
                                1001686, 1002321,
                                1001711, 1002516,
                                1002513, 1001624,
                                1002611, 1002526,
                                1001743, 1001371,
                                1002716, 1002789,
                                1003601, 1003672,
                                1003678, 1004064,
                                1000046, 1004075,
                                1001583, 502491,
                                1004149, 1004259,
                                1004245, 1004286,
                                1004297, 1001296,
                                1004371, 1004719,
                                1004773, 1004795,
                                1004846, 3008502,
                                3008501, 3000391,
                                3000372, 3000400,
                                1004869, 1001677,
                                1004888, 1004916,
                                1001185, 1001680,
                                1004857, 1000068,
                                1004855, 1004033,
                                1001695)
                         group by distributor_code) t;


select org_id,count(customer_code) from `platform-store`.sp_base_organization_customer where delete_flag = 0 and org_id in
(select id from `platform-store`.sp_base_organization where delete_flag = 0 and parent_org_id = 3) group by org_id;

select org_id,customer_code from `platform-store`.sp_base_organization_customer where delete_flag = 0 and org_id in
(select id from `platform-store`.sp_base_organization where delete_flag = 0 and parent_org_id = 3);

select d.distributor_name,d.distributor_code,FROM_UNIXTIME(d.create_time/1000,'%Y-%m-%d') create_date,o.org_name
from `platform-dist`.dist_distributor d
       left  join `platform-store`.sp_base_organization o
              on d.org_id = o.id
where d.distributor_code = '1004574';
select * from `platform-dist`.dist_distributor where distributor_code = '1004574';
select * from sp_store_promotion_product_price;