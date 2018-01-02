

## 1、关闭 SELINUX
```bash
# 注释 SELINUXTYPE 并把 SELINUX改为disabled
vi /etc/selinux/config
#SELINUX=enforcing
#SELINUXTYPE=targeted
SELINUX=disabled
# 重启服务器
```

## 2、安装常用工具库
```bash
yum -y install wget gcc-c++ zlib zlib-devel openssl openssl-devel pcre pcre-devel
# 支持rewrite，安装pcre:
yum -y install pcre*
# 支持ssl，安装openssl
yum -y install openssl*
```


## 3、卸载  mariadb
```bash
rpm -qa | grep -i mysql
# 如果安装了先卸载旧的版本    
yum -y remove mysql
```