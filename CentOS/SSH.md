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