

## 1、关闭 SELINUX
```bash
# 注释 SELINUXTYPE 并把 SELINUX改为disabled
vi /etc/selinux/config
#SELINUX=enforcing
#SELINUXTYPE=targeted
SELINUX=disabled
# 重启服务器
```

## 2、卸载 Firewall 并安装 iptables 防火墙
```bash
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
rpm -e --nodeps mariadb-libs-5.5.56-2.el7.x86_64
```

## 5、添加SSH
```bash
# 上传公钥
ssh root@60.10.194.195 -p 22 "mkdir ~/.ssh" 
scp -P 22 /c/Users/Wenhao.Wu/.ssh/id_rsa.pub root@60.10.194.195:~/.ssh/id_rsa.pub
# 将公钥转存到 authorized_keys 中
ssh root@60.10.194.195 -p 22 "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
```