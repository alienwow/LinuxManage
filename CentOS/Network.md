## 网卡设置
``` bash
# 配置网卡，需要重启服务器
vi /etc/udev/rules.d/70-persistent-net.rules
# 重启服务器
shutdown -r now
```

## Host
``` bash
# 设置 Host 及 Gateway
vi /etc/sysconfig/network
vi /etc/hosts
```

## 网络配置
``` bash
# 设置网络配置
vi /etc/sysconfig/network-scripts/ifcfg-eth0

# 默认配置
################################################################
# 网卡对应的设备别名
DEVICE=eth0
# 网卡获得ip地址的方式（默认为dhcp，表示自动获取） none、static、dhcp
BOOTPROTO=static
TYPE=Ethernet
UUID=fb949c96-65be-4a2e-97b0-9a5da6a8f0f1
# 系统启动时是否激活此设备
ONBOOT=yes
NM_CONTROLLED=yes
PREFIX=24

# 网卡MAC地址（物理地址）
HWADDR=00:15:5D:40:3B:14
IPADDR=192.168.2.101
# 网关
GATEWAY=192.168.2.1
# 主DNS
DNS1=192.168.2.1
# 备DNS
DNS2=192.168.2.1

DEFROUTE=yes
PEERDNS=yes
PEERROUTES=res
IPV4_FAILURE_FATAL=yes
# 禁止IPV6
IPV6INIT=no
NAME="System eth0"
################################################################
# 重启网卡
service network restart
```
