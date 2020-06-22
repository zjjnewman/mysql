use crash_course;
-- 15.2
-- 表联结示例
-- select vend_name, prod_name, prod_price
-- from vendors, products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;

-- 15.2
-- 表联结示例
-- select vend_name, prod_name, prod_price
-- from vendors join products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;

-- 15.2.2 内部联结
-- 表联结测试博客 笛卡尔积 提到的jion
-- select vend_name, prod_name, prod_price
-- from vendors inner join products
-- on vendors.vend_id = products.vend_id;

-- 15.2.3 联结多个表
-- select cust_name, cust_contact
-- from customers, orders, orderitems
-- where customers.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num
-- and prod_id = 'TNT2';
-- -- ------------
-- select cust_name, cust_contact
-- from customers inner join orders inner join orderitems
-- on customers.cust_id = orders.cust_id
-- and orderitems.order_num = orders.order_num
-- and prod_id = 'TNT2';




-- 16.2.1 自连接
-- binary 区分大小写，可用于建表，查表等
-- select prod_id, prod_name
-- from products
-- where vend_id = (
--     select vend_id
--     from products
--     where binary prod_id = 'DTNTR' 
-- );
-- -- -----------------
