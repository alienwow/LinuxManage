# 时钟同步

服务：chronyd.service / 服务：chronyd
配置：/etc/chrony.conf

```bash
# 启动时钟同步服务
systemctl start chronyd.service

# 开机启动
systemctl enable chronyd.service

```

## 常用命令

```bash

# 查看时间同步源
chronyc sources -v

# 查看时间同步源状态
chronyc sourcestats -v

# 查看同步状态
chronyc tracking

# 手动同步，需要先停止 chronyd 服务
chronyd -q 'server ntp.aliyun.com iburst'


# 显示系统的当前时间和日间
timedatectl
同
timedatectl status

```

## 配置解析

```bash

# Use public servers from the pool.ntp.org project.
# Please consider joining the pool (http://www.pool.ntp.org/join.html).
# 默认的时钟同步服务器
# 建议使用国内的服务器，可以使用公共的同步服务器 https://dns.icoa.cn/ntp/
server 0.centos.pool.ntp.org iburst
server 1.centos.pool.ntp.org iburst
server 2.centos.pool.ntp.org iburst
server 3.centos.pool.ntp.org iburst

# Record the rate at which the system clock gains/losses time.
driftfile /var/lib/chrony/drift

# Allow the system clock to be stepped in the first three updates
# if its offset is larger than 1 second.
makestep 1.0 3

# Enable kernel synchronization of the real-time clock (RTC).
rtcsync

# Enable hardware timestamping on all interfaces that support it.
#hwtimestamp *

# Increase the minimum number of selectable sources required to adjust
# the system clock.
#minsources 2

# Allow NTP client access from local network.
#allow 192.168.0.0/16
# 允许同步的客户端网段
allow 192.168.1.0/24

# Serve time even if not synchronized to a time source.
#local stratum 10

# Specify file containing keys for NTP authentication.
#keyfile /etc/chrony.keys

# Specify directory for log files.
logdir /var/log/chrony

# Select which information is logged.
#log measurements statistics tracking

```
