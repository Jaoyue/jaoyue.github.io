select * from task_schedule_job;
select * from task_instruction;
select * from database_config;

INSERT INTO dbu_monitor.database_config (id,
                                         db_name,
                                         db_url,
                                         db_username,
                                         db_password,
                                         db_driver,
                                         create_by,
                                         create_time,
                                         update_by,
                                         update_time,
                                         is_deleted,
                                         version)
VALUES (4, '老中台报表',
        'jdbc:mysql://10.108.224.107:3306',
        'storerptadmin',
        'L9g6jrFI3Aq2K3dQvhm7lhGlchBo/CX1oqy3Q+ZnW9dGIQ==',
        'com.mysql.cj.jdbc.Driver', 'system',
        '2026-03-05 11:05:46', 'system',
        '2026-03-05 11:05:46', 0, 0);
