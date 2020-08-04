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

netstat -nlp |grep 【端口号、进程名等】

## tar

压缩目录
tar -zcf 【目录名】.tar.gz 【目录名】

解压文件
tar -zxf 【目录名】.tar.gz
