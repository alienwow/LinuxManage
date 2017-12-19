## 准备工作
下载mongodb v2.6.10 到 /softwares 目录

## 开始安装
1、添加用户及群组
```bash
groupadd mongodb
useradd -g mongodb -s /sbin/nologin mongodb
```

2、准备 mongodb 目录
```bash
mkdir -p /usr/local/mongodb/repair
mkdir -p /data/mongodb/logs/
mkdir -p /data/mongodb/db/
touch /data/mongodb/logs/mongodb.log
chown -R mongodb:mongodb /data/mongodb
chmod -R 744 /data/mongodb
```

3、安装
```bash
cd /softwares
tar zxf /softwares/mongodb-linux-x86_64-2.6.10.tgz
mv /softwares/mongodb-linux-x86_64-2.6.10 /walkingtec/mongodb
chown -R mongodb:mongodb /walkingtec/mongodb
```

4、配置mongodb 配置文件
```bash
touch /etc/mongodb.conf
chmod 744 /etc/mongodb.conf
```

5、添加 mongodb 启动脚本
```bash
# 先添加启动脚本
vi /etc/init.d/mongod
# 增加服务
chown mongodb:mongodb /etc/init.d/mongod
chmod 755 /etc/init.d/mongod
################################################################################
```

6、设置开机启动
```bash
chkconfig --add mongod
chkconfig --level 345 mongod on
```

7、配置mongodb 用户及权限
```bash
# 链接mongodb
/walkingtec/mongodb/bin/mongo 127.0.0.1:7006/admin
    > use admin
    > db.createUser(
    >   {
    >     user: "admin",
    >     pwd: "abcd-1234",
    >     roles: [{role:"userAdminAnyDatabase",db:"admin"}]
    >   }
    > )
    # 添加数据库 quietly
    > use quietly
    > db.createUser(
    >   {
    >     user: "quietly_admin",
    >     pwd: "abcd-1234",
    >     roles: [ { role: "dbOwner", db: "quietly" } ]
    >   }
    > )
    > db.createUser(
    >   {
    >     user: "quietly_rw",
    >     pwd: "abcd-1234",
    >     roles: [ { role: "readWrite", db: "quietly" } ]
    >   }
    > )
    > db.createUser(
    >   {
    >     user: "quietly_r",
    >     pwd: "abcd-1234",
    >     roles: [ { role: "read", db: "quietly" } ]
    >   }
    > )
    # 删除用户
    > db.dropUser("quietly_rw");
    # 授权
    > db.grantRolesToUser(
    >   "admin",
    >    [
    >      { role: "clusterMonitor", db:"admin"} 
    >    ]
    > )
/walkingtec/mongodb/bin/mongo 127.0.0.1:7006/admin -u admin -p
```

8、连接 mongodb与认证
```bash
/walkingtec/mongodb/bin/mongo 10.161.219.94:7006/quietly -u quietly_admin -p bpo_123
/walkingtec/mongodb/bin/mongo 10.161.219.94:7006/admin -u admin -p walkingtec_0327
/walkingtec/mongodb/bin/mongo 10.99.187.104:7006/admin -u admin -p walkingtec_0327

认证：
use quietly;
db.auth('quietly_admin','bpo_123')
db.auth('admin','walkingtec_0327')
db.MemberAccount.remove({"ID":"170f89b8-9e22-11e5-ba15-00163e001096"})
```

9、备份
```bash
/walkingtec/mongodb/bin/mongodump -h 10.161.219.94:7006 -d quietly -u quietly_admin -p bpo_123 -o /data/backup
```

10、监控
```bash
# mongostat监控
/walkingtec/mongodb/bin/mongostat -h 10.161.219.94:7006 -u admin -p walkingtec_0327
/walkingtec/mongodb/bin/mongostat -h 10.99.187.104:7006 -u admin -p walkingtec_0327

# mongotop监控
/walkingtec/mongodb/bin/mongotop -h 10.161.219.94:7006 -u admin -p walkingtec_0327
/walkingtec/mongodb/bin/mongotop -h 10.99.187.104:7006 -u admin -p walkingtec_0327

# 服务器状态监控
/walkingtec/mongodb/bin/mongo 10.161.219.94:7006/admin -u admin -p walkingtec_0327
/walkingtec/mongodb/bin/mongo 10.99.187.104:7006/admin -u admin -p walkingtec_0327

    > db.serverStatus()
    > db.runCommand({"serverStatus" : 1})
    # 先use对应的库
    > db.MemberAccount.stats()
```