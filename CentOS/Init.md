# Init

## 关闭 SELINUX

```bash

# 注释 SELINUXTYPE 并把 SELINUX改为disabled
vi /etc/selinux/config

#SELINUX=enforcing
SELINUX=disabled

shutdown -r now
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