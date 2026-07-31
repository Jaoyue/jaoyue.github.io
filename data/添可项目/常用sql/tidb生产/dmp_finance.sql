# feeAscription
SELECT
    TABLE_NAME AS 表名,
    TABLE_COMMENT AS 表注释
FROM
    information_schema.TABLES
WHERE
    TABLE_SCHEMA = 'dmp_finance' -- 你的数据库名
    AND TABLE_TYPE = 'BASE TABLE' -- 只查普通表，排除视图
ORDER BY
    TABLE_NAME;

select * from fee_ascription_line where customer_code = '9004984';
select * from fee_ascription where fee_asc_id = '1864603541174169602';
select * from fee_ascription where fee_asc_id = '1864603539794243585';