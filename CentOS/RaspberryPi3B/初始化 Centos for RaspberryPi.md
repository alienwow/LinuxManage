# 初始化 Centos for RaspberryPi

## Init

### 修改时间

```bash
yum install -y ntp
systemctl enable ntpd
systemctl start ntpd
```

### 修改时区

```bash
cp /usr/share/zoneinfo/Asia/Shanghai  /etc/localtime
```

### 连接WIFI

### 安装wifi模块

```bash
curl --location https://github.com/RPi-Distro/firmware-nonfree/raw/54bab3d6a6d43239c71d26464e6e10e5067ffea7/brcm80211/brcm/brcmfmac43430-sdio.bin > /usr/lib/firmware/brcm/brcmfmac43430-sdio.bin

curl --location https://github.com/RPi-Distro/firmware-nonfree/raw/54bab3d6a6d43239c71d26464e6e10e5067ffea7/brcm80211/brcm/brcmfmac43430-sdio.txt > /usr/lib/firmware/brcm/brcmfmac43430-sdio.txt

reboot
```

### 查看无线网卡，连接wifi

```bash

nmcli d

#查看周围的wifi
nmcli d wifi

#连接wifi
nmcli d wifi connect yourSSID password 'yourpassword'

#查看wlan0的状态
nmcli d show wlan0

```

### 设置静态 IP

```bash
# 设置网络配置信息
# ????是wifi的名字
vi etc/sysconfig/network-script/ifcfg-????

#静态IP
BOOTPROTO=static
#IP地址
IPADDR=192.168.31.160
#默认网关
GATEWAY=192.168.31.1
#子网掩码
NETMASK=255.255.255.0

```

### 修改DNS

```bash
#修改以下内容
vi /etc/resolv.conf

#google域名服务器
nameserver 8.8.8.8
#google域名服务器  223.5.5.5  阿里dns
nameserver 8.8.4.4
nameserver 114.114.114.114

# 以上步骤搞完以后 需要重启下网卡
service network restart
```
