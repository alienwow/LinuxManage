# 网络防火墙安装

## 使用CentOS7自带的firewall
```bash
# 管理firewall  [start/stop/restart/status]
service firewall start

# 查看防火墙状态
iptables -L

# 查看所有打开的端口
firewall-cmd --zone=public --list-ports

# 开启80端口查看是否开启80端口
firewall-cmd --zone=public --query-port=80/tcp

# 开启80端口
firewall-cmd --zone=public --add-port=80/tcp --permanent    （--permanent永久生效，没有此参数重启后失效）

# 关闭80端口
firewall-cmd --zone=public --remove-port=80/tcp --permanent

# 重新载入防火墙
firewall-cmd --reload

```

## 使用 iptables
``` bash
# 停止firewall 
systemctl stop firewalld.service
# 禁止firewall开机启动 
systemctl disable firewalld.service

# 安装
yum install iptables-services

# 添加配置
vi /etc/sysconfig/iptables

# 默认配置
#################################################################
# sample configuration for iptables service
# you can edit this manually or use system-config-firewall
# please do not ask us to add additional ports/services to this default configuration
*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
-A INPUT -p icmp -j ACCEPT
-A INPUT -i lo -j ACCEPT
-A INPUT -p tcp -m state --state NEW -m tcp --dport 22 -j ACCEPT
-A INPUT -j REJECT --reject-with icmp-host-prohibited
-A FORWARD -j REJECT --reject-with icmp-host-prohibited
COMMIT
#################################################################

# 启动/关闭/重启 防火墙
systemctl start iptables.service
systemctl stop iptables.service
systemctl restart iptables.service

# 开机启动
systemctl enable iptables.service

```