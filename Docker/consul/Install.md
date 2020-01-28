
# 部署准备

```bash

# 宿主机上创建目录
mkdir -p /vito/consul/conf/
mkdir -p /vito/consul/data/
mkdir -p /vito/consul/consul_ui/

# 拉取镜像
docker pull consul:1.4.1

# Running Consul for Development
docker run \
--name=consul \
-h server-node1 \
-p 8500:8500 \
-p 8600:8600/udp \
-p 8300:8300 \
-p 8301:8301/udp \
-p 8302:8302/udp \
-e CONSUL_BIND_INTERFACE=eth0 \
-d consul:1.4.1

# Running Consul Agent in Client Mode
docker run \
--net=host -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
-d consul:1.4.1 \
agent \
-bind=<external ip> \
-retry-join=<root agent ip>

docker run \
-p 8100:8500 \
--name=client1 \
-d -e 'CONSUL_LOCAL_CONFIG={"leave_on_terminate": true}' \
consul:1.4.1 \
agent \
-bind=172.17.0.5 \
-retry-join=172.17.0.2 \
-node=client1

# Running Consul Agent in Server Mode
docker run -p 8600:53/udp -h node1 progrium/consul -server -bootstrap

docker run -d consul:1.4.1 \
--net=host \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
agent \
-server \
-bind=<external ip> \
-retry-join=<root agent ip> \
-bootstrap-expect=<number of server agents>

docker run -d consul:1.4.1 \
-p 8500:8500 \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
--name=consul1 \
agent -server \
-bind=172.17.0.2 \
-bootstrap-expect=3 \
-node=server1

docker run -d consul:1.4.1 \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
--name=consul2 \
agent -server \
-bind=172.17.0.3 \
-retry-join=172.17.0.2 \
-bootstrap-expect=3 \
-node=server2

docker run -d consul:1.4.1 \
-e 'CONSUL_LOCAL_CONFIG={"skip_leave_on_interrupt": true}' \
--name=consul3 \
agent -server \
-bind=172.17.0.4 \
-retry-join=172.17.0.2 \
-bootstrap-expect=3 \
-node=server3

```