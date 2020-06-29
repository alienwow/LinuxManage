# 安装MySQL

```bash
# 创建目录
mkdir -p /Users/vito/data/mysql/logs

# 拉取最新的官方 mysql 镜像
docker pull mysql:8.0.20

# 启动 mysql-server 容器
docker run -p 7002:3306 -p 33060:33060 --name mysql -v /Users/vito/data/mysql/conf.d:/etc/mysql/conf.d -v /Users/vito/data/mysql/logs:/mysql/logs -v /Users/vito/data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abcd-1234 -d mysql:8.0.20

docker run -p 3306:3306 --name mysql5.7 -e MYSQL_ROOT_PASSWORD=abcd-1234 -d mysql:5.7

# 复制 mysql 配置
# 完成配置路径 /etc/mysql/，自定义配置放在 /etc/mysql/conf.d/
docker cp mysql:/etc/mysql/conf.d /Users/vito/data/mysql

# mysql 8 之前的版本中加密规则是mysql_native_password
# 而在mysql8之后,加密规则是caching_sha2_password
# 解决问题方法有两种：
# 1. 是升级navicat驱动
# 2. 是把mysql用户登录密码加密规则还原成mysql_native_password.
# 进入容器内部
docker exec -it mysql bash

# 登陆mysql
mysql -uroot -p

# 修改加密规则
ALTER USER 'root'@'%' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER;

# 更新一下用户的密码
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'abcd-1234';

# 刷新权限
FLUSH PRIVILEGES;

```
