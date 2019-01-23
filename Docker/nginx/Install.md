
# 拉取镜像

```bash
# 拉取最新的官方 nginx 镜像
docker pull nginx:1.15.8

# 创建目录
mkdir -p /Users/vito/data/nginx/logs

# 启动 nginx 容器
docker run \
--name nginx \
-p 80:80 \
-v /Users/vito/data/nginx/conf:/etc/nginx \
-v /Users/vito/data/nginx/html:/usr/share/nginx/html \
-v /Users/vito/data/nginx/logs:/nginx/logs \
-d \
nginx:1.15.8

# 复制 html 目录
docker cp nginx:/usr/share/nginx/html /Users/vito/data/nginx
# 复制配置目录
docker cp nginx:/etc/nginx /Users/vito/data/nginx
mv /Users/vito/data/nginx/nginx /Users/vito/data/nginx/conf

# nginx 重新加载配置文件
docker exec -it nginx /etc/init.d/nginx reload

```
