# Install

## docker 安装

```bash
mkdir -p /data/docker/container/skywalking/data
mkdir -p /data/docker/container/skywalking/config

# Base, https://hub.docker.com/r/apache/skywalking-base
docker pull apache/skywalking-base:7.0.0-es7

#SkyWalking OAP Server, https://hub.docker.com/r/apache/skywalking-oap-server
docker pull apache/skywalking-oap-server:7.0.0-es7

docker run -d \
--name skywalking-oap \
-p 11800:11800 \
-e "TZ=Asia/Shanghai" \
apache/skywalking-oap-server:7.0.0-es7

# SkyWalking UI, https://hub.docker.com/r/apache/skywalking-ui
docker pull apache/skywalking-ui:7.0.0

docker run -d \
--name skywalking-ui \
--link skywalking-oap:skywalking-oap \
-p 8088:8080 \
-e "TZ=Asia/Shanghai" \
apache/skywalking-ui:7.0.0 \
--collector.ribbon.listOfServers=skywalking-oap:12800 \
--security.user.admin.password=admin


```

## 本地安装

```bash


```
