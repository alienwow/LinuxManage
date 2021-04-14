# 安装 MongoDB

```bash

# 创建目录
mkdir -p /Users/vito/data/mongodb/conf
mkdir -p /Users/vito/data/mongodb/data
mkdir -p /Users/vito/data/mongodb/logs/mongodb.log
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
