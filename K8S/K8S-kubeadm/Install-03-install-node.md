# Install node

node 节点必备的基础镜像

1. k8s.gcr.io/kube-proxy:v1.18.2
1. k8s.gcr.io/pause:3.2
1. quay.io/coreos/flannel:v0.12.0-amd64

## 初始化 node

```bash

kubeadm join -h

# k8s.gcr.io/kube-proxy:v1.18.2
# k8s.gcr.io/pause:3.2

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.2
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2

docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.2 k8s.gcr.io/kube-proxy:v1.18.2
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2 k8s.gcr.io/pause:3.2

docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.2
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2

# quay.io/coreos/flannel:v0.12.0-amd64
# quay.io/coreos/flannel:v0.12.0-arm64
# quay.io/coreos/flannel:v0.12.0-arm
# quay.io/coreos/flannel:v0.12.0-ppc64le
# quay.io/coreos/flannel:v0.12.0-s390x

docker pull quay-mirror.qiniu.com/coreos/flannel:v0.12.0-amd64

docker tag quay-mirror.qiniu.com/coreos/flannel:v0.12.0-amd64 quay.io/coreos/flannel:v0.12.0-amd64

kubeadm join 192.168.1.113:6443 --token 63dkv8.39vqj7qb52xzz4bx \
    --discovery-token-ca-cert-hash sha256:5127c409d11226ba40dbc4080087db65914b9480d2907b25772f7fa419729e13

# 配置 kubectl 的配置文件 也就是 master 节点上生成的 admin.conf
scp /etc/kubernetes/admin.conf node01:$HOME/.kube/config

# 查看运行状态
kubectl get pods -n kube-system

# 此时查看集群节点状态是 Ready
kubectl get nodes



```

## 错误解决

使用 `journalctl -u kubelet` 去查日志，如果看不出明显错误，再使用 `systemctl status kubelet` 去看 `kubelet` 的状态。如果出现以下错误

```bash



```
