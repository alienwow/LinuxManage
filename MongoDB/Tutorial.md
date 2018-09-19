# Tutorial

## 基本操作
### 连接数据库
```bash
./mongo 127.0.0.1:7003/admin -u admin -p

```

### 认证
```bash
db.auth('userName','pwd')
```

### 数据库操作
```bash
# 查看数据库
show dbs
```

### 用户管理
```bash
# 查看用户
show users

# 创建用户
use admin
db.createUser(
  {
    user: "root",
    pwd: "abcd-1234",
    roles: [ { role: "root", db: "admin" } ]
  }
)

# 删除用户
use dbName
db.dropUser("userName")

# 修改密码
    # 方法1：
db.changeUserPassword("userName","newPwd")
    # 方法2：
db.updateUser("userName",{pwd:"newPwd"})


# 修改权限
db.updateUser("userName",{roles:[{role:"read",db:"testDB"}]})
# 注：updateuser 它是完全替换之前的值，如果要新增或添加 roles 而不是代替它 

# 添加权限
db.grantRolesToUser("userName", [{role:"readWrite", db:"testDB"},{role:"read", db:"testDB"}])

# 删除权限
db.revokeRolesFromUser("userName",[{role:"read", db:"testDB"}])


```



## 权限详解

### 内建角色
数据库用户角色：    read、readWrite
数据库管理角色：    dbAdmin、dbOwner、userAdmin
集群管理角色：      clusterAdmin、clusterManager、clusterMonitor、hostManager
备份恢复角色：      backup、restore
所有数据库角色：    readAnyDatabase、readWriteAnyDatabase、userAdminAnyDatabase、dbAdminAnyDatabase
超级用户角色：      root；这里还有几个角色间接或直接提供了系统超级用户的访问（dbOwner 、userAdmin、userAdminAnyDatabase）
内部角色：         __system

### 角色说明
Read：                  允许用户读取指定数据库
readWrite：             允许用户读写指定数据库
dbAdmin：               允许用户在指定数据库中执行管理函数，如索引创建、删除，查看统计或访问system.profile
userAdmin：             允许用户向system.users集合写入，可以找指定数据库里创建、删除和管理用户
dbOwner：               允许在当前DB中执行任意操作
readAnyDatabase：       赋予用户所有数据库的读权限，只在admin数据库中可用
readWriteAnyDatabase：  赋予用户所有数据库的读写权限，只在admin数据库中可用
userAdminAnyDatabase：  赋予用户所有数据库管理User的权限，只在admin数据库中可用
dbAdminAnyDatabase：    赋予管理所有数据库的权限，只在admin数据库中可用
root：                  超级账号，超级权限，只在admin数据库中可用。

### 集群管理角色
clusterAdmin：          赋予管理集群的最高权限，只在admin数据库中可用
clusterManager：        赋予管理和监控集群的权限
clusterMonitor：        赋予监控集群的权限，对监控工具具有 readonly 的权限
hostManager：           赋予管理Server



```bash
```