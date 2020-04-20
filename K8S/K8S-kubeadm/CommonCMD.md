# CommonCMD

## 命名空间 namespace

```bash
# 查看
kubectl get namespaces
kubectl get ns

# 查看详细信息
kubectl get ns/kube-system -o wide
# 查看更详细信息 yaml 格式
kubectl get ns/kube-system -o yaml
# 查看更详细信息 json 格式
kubectl get ns/kube-system -o json

# 查看描述信息
kubectl describe ns/kube-system

# 创建命名空间
kubectl create ns develop
kubectl create ns uat
kubectl create ns prod
kubectl create ns/vito01 ns/vito02

# 删除命名空间
kubectl delete ns develop
kubectl delete ns/vito01 ns/vito02

```

## 查看pod

```bash

# 查看指定 namespace 下的pod
kubectl get pod -n kube-system

# 查看指定 namespace 下的 pod 的详细信息
kubectl get pod -n kube-system -o wide

```

## scale 扩缩容

```bash

# 扩缩容成3个实例
kubectl scale --replicas=3 deployment ngx-deploy

```
