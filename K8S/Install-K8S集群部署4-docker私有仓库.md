# 安装 docker私有仓库

## docker私有仓库

```bash

mkdir -p /data/registry.repos

docker pull registry

tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://ljcq9oc9.mirror.aliyuncs.com"],
    "insecure-registries": ["192.168.159.154:5000"]
}
EOF

systemctl daemon-reload
service docker restart

docker stop dockerRegistry
docker rm dockerRegistry

# 启动容器
docker run \
--name dockerRegistry \
--restart=always \
-p 5000:5000 \
-v /data/registry.repos:/var/lib/registry \
-d registry

# 安装私有仓库
docker pull docker.io/tianyebj/pod-infrastructure
docker tag tianyebj/pod-infrastructure 192.168.159.154:5000/pod-infrastructure
docker push 192.168.159.154:5000/pod-infrastructure

docker pull kubernetes/pause
docker tag docker.io/kubernetes/pause:latest 192.168.159.154:5000/google_containers/pause-amd64.3.0
docker push 192.168.159.154:5000/google_containers/pause-amd64.3.0

```
