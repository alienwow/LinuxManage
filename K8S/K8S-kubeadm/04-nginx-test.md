# test

```bash

# 创建一个 deploy
kubectl create deploy ngx-deploy --image=nginx:1.17.10-alpine

kubectl get all

kubectl get deployment
kubectl get replicaset
kubectl get pod -o wide

kubectl delete pod/[podName]

# clusterip模式: 通过 clusterip:port 去访问
# 创建一个 svc
kubectl create svc clusterip ngx-svc --tcp=80:80 --dry-run
# 创建一个 svc，clusterip模式，与之前创建的 deploy 同名，
kubectl create svc clusterip ngx-deploy --tcp=80:80 --dry-run
kubectl get svc/ngx-deploy -o yaml
kubectl delete svc/ngx-deploy

# nodeport 模式：通过 nodeip:port 去访问
kubectl create svc nodeport ngx-deploy --tcp=80:80 --dry-run

```
