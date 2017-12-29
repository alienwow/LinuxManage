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
cd ~/.ssh
# 将公钥转存到 authorized_keys 中
cat ~/.ssh/id_rsa.pub >> authorized_keys
```