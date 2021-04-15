# 常用命令

## 显示连接数

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

## binlog

```sql
-- 显示日志
show master logs;

-- 删除10天前的MySQL binlog日志,附录2有关于PURGE MASTER LOGS手动删除用法及示例
PURGE MASTER LOGS BEFORE DATE_SUB(CURRENT_DATE, INTERVAL 10 DAY);

```
