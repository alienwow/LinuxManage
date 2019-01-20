## 安装MySQL

```bash
# 拉取最新的官方 mysql 镜像
docker pull mysql:8.0.13
docker pull mysql:5.7.24

# 启动 mysql-server 容器
docker run -p 7002:3306 --name mysql-5.7.24 -v /Users/vito/data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abcd-1234 -d mysql:5.7.24
# docker cp mysql-5.7.24:/etc/mysql/my.cnf /Users/vito/data/mysql/conf/my.cnf
docker run -p 3306:3306 --name mysql-8.0.13 -v /Users/vito/data/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=abcd-1234 -d mysql:8.0.13

# mysql 8 之前的版本中加密规则是mysql_native_password
# 而在mysql8之后,加密规则是caching_sha2_password
# 解决问题方法有两种：
# 1. 是升级navicat驱动
# 2. 是把mysql用户登录密码加密规则还原成mysql_native_password.
# 进入容器内部
docker exec -it mysql-5.7.24 bash
# 登陆mysql
mysql -uroot -p
# 修改加密规则 
ALTER USER 'root'@'%' IDENTIFIED BY 'password' PASSWORD EXPIRE NEVER; 
# 更新一下用户的密码 
ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'abcd-1234';
# 刷新权限
FLUSH PRIVILEGES; 

```