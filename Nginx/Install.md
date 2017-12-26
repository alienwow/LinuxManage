## 安装说明
系统环境：CentOS-6.5
软件：nginx-1.13.7.tar.gz 或最新
安装方式：源码编译安装
安装位置：/walkingtec/nginx/
下载地址：http://nginx.org/en/download.html

## 准备工作
```bash
# 在安装nginx前，统需要确保系安装了g++、gcc、openssl-devel、pcre-devel和zlib-devel软件。
yum -y install wget gcc-c++ zlib zlib-devel openssl openssl-devel pcre pcre-devel
# 支持rewrite，安装pcre:
yum install pcre*
# 支持ssl，安装openssl
yum install openssl*
# 卸载原有的Nginx
yum remove nginx
```

## 开始安装
### 1、添加用户及群组
```bash
groupadd nginx
useradd -g nginx -s /sbin/nologin nginx
```

### 2、准备 nginx 目录
```bash
mkdir -p /data/nginx/logs/
touch /data/nginx/logs/error.log
touch /data/nginx/logs/access.log
# 授权
chown -R nginx:nginx /data/nginx
chmod -R 755 /data/nginx
```

### 3、安装
```bash
cd /softwares
wget http://nginx.org/download/nginx-1.13.7.tar.gz
tar -xzf  nginx-1.13.7.tar.gz
cd /softwares/nginx-1.13.7
./configure \
--prefix=/walkingtec/nginx \
--conf-path=/walkingtec/nginx/nginx.conf \
--with-http_ssl_module \
--with-http_stub_status_module
make install
```

### 4、添加 nginx 启动脚本 并 设置开机启动
```bash
# 先添加启动脚本
vi /etc/init.d/nginx
# 增加服务
chown nginx:nginx /etc/init.d/nginx
chmod 755 /etc/init.d/nginx
# 设置开机启动
chkconfig --add nginx
chkconfig --level 345 nginx on
```
