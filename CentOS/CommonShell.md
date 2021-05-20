# 常用命令

## 查看系统基本信息

```bash

## 查看内核版本
uname -sr

## 查看CentOS版本
cat /etc/redhat-release

## 查看系统信息
cat /proc/version
uname -a

## 查看64位还是32位
getconf LONG_BIT

## 查看系统时间
date

```

## 查看内存占用

ps -aux | sort -k4nr | head -10

## 查看内存使用率

top 按M

## 查看网络占用

nload

## 查看端口占用

```bash
# 安装 netstat
yum install -y net-tools

# 其中：-n表示表示输出中不显示主机，端口和用户名，-lb表示只显示监听listening端口，-t表示只显示tcp协议的端口，-p表示显示进程的PID和进程名称。

netstat -nlp |grep 【端口号、进程名等】

netstat -nltp
```

## tar

```bash

# 压缩目录
tar -zcf 【目录名】.tar.gz 【目录名】

# 解压文件
tar -zxf 【目录名】.tar.gz

# 解压到指定目录
tar -zxf 【目录名】.tar.gz -C [目录]

```

## 查看打开的文件句柄数量

```bash
# 查看指定进程打开的文件句柄数量
lsof -p [PID] | wc -l

# 查看指定进程所有打开的文件句柄
lsof -p [PID]

# 查看指定进程打开的文件句柄数量
ll /proc/[PID]/fd |wc -l
# 查看指定进程打开的socket类型的文件句柄
ll /proc/[PID]/fd |grep socket:
# 查看指定进程打开的socket类型的文件句柄数量
ll /proc/[PID]/fd |grep socket: |wc -l
```
