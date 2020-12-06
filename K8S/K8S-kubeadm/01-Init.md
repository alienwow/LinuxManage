# Init

初始化master及node节点基础环境

## 测试环境说明

1. 借助 NTP 服务设定各节点时间精确同步；
1. 通过 DNS 完成各节点的主机名称解析，测试环境主机数量较少可以配置 hosts 文件；
1. 关闭各节点的防火墙 如 iptables 或 firewalld 服务，并确保禁止开机启动；
1. 各节点均禁用 SELinux；
1. 各节点禁用所有 Swap 设备；
1. 若要使用 ipvs 模型的 proxy，各节点还需要载入 ipvs 相关的各模块。

## [设置时钟同步](/CentOS/ntp.md)

## 设置 DNS / hosts

```bash

vi /etc/hosts

192.168.1.113 master.k8s master
192.168.1.116 node01.k8s node01
192.168.1.117 node02.k8s node02
192.168.1.118 node03.k8s node03

```

## [关闭防火墙](/CentOS/Init.md)

## [关闭 SELinux](/CentOS/Init.md)

## [关闭 swap](/CentOS/swap.md)

## 启用 ipvs

```bash
cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF

# # 以下内容无效？
# cat > /etc/sysconfig/modules/ipvs.modules <<EOF
# #!/bin/bash
# ipvs_mods_dir="/usr/lib/modules/$(uname -r)/kernel/net/netfilter/ipvs"
# for mod in $(ls $ipvs_mods_dir | grep -o "^[^.]*"); do
#     /sbin/modinfo -F filename $mod &> /dev/null
#     if [ $? -eq 0 ]; then
#         /sbin/modprobe $mod
#     fi
# done
# EOF

chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4

```

## [安装 docker](/Docker/Install.md)

## 设置环境变量

在`ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock`一行
之前添加环境变量设置。

```bash
cp /usr/lib/systemd/system/docker.service /usr/lib/systemd/system/docker.service.bak
vi /usr/lib/systemd/system/docker.service

# 设置代理
Environment="HTTPS_PROXY=PROTOCOL://HOST:PORT"

# 设置不需要代理的ip
Environment="NO_PROXY=192.168.1.0/24,127.0.0.0/8"

```

## 安装k8s初始化报错 `WARNING IsDockerSystemdCheck`

出现`WARNING IsDockerSystemdCheck`，是由于 docke r的 Cgroup Driver 和 kubelet 的 Cgroup Driver 不一致导致的，此处选择修改 docker 的和 kubelet 一致

所以需要在 ExecStart 后面添加 `--exec-opt native.cgroupdriver=systemd` 配置。

```bash
docker info | grep Cgroup

vi /usr/lib/systemd/system/docker.service

systemctl daemon-reload

service docker restart

```

## 设置 iptables 的 FORWARD 默认策略为 ACCEPT

docker 自 v1.13 版本会自动设置 iptables 的 FORWARD 默认策略为 DROP，这可能会影响 kubernates 集群依赖的豹纹转发功能。
因此需要在 docker 服务启动后，重新将 FORWARD 链的默认策略设置为 ACCEPT，方式是修改`/usr/lib/systemd/system/docker.service`文件，
在`ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock`一行
之后添加如下内容: `ExecStartPost=/usr/sbin/iptables -P FORWARD ACCEPT`。

```bash
vi /usr/lib/systemd/system/docker.service

systemctl daemon-reload

service docker restart

```

## 桥接相关参数设置

某些 docker 版本会自动启用`net.bridge.bridge-nf-call-ip6tables`，`net.bridge.bridge-nf-call-iptables`的设置，有些不会修改，所以需要手动修改

`sysctl -a | grep bridge` 命令查看是否已经启用，若没启用则添加如下配置

```bash

# 创建文件 /etc/sysctl.d/k8s.conf
touch /etc/sysctl.d/k8s.conf
vi /etc/sysctl.d/k8s.conf

net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1

sysctl -p /etc/sysctl.d/k8s.conf

systemctl daemon-reload

service docker restart

```

## 安装 kubernetes 源

```bash
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
setenforce 0

# 手动导入gpgkey 或者关闭 gpgcheck=0
rpmkeys --import https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg
rpmkeys --import https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg

yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet

# 查看 kubelet 安装信息
rpm -ql kubelet
# /etc/kubernetes/manifests
# /etc/sysconfig/kubelet
# /usr/bin/kubelet
# /usr/lib/systemd/system/kubelet.service

rpm -ql kubeadm
# /usr/bin/kubeadm
# /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf

rpm -ql kubectl
# /usr/bin/kubectl

# config 位置
~/.kube/config

```

## 设置 kubelet

若未禁用 Swap 设备，则需要编辑 kubelet 的配置文件 `/etc/sysconfig/kubelet`，设置其忽略 Swap 启用的状态错误。
内容如下：`KUBELET_EXTRA_ARGS="--fail-swap-on=false"`
