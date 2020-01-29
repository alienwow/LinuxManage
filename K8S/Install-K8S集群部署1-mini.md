# 安装 docker

## 关闭 CentOS 防火墙

```bash
# 查看默认防火墙状态(关闭后显示not running ,开启后显示 running)
firewall-cmd --state

# 关闭防火墙
systemctl stop firewalld.service

# 禁止firewall开机启动
systemctl disable firewalld.service

# 获取Kubernetes二进制包
# https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.9.md

```

## [安装 docker](/Docker/Install.md)
