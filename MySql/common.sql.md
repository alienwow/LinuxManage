# 显示连接数
```sql
-- 显示连接数
show status like 'Threads%';

-- 显示最大链接数
show variables like '%max_connections%';
show variables like '%max_connect_errors%';

-- 显示连接数
show variables like '%connect%';

-- 设置最大连接数
set GLOBAL max_connections=2000;
set GLOBAL max_connect_errors=1000;

show FULL processlist;

```