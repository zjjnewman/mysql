-- -- master
grant replication slave on *.* to 'jin'@'%' identified by '123';

-- -- 建立完主从后
create database mscopytest;

create table mstest 
(
    ms_id int not null auto_increment,
    ms_name char(50) not null,
    primary key (ms_id)
);



-- -- slave
change master to master_host='101.132.178.15',
master_user='jin',
master_password='123',
master_log_file='mysqlbin.000002',
master_log_pos=436;

-- -- mac下重启报错, 用设置界面来重启服务

