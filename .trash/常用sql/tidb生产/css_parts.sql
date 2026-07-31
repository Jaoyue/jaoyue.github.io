select *
from parts_quality_inspection_header group by parts_sn having count(*) > 1;

select * from parts_quality_inspection_header where parts_sn = 'MB41316005D1X2248';
select * from parts_quality_inspection_header where delete_flag = 1;

select * from parts_quality_inspection_extend where quality_inspection_code = 'CSZJ260508000112';