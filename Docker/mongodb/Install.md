# 安装 MongoDB

## 单机部署

```bash

# 创建目录
mkdir -p /Users/vito/data/mongodb/{conf,data,logs}
touch /Users/vito/data/mongodb/logs/mongodb.log

# 拉取最新的官方 mongo 镜像
docker pull mongo:4.4.4

docker stop mongodb
docker rm mongodb

docker run --name mongodb \
-p 27017:27017 \
-v /Users/vito/data/mongodb/data:/data/db \
-v /Users/vito/data/mongodb/conf:/data/configdb \
-v /Users/vito/data/mongodb/logs:/var/log/mongodb \
-d mongo:4.4.4

# 进入系统
docker exec -it mongodb bash
# 配置账号
mongo 127.0.0.1:27017/admin
# 切换db
use admin
# 创建用户
db.createUser(
  {
    user: "admin",
    pwd: "abcd-1234",
    roles: [{role:"userAdminAnyDatabase",db:"admin"}]
  }
)

use vito_db
db.createUser(
  {
    user: "vito",
    pwd: "abcd-1234",
    roles: [ { role: "dbOwner", db: "vito_db" } ]
  }
)

```

## 集群部署 （还没完事儿）

```bash

mkdir -p /Users/vito/data/mongo-cluster/{node1,node2,node3}/{conf,data,logs}

#创建第一个配置文件
#写入配置信息，端口号

echo "# mongodb.conf
logappend=true
# bind_ip=127.0.0.1
port=27001
auth=false" > /Users/vito/data/mongo-cluster/node1/conf/mongo.conf

#创建第二个配置文件
#写入配置信息，端口号

echo "# mongodb.conf
logappend=true
# bind_ip=127.0.0.1
port=27002
auth=false" > /Users/vito/data/mongo-cluster/node2/conf/mongo.conf



docker stop mongo-node1
docker rm mongo-node1

docker run --name mongo-node1 \
-p 27001:27001 \
--net=host \
-v /Users/vito/data/mongo-cluster/node1/data:/data/db \
-v /Users/vito/data/mongo-cluster/node1/conf:/data/configdb \
-v /Users/vito/data/mongo-cluster/node1/logs:/var/log/mongodb \
-d mongo:4.4.4 \
mongod -f /data/configdb/mongo.conf --configsvr --replSet "rs_config_server" --bind_ip_all


docker stop mongo-node2
docker rm mongo-node2

docker run --name mongo-node2 \
-p 27002:27002 \
--net=host \
-v /Users/vito/data/mongo-cluster/node2/data:/data/db \
-v /Users/vito/data/mongo-cluster/node2/conf:/data/configdb \
-v /Users/vito/data/mongo-cluster/node2/logs:/var/log/mongodb \
-d mongo:4.4.4 \
mongod -f /data/configdb/mongo.conf --configsvr --replSet "rs_config_server" --bind_ip_all

```
