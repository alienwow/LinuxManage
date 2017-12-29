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
DEVICE="eth0"
# 网卡获得ip地址的方式（默认为dhcp，表示自动获取） none、static、dhcp
# 设置未 none 重启后会自动联网
BOOTPROTO="none"
TYPE="Ethernet"
UUID="d9beb10d-6984-42d3-947e-faab129e326d"
# 系统启动时是否激活此设备
ONBOOT="yes"

# 网卡MAC地址（物理地址）
IPADDR="192.168.2.103"
PREFIX="24"
# 网关
GATEWAY="192.168.2.1"
# 主DNS
DNS1="10.96.1.18"
# 备DNS
DNS2="10.96.1.19"

DEFROUTE="yes"
IPV4_FAILURE_FATAL="no"
PROXY_METHOD="none"
BROWSER_ONLY="no"
# 禁止IPV6
IPV6INIT="no"
IPV6_AUTOCONF="yes"
IPV6_DEFROUTE="yes"
IPV6_FAILURE_FATAL="no"
IPV6_ADDR_GEN_MODE="stable-privacy"
NAME="eth0"
################################################################
# 重启网卡
service network restart
```
