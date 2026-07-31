select * from base_users ;
select * from base_person where person_name = '杨慧敏';
select * from base_person_job_stor where person_id = 562474;

select * from base_person where person_name = '冯彬彬';
select * from base_person where dept_name = '供应链系统部';
select * from base_person where dept_name = '供应链智能部';
select * from base_person where dept_name like '供应链%';

select p.person_name,p.person_number,p.dept_code,p.dept_name,o.org_name from base_person p join base_organization o on p.dept_code = o.org_code where p.dept_name <> o.org_name;
select * from base_organization where org_name = '供应链智能部'