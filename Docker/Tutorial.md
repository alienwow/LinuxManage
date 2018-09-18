# 基础
## 使用 Docker 建议
1. 使用国内的代理
1. 使用 alpine 作为基础镜像来制作镜像

## 登入/登出
```bash
# 登入
docker login --username=wuwenhao0327@gmail.com registry.cn-hangzhou.aliyuncs.com
# 登出
docker logout
```
## 镜像管理
### 搜索可用的docker镜像
http://www.docker.org.cn/book/docker/docker-search-image-6.html

在网站[index.docker.io](http://index.docker.io/)上搜索镜像。

```bash
# http://index.docker.io/
# 搜索名为 dotnet 的镜像
docker search dotnet
```

### 下载容器镜像
```bash
# 执行pull命令的时候要写完整的名字，比如"microsoft/dotnet"。
docker pull microsoft/dotnet
```

### 列出所有已安装镜像
```bash
# 列出所有已安装镜像
docker images

# 删除镜像
docker rmi [ImageId]
docker rmi [REPOSITORY]/[TAG]
# 删除所有镜像
docker rmi $(docker images -q)
# 删除untagged images，也就是那些id为<None>的image的话可以用
docker rmi $(docker images | grep "^<none>" | awk "{print $3}")

# 注意：因为容器依赖于镜像运行，所以删除镜像之前要删除基于此镜像的容器
# 将容器保存为镜像
docker commit [ContainerId] [ImageName]

# 发布镜像到阿里云
# 先在阿里云后台创建仓库 [仓库名]
docker login --username=wuwenhao0327@gmail.com registry.cn-hangzhou.aliyuncs.com
docker tag [ImageId] registry.cn-hangzhou.aliyuncs.com/alienwow/[仓库名]:[镜像版本号]
docker docker push registry.cn-hangzhou.aliyuncs.com/alienwow/[仓库名]:[镜像版本号]

```


### 容器管理
```bash
# 列出所有运行的容器
docker ps -a

# 查看容器详细信息
docker inspect [ContainerId]

# 停止运行中的容器
docker stop [ContainerId]
# 停止所有容器
docker stop $(docker ps -a -q)

# 删除容器
docker rm [ContainerId]
# 删除所有容器
docker rm $(docker ps -a -q)
```



















```bash
```