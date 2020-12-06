# 安装Redis

```bash

# 拉取最新的官方 redis 镜像
docker pull redis:6.0.5-alpine

mkdir -p /Users/vito/data/redis/data/data/snapshoot
mkdir -p /Users/vito/data/redis/data/data/logs
mkdir -p /Users/vito/data/redis/data/conf

docker stop redis-master
docker rm redis-master
docker run --name redis-master \
-e "TZ=Asia/Shanghai" \
-p 7001:6379 \
-v /Users/vito/data/redis/data/conf:/usr/local/etc/redis/ \
-v /Users/vito/data/redis/data/data:/data \
-d redis:6.0.5-alpine \
/usr/local/etc/redis/redis.conf

```
