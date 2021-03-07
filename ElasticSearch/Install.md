# 安装 ElasticSearch

## 准备工作

1. [下载 elasticsearch https://www.elastic.co/cn/downloads/elasticsearch](https://www.elastic.co/cn/downloads/elasticsearch);
1. [下载 elasticsearch ik分词 https://github.com/medcl/elasticsearch-analysis-ik/releases](https://github.com/medcl/elasticsearch-analysis-ik/releases)

## 安装 head

1. [下载 head](https://github.com/mobz/elasticsearch-head)

### 跨域问题

```bash
# 修改 elasticsearch.yml
# 添加如下2行配置
http.cors.enabled: true
http.cors.allow-origin: "*"

```

## 安装 IK 分词器

将下载的 `elasticsearch-analysis-ik.zip` 解压缩到 elasticsearch 的 plugins 目录

## 集群部署

### 节点1

```bash
#集群名称，保证唯一
cluster.name: elasticsearch-vito
#节点名称，必须不一样
node.name: node-1
# 是否可作为主节点
node.master: true
# 是否存储数据
node.data: true
#必须为本机的ip地址
network.host: 127.0.0.1
#服务端口号，在同一机器下必须不一样
http.port: 9201
#集群间通信端口号，在同一机器下必须不一样
transport.tcp.port: 9301
discovery.seed_hosts: ["127.0.0.1:9301","127.0.0.1:9302","127.0.0.1:9303"]
cluster.initial_master_nodes: ["node-1","node-2","node-3"]
# 最大集群节点数
node.max_local_storage_nodes: 3
# 在群集完全重新启动后阻止初始恢复，直到启动N个节点
# 简单点说在集群启动后，至少复活多少个节点以上，那么这个服务才可以被使用，否则不可以被使用
gateway.recover_after_nodes: 2
```

### 节点2

```bash
cluster.name: elasticsearch-vito
node.name: node-2
node.master: true
node.data: true
network.host: 127.0.0.1
http.port: 9202
transport.tcp.port: 9302
discovery.seed_hosts: ["127.0.0.1:9301","127.0.0.1:9302","127.0.0.1:9303"]
cluster.initial_master_nodes: ["node-1","node-2","node-3"]
node.max_local_storage_nodes: 3
gateway.recover_after_nodes: 2
```

### 节点3

```bash
cluster.name: elasticsearch-vito
node.name: node-3
node.master: true
node.data: true
network.host: 127.0.0.1
http.port: 9203
transport.tcp.port: 9303
discovery.seed_hosts: ["127.0.0.1:9301","127.0.0.1:9302","127.0.0.1:9303"]
cluster.initial_master_nodes: ["node-1","node-2","node-3"]
node.max_local_storage_nodes: 3
gateway.recover_after_nodes: 2
```

## 构建 docker

### 构建 elasticsearch+ik分词器

```bash
docker build -f Dockerfile --rm -t elasticsearch-ik:7.11.1 .
```

### docker 单机部署

```bash

mkdir -p /Users/vito/data/es/config/
mkdir -p /Users/vito/data/es/data/

touch /Users/vito/data/es/config/elasticsearch.yml

# 添加配置
echo "http.cors.enabled: true
http.cors.allow-origin: \"*\"

#节点1的配置信息：
#集群名称，保证唯一
cluster.name: elasticsearch-docker
node.name: elasticsearch-docker
network.host: 0.0.0.0
http.port: 9200
transport.tcp.port: 9300"> /Users/vito/data/es/config/elasticsearch.yml

docker stop elasticsearch
docker rm elasticsearch

docker run \
--name elasticsearch \
-e "TZ=Asia/Shanghai" \
-e "discovery.type=single-node" \
-e "cluster.name=docker-es" \
-e ES_JAVA_OPTS="-Xms256m -Xmx1024m" \
-p 9200:9200 \
-p 9300:9300 \
-v /Users/vito/data/es/config/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es/data:/usr/share/elasticsearch/data \
-d \
elasticsearch-ik:7.11.1

```

### docker 集群部署

```bash

mkdir -p /Users/vito/data/es-cluster/{node1,node2,node3}/config/
mkdir -p /Users/vito/data/es-cluster/{node1,node2,node3}/data/
mkdir -p /Users/vito/data/es-cluster/{node1,node2,node3}/log/

# 配置 node1
echo "
http.cors.enabled: true
http.cors.allow-origin: \"*\"

# 是否可作为主节点
node.master: true
# 是否存储数据
node.data: true
network.host: 0.0.0.0
http.port: 9201
transport.tcp.port: 9301
# 最大集群节点数
node.max_local_storage_nodes: 3
# 在群集完全重新启动后阻止初始恢复，直到启动N个节点
# 简单点说在集群启动后，至少复活多少个节点以上，那么这个服务才可以被使用，否则不可以被使用
gateway.recover_after_nodes: 2
"> /Users/vito/data/es-cluster/node1/config/elasticsearch.yml

# 配置 node2
echo "
http.cors.enabled: true
http.cors.allow-origin: \"*\"

node.master: true
node.data: true
network.host: 0.0.0.0
http.port: 9202
transport.tcp.port: 9302
node.max_local_storage_nodes: 3
gateway.recover_after_nodes: 2
"> /Users/vito/data/es-cluster/node2/config/elasticsearch.yml

# 配置 node3
echo "
http.cors.enabled: true
http.cors.allow-origin: \"*\"

node.master: true
node.data: true
network.host: 0.0.0.0
http.port: 9203
transport.tcp.port: 9303
node.max_local_storage_nodes: 3
gateway.recover_after_nodes: 2
"> /Users/vito/data/es-cluster/node3/config/elasticsearch.yml

# node-1
docker stop es-cluster-node1
docker rm es-cluster-node1

docker run \
--name es-cluster-node1 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node1" \
-e "cluster.name=es-docker-cluster" \
-e "http.cors.enabled=true" \
-e "http.cors.allow-origin=*" \
-e "node.master=true" \
-e "node.data=true" \
-e "network.host=0.0.0.0" \
-e "http.port=9201" \
-e "transport.tcp.port=9301" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node1/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-p 9201:9201 \
-p 9301:9301 \
-d \
elasticsearch-ik:7.11.1

# node-2
docker stop es-cluster-node2
docker rm es-cluster-node2

docker run \
--name es-cluster-node2 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node2" \
-e "cluster.name=es-docker-cluster" \
-e "http.cors.enabled=true" \
-e "http.cors.allow-origin=*" \
-e "node.master=true" \
-e "node.data=true" \
-e "network.host=0.0.0.0" \
-e "http.port=9202" \
-e "transport.tcp.port=9302" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node2/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-p 9202:9202 \
-p 9302:9302 \
-d \
elasticsearch-ik:7.11.1

# node-3
docker stop es-cluster-node3
docker rm es-cluster-node3

docker run \
--name es-cluster-node3 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node3" \
-e "cluster.name=es-docker-cluster" \
-e "http.cors.enabled=true" \
-e "http.cors.allow-origin=*" \
-e "node.master=true" \
-e "node.data=true" \
-e "network.host=0.0.0.0" \
-e "http.port=9203" \
-e "transport.tcp.port=9303" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node3/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-p 9203:9203 \
-p 9303:9303 \
-d \
elasticsearch-ik:7.11.1

```
