## 准备工作
下载 [redis v4.0.6](https://redis.io/download) 到 /softwares 目录
    

## 开始安装
1、添加用户及群组
```bash
groupadd redis
useradd -g redis -s /sbin/nologin redis
```

2、准备 redis 目录
```bash
mkdir -p /walkingtec/redis
mkdir -p /data/redis/logs
mkdir -p /data/redis/snapshoot
touch /data/redis/logs/redis.log
chown -R redis:redis /data/redis
chmod -R 755 /data/redis
```

3、安装
```bash
cd /softwares
tar xzf redis-4.0.6.tar.gz
cd /softwares/redis-4.0.6
make

mv /softwares/redis-4.0.6/src/redis-cli /walkingtec/redis/redis-cli
mv /softwares/redis-4.0.6/src/redis-server /walkingtec/redis/redis-server
mv /softwares/redis-4.0.6/src/redis-sentinel /walkingtec/redis/redis-sentinel
mv /softwares/redis-4.0.6/src/redis-check-rdb /walkingtec/redis/redis-check-rdb
mv /softwares/redis-4.0.6/src/redis-check-aof /walkingtec/redis/redis-check-aof
mv /softwares/redis-4.0.6/src/redis-benchmark /walkingtec/redis/redis-benchmark
cd /walkingtec/redis
```

4、配置 redis 配置文件
```bash
vi /walkingtec/redis/redis.conf
```

5、添加 redis 启动脚本
```bash
# 先添加启动脚本
vi /etc/init.d/redis
# 增加服务
chmod 755 /etc/init.d/redis
################################################################################
```

6、设置在开机启动
```bash
chkconfig --add redis
chkconfig --level 345 redis on
```

7、运行时修改环境配置 CONFIG SET
```bash
config set tcp-keepalive 60
```

8、其他
```
高性能网站架构设计之缓存篇（5）- Redis 集群（上）
http://www.cnblogs.com/zhaoguihua/p/redis-005.html
锋利的Redis
http://www.dedecms.com/knowledge/data-base/nosql/2012/0820/9147.html

http://blog.csdn.net/xu470438000/article/details/42971091
```
