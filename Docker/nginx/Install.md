
## 拉取镜像
```bash
docker pull nginx
```

## 启动与停止容器
```bash
# 启动容器
# -d        后台运行
# -p        容器的 80 端口映射到 172.27.0.15:80
# --rm      容器停止运行后，自动删除容器文件
# --name    定义容器名字
docker container run \
-d \
-p 172.27.0.15:80:80 \
--rm \
--name vitoNginx \
nginx

# 停止容器
docker container stop vitoNginx
```

## 映射网页目录到本地
```bash

# --volume  将 /usr/share/nginx/html 映射到本地目录 /data/websites/www
docker container run \
-d \
-p 172.27.0.15:80:80 \
--rm \
--name vitoNginx \
--volume "/data/websites/www":/usr/share/nginx/html \
nginx

```

## 将 nginx 配置拷贝到本地目录，并映射
```bash
# 将 container 上 nginx 的配置拷贝到 /vito/nginx 配置
mkdir /vito
cd /vito
docker container cp vitoNginx:/etc/nginx .

docker container run \
-d \
-p 172.27.0.15:80:80 \
--rm \
--name vitoNginx \
--volume "/data/websites/www":/usr/share/nginx/html \
--volume "/vito/nginxConf/nginx":/etc/nginx \
nginx

# nginx 重新加载配置文件
docker exec -it vitoNginx /etc/init.d/nginx reload

```