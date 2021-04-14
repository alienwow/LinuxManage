# Install

## 安装 skywalking-oap-server

```bash

mkdir -p /Users/vito/data/skywalking/data
mkdir -p /Users/vito/data/skywalking/config

#SkyWalking OAP Server, https://hub.docker.com/r/apache/skywalking-oap-server
docker pull apache/skywalking-oap-server:8.1.0-es7

# 存储 elasticsearch
docker stop skywalking-oap
docker rm skywalking-oap

docker run -d \
--name skywalking-oap \
--restart always \
-p 11800:11800 \
-p 12800:12800 \
-e "TZ=Asia/Shanghai" \
-e SW_STORAGE=elasticsearch7 \
-e SW_STORAGE_ES_CLUSTER_NODES=172.11.80.69:9201,172.11.80.69:9202,172.11.80.69:9203 \
-e SW_ES_USER=elastic \
-e SW_ES_PASSWORD="h\!I\!Nq5WQJdGM81HxTF*%B\$c\$kGQx&61" \
apache/skywalking-oap-server:8.1.0-es7



# 存储 elasticsearch
docker stop skywalking-oap1
docker rm skywalking-oap1

docker run -d \
--name skywalking-oap1 \
--restart always \
-p 12341:1234 \
-p 11801:11800 \
-p 12801:12800 \
-e "TZ=Asia/Shanghai" \
-e SW_STORAGE=elasticsearch7 \
-e SW_STORAGE_ES_CLUSTER_NODES=172.11.80.69:9201,172.11.80.69:9202,172.11.80.69:9203 \
-e SW_ES_USER=elastic \
-e SW_ES_PASSWORD="h\!I\!Nq5WQJdGM81HxTF*%B\$c\$kGQx&61" \
apache/skywalking-oap-server:8.1.0-es7



docker exec -it skywalking-oap bash

docker cp skywalking-oap:/skywalking/config /Users/vito/data/skywalking

```

## 安装 skywalking-ui

```bash

# SkyWalking UI, https://hub.docker.com/r/apache/skywalking-ui
docker pull apache/skywalking-ui:8.1.0

docker stop skywalking-ui
docker rm skywalking-ui

docker run -d \
--name skywalking-ui \
--restart always \
-p 8088:8080 \
-e "TZ=Asia/Shanghai" \
apache/skywalking-ui:8.1.0 \
--collector.ribbon.listOfServers=172.11.80.69:12800,172.11.80.69:12801 \
--security.user.admin.password=admin

```
