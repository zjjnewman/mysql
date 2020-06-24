-- -- mysql高级，夏磊

-- -- 查看索引
--show index from orderitems;

-- -- 创建索引 []内部是可选项 unique代表唯一索引
create [unique] index [indexName] on table_name(column)