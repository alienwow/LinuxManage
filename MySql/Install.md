## 准备工作
下载软件到 /softwares 目录

[http://ftp.ntu.edu.tw/MySQL/Downloads/](http://ftp.ntu.edu.tw/MySQL/Downloads/)

[MySQL-server-5.6.20-1.el6.x86_64.rpm](http://ftp.ntu.edu.tw/MySQL/Downloads/MySQL-5.6/MySQL-server-5.6.20-1.el6.x86_64.rpm)

[MySQL-devel-5.6.20-1.el6.x86_64.rpm](http://ftp.ntu.edu.tw/MySQL/Downloads/MySQL-5.6/MySQL-devel-5.6.20-1.el6.x86_64.rpm)

[MySQL-client-5.6.20-1.el6.x86_64.rpm](http://ftp.ntu.edu.tw/MySQL/Downloads/MySQL-5.6/MySQL-client-5.6.20-1.el6.x86_64.rpm)

## 开始安装
### 1、卸载原有的 mysql
```bash
rpm -qa | grep -i mysql
# 如果安装了先卸载旧的版本    
yum -y remove mysql
```

### 2、添加用户及群组
```bash
groupadd mysql
useradd -g mysql -s /sbin/nologin mysql
```

### 3、开始安装
```bash
cd /softwares
rpm -ivh MySQL-server-5.6.20-1.el6.x86_64.rpm
# rpm -ivh MySQL-devel-5.6.20-1.el6.x86_64.rpm 可以不需要安装
rpm -ivh MySQL-client-5.6.20-1.el6.x86_64.rpm
# 如果出现如下错误
# error: Failed dependencies:
#   libaio.so.1()(64bit) is needed by MySQL-server-5.6.20-1.el6.x86_64
#   libaio.so.1(LIBAIO_0.1)(64bit) is needed by MySQL-server-5.6.20-1.el6.x86_64
#   libaio.so.1(LIBAIO_0.4)(64bit) is needed by MySQL-server-5.6.20-1.el6.x86_64
# 则执行如下命令
cd /softwares
wget http://mirror.centos.org/centos/6/os/x86_64/Packages/libaio-0.3.107-10.el6.x86_64.rpm
rpm -ivh libaio-0.3.107-10.el6.x86_64.rpm
```

## 配置 MySql 运行环境
### 1、创建目录及文件
```bash
mkdir -p /data/mysql/logs
mkdir -p /data/mysql/db
touch /data/mysql/logs/mysql.err
touch /data/mysql/logs/general.log
touch /data/mysql/logs/sortrepl.log
touch /data/mysql/logs/slowquery.log
cp -R /var/lib/mysql/* /data/mysql/db/
chown -R mysql:mysql /data/mysql
chmod -R 755 /data/mysql
chmod -R 755 /data/mysql/logs
```

### 2、启动 mysql
```bash
service mysql start
```

### 3、配置 mysql root用户密码
```bash
service mysql stop
mysqld_safe --user=mysql --skip-grant-tables --skip-networking
mysql -u root mysql
    mysql> UPDATE user SET Password=PASSWORD('abcd-1234') where USER='root';
    mysql> FLUSH PRIVILEGES;
    mysql> quit;
service mysql stop
service mysql start
mysql -uroot -p
    mysql> SET PASSWORD = PASSWORD('abcd-1234');
    mysql> FLUSH PRIVILEGES;
    mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'abcd-1234' WITH GRANT OPTION;
    mysql> FLUSH PRIVILEGES;
    mysql> quit;
service mysql restart
```

### 4、 设置开机启动
```bash
chkconfig --add mysql
chkconfig --level 345 mysql on
# 至此配置完成
```


## 查看mysql 进程
```bash
ps -ef|grep mysqld
```