## 生成 rsa 公私钥
```bash
ssh-keygen -t rsa
```

## 私钥设置
```bash
# 将私钥保存到当前用户的家目录下的 .ssh 目录中
```

## 公钥设置
```bash
# 上传公钥
ssh root@60.10.194.195 -p 22 "mkdir ~/.ssh" 
scp -P 22 /c/Users/Wenhao.Wu/.ssh/id_rsa.pub root@60.10.194.195:~/.ssh/id_rsa.pub
# 将公钥转存到 authorized_keys 中
ssh root@60.10.194.195 -p 22 "cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys"
```