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

# 配置
echo "
http.cors.enabled: true
http.cors.allow-origin: \"*\"

# 是否可作为主节点
node.master: true
# 是否存储数据
node.data: true
network.host: 0.0.0.0
# 最大集群节点数
node.max_local_storage_nodes: 3
# 在群集完全重新启动后阻止初始恢复，直到启动N个节点
# 简单点说在集群启动后，至少复活多少个节点以上，那么这个服务才可以被使用，否则不可以被使用
gateway.recover_after_nodes: 2
"> /Users/vito/data/es-cluster/elasticsearch.yml

# node-1
docker stop es-cluster-node1
docker rm es-cluster-node1

docker run \
--name es-cluster-node1 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node1" \
-e "cluster.name=es-docker-cluster" \
-e "http.port=9201" \
-e "transport.tcp.port=9301" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node1/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
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
-e "http.port=9202" \
-e "transport.tcp.port=9302" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node2/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
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
-e "http.port=9203" \
-e "transport.tcp.port=9303" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node3/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-p 9203:9203 \
-p 9303:9303 \
-d \
elasticsearch-ik:7.11.1

```

## elastic 启用x-pack 安全认证

### 启用 xpack 安全配置

```bash

# 修改配置
echo "xpack.security.enabled: true">> /Users/vito/data/es-cluster/node1/config/elasticsearch.yml
echo "xpack.security.enabled: true">> /Users/vito/data/es-cluster/node2/config/elasticsearch.yml
echo "xpack.security.enabled: true">> /Users/vito/data/es-cluster/node3/config/elasticsearch.yml

# 重启集群
docker restart es-cluster-node1 es-cluster-node2 es-cluster-node3

# 进入任意一个节点生成证书
docker exec -it es-cluster-node1 bash
# 生成证书
bin/elasticsearch-certutil cert -out config/elastic-certificates.p12 -pass ""

# 将证书拷贝到宿主机
docker cp es-cluster-node1:/usr/share/elasticsearch/config/elastic-certificates.p12 /Users/vito/data/es-cluster/elastic-certificates.p12

# 修改配置
echo "xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12">> /Users/vito/data/es-cluster/node1/config/elasticsearch.yml

echo "xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12">> /Users/vito/data/es-cluster/node2/config/elasticsearch.yml

echo "xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12">> /Users/vito/data/es-cluster/node3/config/elasticsearch.yml

# 为 es 容器添加文件映射，将宿主机证书映射到容器
# node-1
docker stop es-cluster-node1
docker rm es-cluster-node1

docker run \
--name es-cluster-node1 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node1" \
-e "cluster.name=es-docker-cluster" \
-e "http.port=9201" \
-e "transport.tcp.port=9301" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node1/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
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
-e "http.port=9202" \
-e "transport.tcp.port=9302" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node2/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
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
-e "http.port=9203" \
-e "transport.tcp.port=9303" \
-e "network.publish_host=172.11.80.69" \
-e "discovery.seed_hosts=172.11.80.69:9301,172.11.80.69:9302,172.11.80.69:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node3/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
-p 9203:9203 \
-p 9303:9303 \
-d \
elasticsearch-ik:7.11.1

# node-1
docker stop es-cluster-node1
docker rm es-cluster-node1

docker run \
--name es-cluster-node1 \
-e "TZ=Asia/Shanghai" \
-e "node.name=es-cluster-node1" \
-e "cluster.name=es-docker-cluster" \
-e "http.port=9201" \
-e "transport.tcp.port=9301" \
-e "network.publish_host=192.168.1.100" \
-e "discovery.seed_hosts=192.168.1.100:9301,192.168.1.100:9302,192.168.1.100:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node1/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
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
-e "http.port=9202" \
-e "transport.tcp.port=9302" \
-e "network.publish_host=192.168.1.100" \
-e "discovery.seed_hosts=192.168.1.100:9301,192.168.1.100:9302,192.168.1.100:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node2/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
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
-e "http.port=9203" \
-e "transport.tcp.port=9303" \
-e "network.publish_host=192.168.1.100" \
-e "discovery.seed_hosts=192.168.1.100:9301,192.168.1.100:9302,192.168.1.100:9303" \
-e "cluster.initial_master_nodes=es-cluster-node1,es-cluster-node2,es-cluster-node3" \
-e "ES_JAVA_OPTS=-Xms512m -Xmx512m" \
-v /Users/vito/data/es-cluster/node3/data:/usr/share/elasticsearch/data \
-v /Users/vito/data/es-cluster/node3/log:/usr/share/elasticsearch/log \
-v /Users/vito/data/es-cluster/elasticsearch.yml:/usr/share/elasticsearch/config/elasticsearch.yml \
-v /Users/vito/data/es-cluster/elastic-certificates.p12:/usr/share/elasticsearch/config/elastic-certificates.p12 \
-p 9203:9203 \
-p 9303:9303 \
-d \
elasticsearch-ik:7.11.1

```

### 最终的 elasticsearch.yml 配置

```bash
http.cors.enabled: true
http.cors.allow-origin: "*"

node.master: true
node.data: true
network.host: 0.0.0.0
node.max_local_storage_nodes: 3
gateway.recover_after_nodes: 2
xpack.security.enabled: true
xpack.security.transport.ssl.enabled: true
xpack.security.transport.ssl.verification_mode: certificate
xpack.security.transport.ssl.keystore.path: elastic-certificates.p12
xpack.security.transport.ssl.truststore.path: elastic-certificates.p12
```

### 为 es 设置密码

```bash

# 进入任意一个节点设置密码即可
docker exec -it es-cluster-node1 bash

# 设置自定义密码
bin/elasticsearch-setup-passwords interactive

# 然后输入密码
h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61

# apm_system: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# kibana_system: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# kibana: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# logstash_system: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# beats_system: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# remote_monitoring_user: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61
# elastic: h!I!Nq5WQJdGM81HxTF*%B$c$kGQx&61

```
