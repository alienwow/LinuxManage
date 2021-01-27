# 部署 consul

## 部署准备

```bash
# 拉取镜像
docker pull consul:1.9.2

# 宿主机上创建目录
mkdir -p /vito/consul/conf/
mkdir -p /vito/consul/data/
mkdir -p /vito/consul/consul_ui/

```

## docker 单机部署

```bash

# 拉取镜像
docker pull consul:1.9.2

docker stop consul-server
docker rm consul-server

# Consul 单实例
docker run -d \
-p 8500:8500/tcp \
--name consul-server \
--restart always \
consul:1.9.2 agent -server -ui -bootstrap -client=0.0.0.0

```

## docker 集群部署

### server

```bash

docker stop consul-server1
docker rm consul-server1

docker run -d \
-p 8300:8300/tcp \
-p 8301:8301/tcp \
-p 8301:8301/udp \
-p 8500:8500/tcp \
-p 8600:8600/tcp \
-p 8600:8600/udp \
--name consul-server1 \
--restart always \
# 开启宿主机网络
--net=host \
# 绑定指定的网卡
-e CONSUL_BIND_INTERFACE='ens192' \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
consul:1.9.2 agent \
# server 模式，client 为客户端模式
-server \
# 开启 ui 
-ui \
# 节点名称
-node=server1 \
# 数据中心名称
-datacenter=dc1 \
-client=0.0.0.0 \
# 默认的 leader
-bootstrap \
# 表示加入 172.11.80.20 所在的集群
-join=172.11.80.20 \
-retry-join=172.11.80.20

```

### client

```bash

docker stop consul-client1
docker rm consul-client1

docker run -d \
-p 8300:8300/tcp \
-p 8301:8301/tcp \
-p 8301:8301/udp \
-p 8500:8500/tcp \
-p 8600:8600/tcp \
-p 8600:8600/udp \
--name consul-client1 \
--restart always \
# 开启宿主机网络
--net=host \
# 绑定指定的网卡
-e CONSUL_BIND_INTERFACE='ens192' \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
consul:1.9.2 agent \
# server 模式，client 为客户端模式
-client \
# 节点名称
-node=client1 \
# 数据中心名称
-datacenter=dc1 \
-client=0.0.0.0 \
# 表示加入 172.11.80.20 所在的集群
-join=172.11.80.20 \
-retry-join=172.11.80.20

```
