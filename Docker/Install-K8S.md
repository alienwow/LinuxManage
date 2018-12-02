https://kubernetes.io/docs/tasks/tools/install-kubectl/

## 安装 kubectl
```bash
# 查看版本
https://storage.googleapis.com/kubernetes-release/release/stable.txt

# 安装
wget https://storage.googleapis.com/kubernetes-release/release/$(version)/bin/darwin/amd64/kubectl

chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

```
