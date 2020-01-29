# 安装 master

## 资料准备

- 下载 [K8S 资源](https://github.com/kubernetes/kubernetes/blob/master/CHANGELOG-1.17.md#server-binaries 'K8S 资源'): 该压缩包中包括了k8s需要运行的全部服务程序文件
- 下载 [etcd 资源](https://github.com/etcd-io/etcd/releases 'etcd 资源')

## 安装 etcd

```bash
groupadd etcd
useradd -g etcd -s /sbin/nologin etcd

mkdir -p /vito/etcd/bin
mkdir -p /var/lib/etcd/
chown -R etcd:etcd /var/lib/etcd/

# 进入/lib/systemd/system目录，并创建etcd.service文件
touch /lib/systemd/system/etcd.service
chmod 666 /lib/systemd/system/etcd.service
vi /lib/systemd/system/etcd.service

# 设置开机启动
systemctl enable etcd.service
# CentOS7下要重新加载
systemctl daemon-reload

# 创建软链接
ln -s /vito/etcd/bin/etcdctl /usr/local/bin/etcdctl

# 检查状态
etcdctl cluster-health
etcdctl endpoint health

systemctl start etcd.service
```

## 安装 kube-apiserver、kube-controller-manager、kube-scheduler

```bash
groupadd kube
useradd -g kube -s /sbin/nologin kube

mkdir -p /vito/kubernetes/bin
mkdir -p /vito/kubernetes/conf
mkdir -p /data/logs/kubernetes/apiserver
mkdir -p /data/logs/kubernetes/controller-manager
mkdir -p /data/logs/kubernetes/scheduler

# 创建软链接
ln -s /vito/kubernetes/bin/kubectl /usr/local/bin/kubectl

# 安装 kube-apiserver
touch /lib/systemd/system/kube-apiserver.service
chmod 766 /lib/systemd/system/kube-apiserver.service
vi /lib/systemd/system/kube-apiserver.service

# 安装 kube-controller-manager
touch /lib/systemd/system/kube-controller-manager.service
chmod 766 /lib/systemd/system/kube-controller-manager.service
vi /lib/systemd/system/kube-controller-manager.service

# 安装 kube-scheduler
touch /lib/systemd/system/kube-scheduler.service
chmod 766 /lib/systemd/system/kube-scheduler.service
vi /lib/systemd/system/kube-scheduler.service

# 设置开机启动
systemctl enable kube-apiserver.service
systemctl enable kube-controller-manager.service
systemctl enable kube-scheduler.service

# CentOS7下要重新加载
systemctl daemon-reload

# 启动服务
systemctl start kube-apiserver.service
systemctl start kube-controller-manager.service
systemctl start kube-scheduler.service

# 检查每个服务的健康状态
systemctl status kube-apiserver.service
systemctl status kube-controller-manager.service
systemctl status kube-scheduler.service

service etcd restart
service kube-apiserver restart
service kube-controller-manager restart
service kube-scheduler restart

```

### 检查

```bash

# 查看集群状态
kubectl get nodes

# 查看master集群组件状态
kubectl get rc

# 查看 pod
kubectl get pods

# 查看具体的pod
kubectl describe pods 【pod Name】

```
