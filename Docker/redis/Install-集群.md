# Redis集群

- 主从备份（冷备）： 主要用于提高系统抵抗能力，防止数据丢失；
- 读写分离： 读远大于写操作的场景；
- 纵向扩展/分片： 读写操作几乎相同/写操作远大于读操作的，且单机已经无法支撑系统业务的应进行分片处理。

缓存集群解决什么问题：

1. 提高系统吞吐量（分片提高写吞吐量，读写分离提高读吞吐量）
1. 提高系统奔溃的抵抗能力（通过 replication 降低/防止当实例宕机时数据丢失的概率）
1. 增加缓存系统的存储能力（单实例的内存有限，通过多实例集群可以大大增加总内存）

缓存集群遇到的问题：

1. replication 复制数据延迟
1. 读取到过期数据
1. 从节点故障

## 主从模式

一般都是 `1主1从`，应用层主要是用主节点，从节点作为备份，结合 AOF 持久化模式可以增强 Redis 对于系统奔溃的抵抗能力。

如果主服务器宕机，可以将从服务器修改为主服务器，抑或启用一台新的主服务器，并将从服务器的数据还原到主服务器上，然后将从服务器配置的主服务器

`ip:port` 切换成新的 `ip:port` 即可，然后更改应用层的 redis 的 `ip:port` 即可。

亦可做为 `读写分离模式` 提高 redis 集群的吞吐量。

```uml
主从链
                                    --------
                                   | master |
                              _.-`` -------- ''-._
                         _.-``         |          ''-._
                     --------      --------      --------
                    | slave1 |    | slave2 |    | slave3 |
               _.-`` --------      --------      --------  ''-._
          _.-``    _.-``     _.-``         ''-._       ''-._     ''-._
 ----------   ----------   ----------   ----------   ----------   ----------
| slave1-1 | | slave1-2 | | slave2-1 | | slave2-2 | | slave3-1 | | slave3-2 |
 ----------   ----------   ----------   ----------   ----------   ----------
```

```bash

# 拉取最新的官方 redis 镜像
docker pull redis:6.0.5-alpine

mkdir -p /Users/vito/data/docker/redis-master/data/snapshoot
mkdir -p /Users/vito/data/docker/redis-master/data/logs
mkdir -p /Users/vito/data/docker/redis-master/conf
mkdir -p /Users/vito/data/docker/redis-slave1/data/snapshoot
mkdir -p /Users/vito/data/docker/redis-slave1/data/logs
mkdir -p /Users/vito/data/docker/redis-slave1/conf
mkdir -p /Users/vito/data/docker/redis-slave2/data/snapshoot
mkdir -p /Users/vito/data/docker/redis-slave2/data/logs
mkdir -p /Users/vito/data/docker/redis-slave2/conf

# master
docker stop redis-master
docker rm redis-master
docker run --name redis-master \
-e "TZ=Asia/Shanghai" \
-p 7101:6379 \
-v /Users/vito/data/docker/redis-master/conf:/usr/local/etc/redis/ \
-v /Users/vito/data/docker/redis-master/data:/data \
-d redis:6.0.5-alpine \
/usr/local/etc/redis/redis.conf

# slave1
docker stop redis-slave1
docker rm redis-slave1
docker run --name redis-slave1 \
-e "TZ=Asia/Shanghai" \
-p 7102:6379 \
-v /Users/vito/data/docker/redis-slave1/conf:/usr/local/etc/redis/ \
-v /Users/vito/data/docker/redis-slave1/data:/data \
-d redis:6.0.5-alpine \
/usr/local/etc/redis/redis.conf

# slave2
docker stop redis-slave2
docker rm redis-slave2
docker run --name redis-slave2 \
-e "TZ=Asia/Shanghai" \
-p 7103:6379 \
-v /Users/vito/data/docker/redis-slave2/conf:/usr/local/etc/redis/ \
-v /Users/vito/data/docker/redis-slave2/data:/data \
-d redis:6.0.5-alpine \
/usr/local/etc/redis/redis.conf

```

### master 宕机切换

```bash

## slave下保存镜像
save

## 将slave保存的镜像文件复制到新的master机器上

## 然后启动新的master

docker stop redis-master1
docker rm redis-master1
docker run --name redis-master1 \
-e "TZ=Asia/Shanghai" \
-p 7100:6379 \
-v /Users/vito/data/docker/redis-master1/conf:/usr/local/etc/redis/ \
-v /Users/vito/data/docker/redis-master1/data:/data \
-d redis:6.0.5-alpine \
/usr/local/etc/redis/redis.conf

## 最后修改 slave 的 replication 配置，重启 slave 机器即可

```

## 一主多从 sentinel 哨兵模式

工作原理:

1.用户链接时先通过哨兵获取主机Master的信息

2.获取Master的链接后实现redis的操作(set/get)

3.当master出现宕机时,哨兵的心跳检测发现主机长时间没有响应.这时哨兵会进行推选.推选出新的主机完成任务.

4.当新的主机出现时,其余的全部机器都充当该主机的从机

这就有一个问题，就是添加哨兵以后，所有的请求都会经过哨兵询问当前的主服务器是谁，所以如果哨兵部在主服务器上面的话可能会增加服务器的压力，所以最好是将哨兵单独放在一个服务器上面。以分解压力。然后可能还有人担心哨兵服务器宕机了怎么办啊，首先哨兵服务器宕机的可能性很小，然后是如果哨兵服务器宕机了，使用人工干预重启即可，就会导致主从服务器监控的暂时不可用，不影响主从服务器的正常运行。