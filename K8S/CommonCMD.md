# 常用命令

- 创建容器

  kubectl create -f kubernate-pvc.yaml
  kubectl replace -f kubernate-pvc.yaml

- 删除容器

  kubectl delete pods/test-pd
  kubectl delete -f rc-nginx.yaml

- 删除node

  kubectl delete node 【node Name】

- 获取当前命名空间下的容器

  kubectl get pods

- 获取所有容器列表

  kubectl get all

- 查看指定 pod 跑在哪个 node 上

  kubectl get pod /test-pd -o wide

- 查看容器日志

  Kubectl logs 【pod Name】

- 进入容器终端命令

  kubectl exec -it 【pod Name】 /bin/bash

- 一个 Pod 里含有多个容器用 --container or -c 参数。

  例如:假如这里有个 Pod 名为 my-pod,这个 Pod 有两个容器,分别名为 main-app 和 helper-app,下面的命令将打开到 main-app 的 shell 的容器里。

  kubectl exec -it my-pod --container main-app -- /bin/bash

- 容器详情列表

  kubectl _describe_ pod/mysql- m8rbl

- 查看容器状态

  kubectl get svc
