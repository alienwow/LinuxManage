
# 拉取镜像

```bash
# 拉取最新的官方 nginx 镜像
docker pull nginx:1.15.8

# 创建目录
mkdir -p /data/docker/container/nginx/logs

# 启动 nginx 容器
docker run \
--name nginx \
-p 80:80 \
-p 443:443 \
--link meijiapi:meijiapi \
--link meiji:meiji \
-v /data/docker/container/nginx/conf:/etc/nginx \
-v /data/docker/container/nginx/html:/etc/nginx/html/ \
-v /data/docker/container/nginx/logs:/nginx/logs \
-d \
nginx:1.15.8


docker run \
--name nginx \
-p 80:80 \
-p 443:443 \
-d \
nginx:1.15.8

# 复制 html 目录
docker cp nginx:/usr/share/nginx/html /data/docker/container/nginx
# 复制配置目录
docker cp nginx:/etc/nginx /data/docker/container/nginx
mv /data/docker/container/nginx/nginx /data/docker/container/nginx/conf
mv /data/docker/container/nginx/conf/nginx /data/docker/container/nginx/conf

# nginx 重新加载配置文件
docker exec -it nginx /etc/init.d/nginx reload

```

docker run \
--name nginx \
-p 80:80 \
-p 443:443 \
-v /Users/vito/data/nginx/conf:/etc/nginx \
-v /Users/vito/data/nginx/html:/etc/nginx/html/ \
-v /Users/vito/data/nginx/logs:/nginx/logs \
-v ~/repos/RongCloud/rce-admin:/nginx/www/rceadmin \
-v ~/repos/RongCloud/desktop-client:/nginx/www/rceclient \
-v /Users/vito/repos/Vito/MeiJi/src/MeiJi/wwwroot/images:/nginx/www/meijiimages \
-d \
nginx:1.15.8

docker stop nginx
docker rm nginx
docker run \
--name nginx \
-p 80:80 \
-p 443:443 \
-v /Users/vito/data/nginx/conf:/etc/nginx \
-v /Users/vito/data/nginx/html:/usr/share/nginx/html \
-v /Users/vito/data/nginx/logs:/nginx/logs \
-v ~/repos/RongCloud/rce-admin:/nginx/www/rceadmin \
-v ~/repos/RongCloud/desktop-client:/nginx/www/rceclient \
-v /Users/vito/repos/Vito/MeiJi/src/MeiJi/wwwroot/images:/nginx/www/meijiimages \
-v /Users/vito/repos/GitHub/three.js/examples:/nginx/www/3d \
-d \
nginx:1.15.8