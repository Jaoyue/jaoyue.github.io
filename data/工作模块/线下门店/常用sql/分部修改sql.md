```plsql
-- 修改深圳、东莞、惠州、河源、梅州、潮州、揭阳、汕头、汕尾 网点为深圳分部
update `platform-store`.sp_store_workspace set sales_region = 'SHENZHEN' where city_id in (select area_id from `platform-admin`.sys_area where area_name in ('深圳市','东莞市','惠州市','河源市','梅州市','潮州市','揭阳市','汕头市','汕尾市')) and sales_region = 'HUANAN'; 
-- 修改海南省 网点为南宁分部
update `platform-store`.sp_store_workspace set sales_region = 'NANNING' where province_id in (select area_id from `platform-admin`.sys_area where area_name in ('海南省')) and sales_region = 'HUANAN'; 
-- 同步网点分部到门店
update `platform-store`.sp_store_info st,`platform-store`.sp_store_workspace sw set st.sales_region = sw.sales_region,st.sales_area = sw.sales_area
where st.workspace_id = sw.id and st.id in(
select id from(
select i.id,i.sales_region r1,i.sales_area a1,w.sales_region r2,w.sales_area a2 from `platform-store`.sp_store_info i join `platform-store`.sp_store_workspace w
on i.workspace_id = w.id
) t where t.r1 <> t.r2 or t.a1 <> t.a2
);
-- 修改市占 海南为南宁分部
update sp_dim_area_regional set SALES_REGION = '南宁分部' where ID = 'C3EDF3EB03DD40149101936C5138494A' and PROVINCE = '海南';
-- 修改深圳、东莞、惠州、河源、梅州、潮州、揭阳、汕头、汕尾 为深圳分部
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ01', '南部大区', '深圳分部', '广东', '深圳市', '440000', '440300', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ02', '南部大区', '深圳分部', '广东', '汕头市', '440000', '440500', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ03', '南部大区', '深圳分部', '广东', '惠州市', '440000', '441300', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ04', '南部大区', '深圳分部', '广东', '梅州市', '440000', '441400', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ05', '南部大区', '深圳分部', '广东', '汕尾市', '440000', '441500', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ06', '南部大区', '深圳分部', '广东', '河源市', '440000', '441600', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ07', '南部大区', '深圳分部', '广东', '东莞市', '440000', '441900', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ08', '南部大区', '深圳分部', '广东', '潮州市', '440000', '445100', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089SZ09', '南部大区', '深圳分部', '广东', '揭阳市', '440000', '445200', 'SYSTEM', '2024-02-27 09:28:35.000');
-- 修改广州、佛山、中山、珠海、清远、韶关、肇庆、茂名、阳江、湛江、云浮、江门 为广州分部
update sp_dim_area_regional set CITY = '广州市' and CITY_CODE = '440100' WHERE ID = '3EEC7C9FE04A408EAB3AA78120894F77';
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ02', '南部大区', '广州分部', '广东', '韶关市', '440000', '440200', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ03', '南部大区', '广州分部', '广东', '珠海市', '440000', '440400', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ04', '南部大区', '广州分部', '广东', '佛山市', '440000', '440600', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ05', '南部大区', '广州分部', '广东', '江门市', '440000', '440700', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ06', '南部大区', '广州分部', '广东', '湛江市', '440000', '440800', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ07', '南部大区', '广州分部', '广东', '茂名市', '440000', '440900', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ08', '南部大区', '广州分部', '广东', '肇庆市', '440000', '441200', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ09', '南部大区', '广州分部', '广东', '阳江市', '440000', '441700', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ10', '南部大区', '广州分部', '广东', '清远市', '440000', '441800', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ11', '南部大区', '广州分部', '广东', '中山市', '440000', '442000', 'SYSTEM', '2024-02-27 09:28:35.000');
INSERT INTO `sp_dim_area_regional`(`ID`, `REGIONAL`, `SALES_REGION`, `PROVINCE`, `CITY`, `PROVINCE_CODE`, `CITY_CODE`, `CREATE`, `CREATE_TIME`) VALUES ('3EEC7C9FE04A408EAB3AA7812089GZ12', '南部大区', '广州分部', '广东', '云浮市', '440000', '445300', 'SYSTEM', '2024-02-27 09:28:35.000');



select * from sp_dim_area_regional where ID = '3EEC7C9FE04A408EAB3AA78120894F77';
select * from sp_dim_area_regional where SALES_REGION = '广州分部'
select * from sp_dim_area_regional where SALES_REGION = '南宁分部'

select * from sp_store_workspace where province_id in (select area_id from `platform-admin`.sys_area where area_name in ('海南省'))  and sales_region = 'HUANAN'; 
select * from sp_store_workspace where city_id in (select area_id from `platform-admin`.sys_area where area_name in ('深圳市','东莞市','惠州市','河源市','梅州市','潮州市','揭阳市','汕头市','汕尾市'))  and sales_region = 'HUANAN'; 
select * from sp_store_workspace where city_id in (select area_id from `platform-admin`.sys_area where area_name in ('广州市','佛山市','中山市','珠海市','清远市','韶关市','肇庆市','茂名市','阳江市','湛江市','云浮市','江门市'))  and sales_region = 'HUANAN'; 
select * from `platform-admin`.sys_area where area_name in ('深圳市','东莞市','惠州市','河源市','梅州市','潮州市','揭阳市','汕头市','汕尾市')
select * from `platform-admin`.sys_area where area_name in ('广州市','佛山市','中山市','珠海市','清远市','韶关市','肇庆市','茂名市','阳江市','湛江市','云浮市','江门市')


```

