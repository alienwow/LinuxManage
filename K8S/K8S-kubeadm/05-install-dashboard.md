# install dashboard

https://github.com/kubernetes/dashboard

```bash
docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/kubernetes-dashboard-amd64:v1.10.1

docker tag registry.cn-hangzhou.aliyuncs.com/google_containers/kubernetes-dashboard-amd64:v1.10.1 k8s.gcr.io/kubernetes-dashboard-amd64:v1.10.1

docker rmi registry.cn-hangzhou.aliyuncs.com/google_containers/kubernetes-dashboard-amd64:v1.10.1

# 创建 dashboard
kubectl apply -f kubernetes-dashboard.yaml
kubectl apply -f kubernetes-dashboard-adminuser.yaml

# 获取token
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep kubernetes-dashboard-admin-token | awk '{print $1}')

# eyJhbGciOiJSUzI1NiIsImtpZCI6IlBPTkdwZUpzdDIwVnhjczQ4ZFpfOUswVHo3TGpwOUlsVFdPQkRVamtQejgifQ.eyJpc3MiOiJrdWJlcm5ldGVzL3NlcnZpY2VhY2NvdW50Iiwia3ViZXJuZXRlcy5pby9zZXJ2aWNlYWNjb3VudC9uYW1lc3BhY2UiOiJrdWJlLXN5c3RlbSIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VjcmV0Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZC1hZG1pbi10b2tlbi1qdGw0cyIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50Lm5hbWUiOiJrdWJlcm5ldGVzLWRhc2hib2FyZC1hZG1pbiIsImt1YmVybmV0ZXMuaW8vc2VydmljZWFjY291bnQvc2VydmljZS1hY2NvdW50LnVpZCI6ImQ1MTIxYmQ2LTE0MWMtNDMwYS1iZGVmLTg4ZmIyZDUzMzIxZCIsInN1YiI6InN5c3RlbTpzZXJ2aWNlYWNjb3VudDprdWJlLXN5c3RlbTprdWJlcm5ldGVzLWRhc2hib2FyZC1hZG1pbiJ9.UkPWpFfcFfPTb0RWqY2zibaWoIoOvjw6RW10UUv3EqlECAymZoO6soWUfkTNrOXwLU5Pw-Wm34i9wT4RUh_bXMDIX4yL5Rk9u8llzBgHGkHn8JhlEKDWJdihrZbFWSEo1Qh2rvHHH_RfbEMWO91VADBLJeQjxFga1vvmfux2F33d8aAY344Orv3lq6RQJZzBwRvK_vqTeZeykdIZ4LHcjLEZAncfpAvc09U8UOBKt6eqmpN1GnztBcBZRz-gjyPu01beh7sYDkPrTq5jkCaU4VI3-oqMuMJ15YHV4B9EhXIqkXL_AijT1keu6Wj0chcAgKzdPVD8RqruinLOasrzqA

kubectl delete -f kubernetes-dashboard.yaml
kubectl delete -f kubernetes-dashboard-adminuser.yaml

```
