## 开始安装 memcached
```bash
yum install memcached
```

## 修改 memcached 配置
```bash
vi /etc/sysconfig/memcached
# 默认配置
##############################################
PORT="7003"
USER="memcached"
MAXCONN="1024"
CACHESIZE="4096"
OPTIONS=""
##############################################
```

## 检测 memcached
```bash
memcached-tool 127.0.0.1:7003 stats
```

## 设置开机启动
```bash
chkconfig --add memcached
chkconfig --level 345 memcached on
```



















```bash
```