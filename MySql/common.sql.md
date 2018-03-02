# 显示连接数
```sql
-- 显示连接数
show status like 'Threads%';

-- 显示最大链接数
show variables like '%max_connections%';

-- 显示连接数
show variables like '%connect%';
```