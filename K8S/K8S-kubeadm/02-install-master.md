# Install master

master 节点必备的基础镜像

1. k8s.gcr.io/kube-apiserver:v1.18.3
1. k8s.gcr.io/kube-controller-manager:v1.18.3
1. k8s.gcr.io/kube-scheduler:v1.18.3
1. k8s.gcr.io/kube-proxy:v1.18.3
1. k8s.gcr.io/pause:3.2
1. k8s.gcr.io/etcd:3.4.4-0
1. k8s.gcr.io/coredns:1.6.7
1. quay.io/coreos/flannel:v0.12.0-amd64

## 初始化master

```bash

kubeadm init -h

# 指定 k8s 版本
--kubernetes-version

# 设置 pod 网络
--pod-network-cidr="10.244.0.0/16"

# 设置 service 网络
--service-cidr="10.96.0.0/12"

# 设置镜像仓库
--image-repository

# 测试
--dry-run

# k8s.gcr.io/kube-apiserver:v1.18.3
# k8s.gcr.io/kube-controller-manager:v1.18.3
# k8s.gcr.io/kube-scheduler:v1.18.3
# k8s.gcr.io/kube-proxy:v1.18.3
# k8s.gcr.io/pause:3.2
# k8s.gcr.io/etcd:3.4.4-0
# k8s.gcr.io/coredns:1.6.7

# registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.3
# gcr.azk8s.cn/google_containers/kube-apiserver:v1.18.3

docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.3
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.3
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.3
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.3
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.4-0
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7

docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.3 k8s.gcr.io/kube-apiserver:v1.18.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.3 k8s.gcr.io/kube-controller-manager:v1.18.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.3 k8s.gcr.io/kube-scheduler:v1.18.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.3 k8s.gcr.io/kube-proxy:v1.18.3
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2 k8s.gcr.io/pause:3.2
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.4-0 k8s.gcr.io/etcd:3.4.4-0
docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7 k8s.gcr.io/coredns:1.6.7

docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-apiserver:v1.18.3
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-controller-manager:v1.18.3
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-scheduler:v1.18.3
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kube-proxy:v1.18.3
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/pause:3.2
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/etcd:3.4.4-0
docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/coredns:1.6.7

kubeadm init --kubernetes-version="v1.18.3" --pod-network-cidr="10.244.0.0/16" --service-cidr="10.96.0.0/12" --image-repository="registry.cn-hangzhou.aliyuncs.com/google_containers" --dry-run

# 建议使用普通用户运行，执行如下操作
#   mkdir -p $HOME/.kube
#   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#   sudo chown $(id -u):$(id -g) $HOME/.kube/config
mkdir $HOME/.kube
cp /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config

# 此时查看集群节点状态是 NotReady
kubectl get nodes

# quay.io/coreos/flannel:v0.12.0-amd64
# quay.io/coreos/flannel:v0.12.0-arm64
# quay.io/coreos/flannel:v0.12.0-arm
# quay.io/coreos/flannel:v0.12.0-ppc64le
# quay.io/coreos/flannel:v0.12.0-s390x

docker pull quay-mirror.qiniu.com/coreos/flannel:v0.12.0-amd64
docker tag quay-mirror.qiniu.com/coreos/flannel:v0.12.0-amd64 quay.io/coreos/flannel:v0.12.0-amd64

# # 安装cni插件flannel https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f kube-flannel.yml
# kubectl delete -f kube-flannel.yml

# 查看运行状态
kubectl get pods -n kube-system

# 此时查看集群节点状态是 Ready
kubectl get nodes

kubeadm join 192.168.1.113:6443 --token 63dkv8.39vqj7qb52xzz4bx \
    --discovery-token-ca-cert-hash sha256:5127c409d11226ba40dbc4080087db65914b9480d2907b25772f7fa419729e13

```

## 错误解决

使用 `journalctl -u kubelet` 去查日志，如果看不出明显错误，再使用 `systemctl status kubelet` 去看 `kubelet` 的状态。如果出现以下错误

```bash



```
