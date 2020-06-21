-- 15.2
-- 表联结示例
-- use crash_course;
-- select vend_name, prod_name, prod_price
-- from vendors, products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;

-- 15.2
-- 表联结示例
-- use crash_course;
-- select vend_name, prod_name, prod_price
-- from vendors join products
-- where vendors.vend_id = products.vend_id
-- order by vend_name, prod_name;

-- 15.2
-- 表联结测试博客 笛卡尔积 提到的jion
-- use crash_course;
-- select vend_name, prod_name, prod_price
-- from vendors join products;


