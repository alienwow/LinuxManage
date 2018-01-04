#网络防火墙安装
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