# 安装 node

## 安装 kubelet、kube-proxy

```bash
groupadd kube
useradd -g kube -s /sbin/nologin kube

mkdir -p /vito/kubernetes/bin
mkdir -p /vito/kubernetes/conf
mkdir -p /data/logs/kubernetes/kubelet
mkdir -p /data/logs/kubernetes/kube-proxy
mkdir -p /var/lib/kubelet

# 将以下二进制文件上传到 /vito/kubernetes/bin 目录下
1. kubelet
2. kube-proxy

# 安装 kubelet
touch /lib/systemd/system/kubelet.service
chmod 766 /lib/systemd/system/kubelet.service
vi /lib/systemd/system/kubelet.service

# 安装 kube-proxy
touch /lib/systemd/system/kube-proxy.service
chmod 766 /lib/systemd/system/kube-proxy.service
vi /lib/systemd/system/kube-proxy.service

# 设置开机启动
systemctl enable kubelet.service
systemctl enable kube-proxy.service

# CentOS7下要重新加载
systemctl daemon-reload

# 启动服务
systemctl start kubelet.service
systemctl start kube-proxy.service

# 检查每个服务的健康状态
systemctl status kubelet.service
systemctl status kube-proxy.service

service kubelet restart
service kube-proxy restart

```
