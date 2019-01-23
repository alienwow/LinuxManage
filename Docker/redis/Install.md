# 安装MySQL

```bash

# 拉取最新的官方 redis 镜像
docker pull redis:5.0.3

mkdir -p /Users/vito/data/redis/data/snapshoot
mkdir -p /Users/vito/data/redis/data/logs
mkdir -p /Users/vito/data/redis/conf

# 启动 redis-server 容器
docker run --name redis -p 7001:6379 -v /Users/vito/data/redis/conf:/usr/local/etc/redis/  -v /Users/vito/data/redis/data:/data  -d redis:5.0.3 redis-server /usr/local/etc/redis/redis.conf

```