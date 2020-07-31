# Init

## 关闭 SELINUX

```bash

# 注释 SELINUXTYPE 并把 SELINUX改为disabled
vi /etc/selinux/config

#SELINUX=enforcing
SELINUX=disabled

shutdown -r now
```

## 修改主机名

```bash
# 查看一下当前主机名的情况
hostnamectl

hostnamectl set-hostname [Name] --static
hostnamectl set-hostname [Name] --transient
hostnamectl set-hostname [Name] --pretty

cat /etc/hostname

```

## 防火墙设置

```bash

# 1. 使用 firewall
systemctl start firewalld.service
systemctl enable firewalld.service

# 2. 使用 iptables
# 停止 firewall
systemctl stop firewalld.service
# 禁止 firewall 开机启动
systemctl disable firewalld.service

# 安装
yum install iptables-services
# 启动/关闭/重启 防火墙
systemctl start iptables.service
# 开机启动
systemctl enable iptables.service


```

## 配置 yum 源

```bash
# 禁用 yum插件 fastestmirror
cp /etc/yum/pluginconf.d/fastestmirror.conf /etc/yum/pluginconf.d/fastestmirror.conf.bak
# enabled = 1  //由1改为0，禁用该插件
vi /etc/yum/pluginconf.d/fastestmirror.conf

# 修改yum的配置文件
cp /etc/yum.conf /etc/yum.conf.bak
# plugins=1    //改为0，不使用插件
vi /etc/yum.conf

# 获取阿里云 repo
cp /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.bak
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo

cp /etc/yum.repos.d/epel.repo /etc/yum.repos.d/epel.repo.bak
wget -O /etc/yum.repos.d/epel.repo http://mirrors.aliyun.com/repo/epel-7.repo

# 清理缓存
yum clean all
yum makecache
yum -y update

```

## 3、安装常用工具库

```bash
yum -y install wget gcc-c++ zlib zlib-devel openssl openssl-devel pcre pcre-devel
# 支持rewrite，安装pcre:
yum -y install pcre*
# 支持ssl，安装openssl
yum -y install openssl*
```

## 4、卸载  mariadb

```bash
rpm -qa | grep -i mariadb
rpm -e --nodeps mariadb-libs-5.5.60-1.el7_5.x86_64
```

## 5、添加 SSH

[设置SSH 免密登陆](SSH.md)
