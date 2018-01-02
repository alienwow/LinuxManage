

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
rpm -qa | grep -i mariadb
rpm -e --nodeps mariadb-libs-5.5.56-2.el7.x86_64
```