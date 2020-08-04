# 生成 rsa 公私钥

## 生成公私钥

```bash
ssh-keygen -t rsa -C "wuwenhao0327@gmail.com"
# 默认生成到 ~/.ssh 目录下
# 生成两个文件：
# 1. id_rsa         私钥
# 2. id_rsa.pub     公钥
```

## 公钥设置

```bash

iphost=60.10.194.195
port=22

# 上传公钥
ssh root@$ipHost -p $port "mkdir ~/.ssh"
scp -P $port ~/.ssh/id_rsa.pub root@$ipHost:~/.ssh/id_rsa.pub

# 将公钥转存到 authorized_keys 中
ssh root@$ipHost -p $port "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"

```

## 配置 ssh 端口号

```bash
vi /etc/ssh/sshd_config

# 修改如下数据
# (每隔多少秒给SSH客户端发送一次信号)
# 注释掉 Port 22
Port 10022

# 重启 ssh 服务
systemctl restart sshd.service
```

## 配置超时连接时间

```bash
vi /etc/ssh/sshd_config

# 修改如下数据
# (每隔多少秒给SSH客户端发送一次信号)
ClientAliveInterval 60
# (超过多少秒后断开与SSH客户端连接)
ClientAliveCountMax 86400

systemctl restart sshd.service
```

## ssh 问题

### 连接慢的解决方案

```bash
vi /etc/ssh/sshd_config

UseDNS no
GSSAPIAuthentication no

#重启 SSH 服务
systemctl restart sshd.service
```
