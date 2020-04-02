# 安装 Kubernetes

## 准备环境

### 关闭 CentOS 防火墙

```bash
systemctl disable firewalld
systemctl stop firewalld
```

### 安装 etcd 和 kubernetes 软件

```bash
yum install -y etcd kubernetes
```

### 启动服务

```bash
systemctl start etcd
systemctl start docker

# 如果docker启动失败
# 请参考(vi /etc/sysconfig/selinux 把selinux后面的改为disabled，
# 重启机器，再重启docker就可以了
systemctl start kube-apiserver
systemctl start kube-controller-manager
systemctl start kube-scheduler
systemctl start kubelet
systemctl start kube-proxy

service kube-apiserver status
service kube-controller-manager status
service kube-scheduler status
service kubelet status
service kube-proxy status

```

## 创建 tomcat 服务

创建 k8s 目录

```bash
mkdir -p /data/k8s/tomcat
```

### 创建 mytomcat.rc.yaml

```bash
vi mytomcat.rc.yaml
```

添加配置内容

```yaml
apiVersion: v1
kind: ReplicationController
metadata:
 name: mytomcat
spec:
 replicas: 2
 selector:
  app: mytomcat
 template:
  metadata:
   labels:
    app: mytomcat
  spec:
    containers:
      - name: mytomcat
        image: tomcat:7-jre7
        ports:
        - containerPort: 8080

```

```bash
kubectl create -f mytomcat.rc.yaml
kubectl replace -f mytomcat.rc.yaml
```

### 创建 mytomcat.svc.yaml

```bash
vi mytomcat.svc.yaml
```

添加配置内容

```yaml
apiVersion: v1
kind: Service
metadata:
  name: mytomcat
spec:
  type: NodePort
  ports:
    - port: 8080
      nodePort: 30001
  selector:
    app: mytomcat

```

```bash
kubectl create -f mytomcat.svc.yaml
kubectl delete svc --all
```

## 问题

### kubectl get pods 时 No resources found问题

```bash
vi /etc/kubernetes/apiserver

# 找到如下内容
# KUBE_ADMISSION_CONTROL="--admission-control=NamespaceLifecycle,NamespaceExists,LimitRanger,SecurityContextDeny,ServiceAccount,ResourceQuota"
# 移除上述内容中的 ServiceAccount 配置
systemctl restart kube-apiserver

```

### 外网无法访问问题

```bash

# 在搭建好的k8s集群内创建的容器，只能在其所在的节点上curl可访问，但是在其他任何主机上无法访问 容器占用的端口
# 解决方案:
vi /etc/sysctl.conf

# 在最后添加如下配置
net.ipv4.ip_forward=1

```

### 无法创建镜像问题

创建本地仓库：
docker pull registry
mkdir /data/myregistry
docker run -d -p 5000:5000 -v /data/myregistry:/var/lib/registry registry

解决方案1
1、yum install rhsm -y
2、docker pull registry.access.redhat.com/rhel7/pod-infrastructure:latest
  如果以上两步解决问题了，那么就不需要在执行下面操作
3、docker search pod-infrastructure
4、docker pull docker.io/tianyebj/pod-infrastructure
5、docker tag tianyebj/pod-infrastructure 192.168.159.153:5000/pod-infrastructure
6、docker push 192.168.159.153:5000/pod-infrastructure
7、vi /etc/kubernetes/kubelet
  修改 KUBELET_POD_INFRA_CONTAINER="--pod-infra-container-image=192.168.159.153:5000/pod-infrastructure:latest"
8、重启服务
  systemctl restart kube-apiserver
  systemctl restart kube-controller-manager
  systemctl restart kube-scheduler
  systemctl restart kubelet
  systemctl restart kube-proxy

解决方案2
1、docker pull kubernetes/pause
2、docker tag docker.io/kubernetes/pause:latest 192.168.159.153:5000/google_containers/pause-amd64.3.0
3、docker push 192.168.159.153:5000/google_containers/pause-amd64.3.0
4、vi /etc/kubernetes/kubelet配置为
  KUBELET_ARGS="--pod_infra_container_image=192.168.159.153:5000/google_containers/pause-amd64.3.0"
5、重启kubelet服务
  systemctl restart kubelet
