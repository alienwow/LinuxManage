# Install

系统环境：CentOS Linux release 7.6.1810 (Core)
软件：nginx-1.15.10.tar.gz 或最新
安装方式：源码编译安装
安装位置：/usr/local/nginx
下载地址：http://nginx.org/en/download.html

## 准备编译环境

```bash

# 卸载原有的Nginx
yum remove nginx

# 在安装nginx前，统需要确保系安装了g++、gcc
yum -y install wget gcc-c++

# 检查是否安装过pcre zlib
rpm -qa pcre
rpm -qa zlib
```

## 准备依赖模块

1. gzip模块需要 zlib 库
1. 支持rewrite，安装pcre
1. ssl 功能需要openssl库

### 系统层面安装

```bash

yum -y install zlib zlib-devel openssl openssl-devel pcre pcre-devel

yum -y install zlib*
yum -y install pcre*
yum -y install openssl*

```

### 自定义安装

```bash

# gzip模块需要 zlib 库
# 下载地址：http://www.zlib.net/fossils/
cd /softwares
tar -xzf zlib-1.2.11.tar.gz
cd /softwares/zlib-1.2.11
./configure --prefix=/usr/local/nginx/zlib_1.2.11
make && make install

# rewrite模块需要 pcre 库 http://www.pcre.org/
# 下载地址：ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/
cd /softwares
tar -xzf pcre-8.43.tar.gz
cd /softwares/pcre-8.43
./configure --prefix=/usr/local/nginx/pcre_8.43
make && make install

# 编译ssl需要 Perl5
cd /softwares
wget http://www.cpan.org/src/5.0/perl-5.24.0.tar.gz
tar -xzf perl-5.24.0.tar.gz
cd /softwares/perl-5.24.0
./Configure -des -Dprefix=$HOME/localperl
make
# make test
make install

# ssl 功能需要openssl库 https://www.openssl.org/source/
# 下载地址：https://github.com/openssl/openssl/releases
cd /softwares
tar -xzf openssl-OpenSSL_1_1_1b.tar.gz
cd /softwares/openssl-OpenSSL_1_1_1b
# 安装
make clean
./config --prefix=/usr/local/nginx/openssl_1.1.1b --openssldir=/usr/local/nginx/openssl_1.1.1b/conf
make && make install
# 安装shared
make clean
./config shared --prefix=/usr/local/nginx/openssl_1.1.1b --openssldir=/usr/local/nginx/openssl_1.1.1b/conf
make && make install

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
wget http://nginx.org/download/nginx-1.15.10.tar.gz
tar -xzf  nginx-1.15.10.tar.gz
cd /softwares/nginx-1.15.10

# l7
make clean

./configure \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--with-pcre \
--with-pcre=/softwares/pcre-8.43 \
--with-zlib=/softwares/zlib-1.2.11 \
--with-openssl=/softwares/openssl-OpenSSL_1_1_1b

make install

# l4

make clean

./configure \
--with-stream \
--with-http_stub_status_module \
--without-http_gzip_module \
--without-http_charset_module \
--without-http_ssi_module \
--without-http_userid_module \
--without-http_access_module \
--without-http_auth_basic_module \
--without-http_mirror_module \
--without-http_autoindex_module \
--without-http_geo_module \
--without-http_map_module \
--without-http_split_clients_module \
--without-http_referer_module \
--without-http_rewrite_module \
--without-http_proxy_module \
--without-http_fastcgi_module \
--without-http_uwsgi_module \
--without-http_scgi_module \
--without-http_grpc_module \
--without-http_memcached_module \
--without-http_limit_conn_module \
--without-http_limit_req_module \
--without-http_empty_gif_module \
--without-http_browser_module \
--without-http_upstream_hash_module \
--without-http_upstream_ip_hash_module \
--without-http_upstream_least_conn_module \
--without-http_upstream_random_module \
--without-http_upstream_keepalive_module \
--without-http_upstream_zone_module \
--without-http \
--without-http-cache \
--without-select_module \
--without-poll_module \
--without-pcre

make install

# l4+l7
make clean

./configure \
--with-stream \
--with-http_ssl_module \
--with-http_v2_module \
--with-http_realip_module \
--with-http_gunzip_module \
--with-http_gzip_static_module \
--with-http_stub_status_module \
--with-pcre \
--with-pcre=/softwares/pcre-8.43 \
--with-zlib=/softwares/zlib-1.2.11 \
--with-openssl=/softwares/openssl-OpenSSL_1_1_1b

make install

```

### 4、添加 nginx 启动脚本 并 设置开机启动

```bash

# 添加启动脚本
vi /etc/init.d/nginx

# 增加服务
chown nginx:nginx /etc/init.d/nginx
chmod 755 /etc/init.d/nginx

# CentOS7下要重新加载
systemctl daemon-reload

# 设置开机启动
chkconfig --add nginx
chkconfig --level 345 nginx on

```
