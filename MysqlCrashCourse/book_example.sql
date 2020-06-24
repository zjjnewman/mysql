use crash_course;

-- -- 空行说明：
-- -- 1.隔一行 同一小结
-- -- 2.隔二行 不同小结
-- -- 3.隔三行 不同章节



-- -- 15.2
-- -- 表联结示例
-- select vend_name, prod_name, prod_price
-- from vendors, products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;

-- -- 表联结 使用 join
-- select vend_name, prod_name, prod_price
-- from vendors join products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;


-- -- 15.2.2 内联结
-- -- 表联结测试博客 笛卡尔积 提到的jion
-- select vend_name, prod_name, prod_price
-- from vendors inner join products
-- on vendors.vend_id = products.vend_id;


-- -- 15.2.3 联结多个表
-- select cust_name, cust_contact
-- from productnotes, orders, orderitems
-- where productnotes.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num
-- and prod_id = 'TNT2';

-- -- 使用 内联结 inner join
-- select cust_name, cust_contact
-- from productnotes inner join orders inner join orderitems
-- on productnotes.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num
-- and prod_id = 'TNT2';



-- -- 16 创建高级联结
-- -- 16.2.1 自联结
-- -- binary 区分大小写，可用于建表，查表等
-- select prod_id, prod_name
-- from products
-- where vend_id = (
--     select vend_id
--     from products
--     where binary prod_id = 'DTNTR' 
-- );

-- -- 使用 表别名 做 自联结
-- select p1.prod_id, p1.prod_name
-- from products as p1, products as p2
-- where p1.vend_id = p2.vend_id
-- and p2.prod_id = 'DTNTR';

-- -- 使用 join 测试
-- select p1.prod_id, p1.prod_name
-- from products as p1 join products as p2
-- on p1.vend_id = p2.vend_id
-- where/*或者用and*/ p2.prod_id = 'DTNTR'


-- -- 16.2.2 自然联结


-- -- 16.2.3 外部联结
-- -- 内联结 inner join
-- select productnotes.cust_id, orders.order_num
-- from productnotes inner join orders
-- on productnotes.cust_id = orders.cust_id;

-- -- 外联结 left outer join
-- select productnotes.cust_id, orders.order_num
-- from productnotes left outer join orders
-- on productnotes.cust_id = orders.cust_id;

-- -- 外联结 right outer join
-- select productnotes.cust_id, orders.order_num
-- from productnotes right outer join orders
-- on productnotes.cust_id = orders.cust_id;


-- -- 16.3 使用带聚集函数的联结



-- -- 17 组合查询 union, union all



-- -- 18 全文本搜索
-- -- 18.2.2 进行全文本搜索
-- select note_text
-- from productnotes
-- where match(note_text) against('rabbit');

-- select note_text
-- from productnotes
-- where note_text like '%rabbit%';

-- select note_text, match(note_text) against('rabbit') as rank
-- from productnotes;

-- -- 18.2.3 查询扩展
-- select note_text
-- from productnotes
-- where match(note_text) against('anvils');

-- select note_text
-- from productnotes
-- where match(note_text) against('anvils' with query expansion);

-- -- 18.2.4 布尔文本搜索
-- select note_text
-- from productnotes
-- where match(note_text) against('heavy' in boolean mode);

-- select note_text
-- from productnotes
-- where match(note_text) against('+heavy -rope*' in boolean mode);

-- -- 个人测试innodb 是否加入全文搜索能力，更改productnotes表引擎
-- -- alter table productnotes engine = innodb;
-- -- show table status from crash_course;
-- -- show create table productnotes;
-- -- 结论：是



-- -- 19 插入数据
-- -- 19.2 插入完整的行
-- insert into productnotes
-- values(NULL,
-- 'Pep E. LaPew',
-- '100 Main Street',
-- 'Los Angeles',
-- 'CA',
-- '90046',
-- 'USA',
-- NULL,
-- NULL
-- )
-- select *
-- from productnotes;

-- -- 降低insert into 优先级用 insert low_priority into



-- -- 20 更新和删除数据
-- update productnotes
-- set cust_email = 'elmer@fudd.com'
-- where cust_id = 10005;

-- -- 测试引用完整性（15章）不允许删除与其他表有关联的行
-- delete from vendors
-- where vend_id = 1005;



-- -- 20.1.1 表创建基础
-- create table  if not exists products(id int);
-- show tables;
-- show warnings;



-- -- 22 使用视图
-- select distinct cust_name, cust_contact
-- from productnotes join orders join orderitems;
-- on productnotes.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num
-- and prod_id = 'TNT2'

-- -- 22.2.1 利用视图简化复杂的联结
-- create view productcustomers as
-- select cust_name, cust_contact, prod_id
-- from productnotes join orders join orderitems
-- on productnotes.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num;

-- select cust_name, cust_contact, prod_id
-- from productcustomers;

-- show create view productcustomers;



-- -- 23 存储过程
-- -- 23.3.4 使用参数
-- -- 创建存储过程
-- create procedure productpricing(
--     out pl decimal(8,2),
--     out ph decimal(8,2),
--     out pa decimal(8,2)
-- )
-- begin
--     select min(prod_price)
--     into pl
--     from products;
--     select max(prod_price)
--     into ph
--     from products;
--     select avg(prod_price)
--     into pa
--     from products;
-- end;

-- -- 使用存储过程
-- call productpricing(
--     @pricelow,
--     @pricehigh,
--     @priceaverage
-- );
-- select @pricelow, @pricehigh, @priceaverage;

-- -- 删除存储过程
-- drop procedure productpricing;



-- -- 24 使用游标
-- -- 24.2.1 创建游标

-- drop procedure processorders;
-- create procedure processorders()
-- begin
--     declare o int;

--     declare ordernumbers cursor
--     for
--     select order_num from orders;
    
--     -- -- 打开游标
--     open ordernumbers;

--     get order number
--     fetch ordernumbers into o;

--     close ordernumbers;
-- end;



-- -- 26 管理事务处理
-- -- 26.2.1 使用rollback
-- select * from productnotes;
-- start transaction;
-- delete from productnotes;
-- select * from productnotes;
-- rollback;  
-- select * from productnotes;



-- -- 27 全球化和本地化
-- -- 27.2 使用字符集和校对顺序

-- -- 查看支持的字符集
-- show character set;

-- -- 查看支持校对的字符集
-- show collation

-- -- 确定所用的字符集和校对
-- show variables like 'character%';
-- show variables like 'collation%';





-- -- 28 安全管理
-- -- 测试
-- select host, user, password_expired, password_last_changed, password_lifetime
-- from mysql.user;
-- select * from mysql.user;
-- select * from sys.session;
-- use mysql;
-- select * from mysql.sys;ase




-- -- 29 数据库维护
-- analyze table productnotes;
check table orders, orderitems;