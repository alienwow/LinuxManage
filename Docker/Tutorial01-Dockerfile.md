## 在 Dockerfile 中用到的命令有

- FROM 例：FROM microsoft/aspnetcore:2.0
    FROM指定一个基础镜像， 一般情况下一个可用的 Dockerfile一定是 FROM 为第一个指令。至于image则可以是任何合理存在的image镜像。
    FROM 一定是首个非注释指令 Dockerfile.
    FROM 可以在一个 Dockerfile 中出现多次，以便于创建混合的images。
    如果没有指定 tag ，latest 将会被指定为要使用的基础镜像版本。

- MAINTAINER
    这里是用于指定镜像制作者的信息

- RUN
    RUN命令将在当前image中执行任意合法命令并提交执行结果。命令执行提交后，就会自动执行Dockerfile中的下一个指令。
    层级 RUN 指令和生成提交是符合Docker核心理念的做法。它允许像版本控制那样，在任意一个点，对image 镜像进行定制化构建。
    RUN 指令缓存不会在下个命令执行时自动失效。比如 RUN apt-get dist-upgrade -y 的缓存就可能被用于下一个指令. --no-cache 标志可以被用于强制取消缓存使用。

- ENV
    ENV指令可以用于为docker容器设置环境变量
    ENV设置的环境变量，可以使用 docker inspect命令来查看。同时还可以使用docker run --env <key>=<value>来修改环境变量。

- USER
    USER 用来切换运行属主身份的。Docker 默认是使用 root，但若不需要，建议切换使用者身分，毕竟 root 权限太大了，使用上有安全的风险。

- COPY <src> <dest>
    COPY 将文件从路径 <src> 复制添加到容器内部路径 <dest>。
    <src> 必须是想对于源文件夹的一个文件或目录，也可以是一个远程的url，<dest>
    是目标容器中的绝对路径。
    所有的新文件和文件夹都会创建UID 和 GID 。事实上如果 <src> 是一个远程文件URL，那么目标文件的权限将会是600。

- ADD <src> <dest>
    ADD 将文件从路径 <src> 复制添加到容器内部路径 <dest>。
    <src> 必须是想对于源文件夹的一个文件或目录，也可以是一个远程的url。<dest> 是目标容器中的绝对路径。
    所有的新文件和文件夹都会创建UID 和 GID。事实上如果 <src> 是一个远程文件URL，那么目标文件的权限将会是600。
- VOLUME
    创建一个可以从本地主机或其他容器挂载的挂载点，一般用来存放数据库和需要保持的数据等。

- EXPOSE
    EXPOSE 指令用于指定Container内部服务开启的端口。主机上要用还得在启动container时，做host-container的端口映射

- CMD
    Dockerfile.中只能有一个CMD指令。 如果你指定了多个，那么最后个CMD指令是生效的。
    CMD指令的主要作用是提供默认的执行容器。这些默认值可以包括可执行文件，也可以省略可执行文件。
    当你使用shell或exec格式时， CMD会自动执行这个命令。
    Container启动时执行的命令，但是一个Dockerfile中只能有一条CMD命令，多条则只执行最后一条CMD

- ONBUILD
    ONBUILD 的作用就是让指令延迟執行，延迟到下一个使用 FROM 的 Dockerfile 在建立 image 时执行，只限延迟一次。
    ONBUILD 的使用情景是在建立镜像时取得最新的源码 (搭配 RUN) 与限定系统框架。

- ARG
    ARG是Docker1.9 版本才新加入的指令。
    ARG 定义的变量只在建立 image 时有效，建立完成后变量就失效消失

- LABEL
    定义一个 image 标签 Owner，并赋值，其值为变量 Name 的值。(LABEL Owner=$Name )

- ENTRYPOINT
    是指定 Docker image 运行成 instance (也就是 Docker container) 时，要执行的命令或者文件。
    Container启动时执行的命令，但是一个Dockerfile中只能有一条ENTRYPOINT命令，如果多条，则只执行最后一条

- WORKDIR /webapi                         #切换目录用，可以多次切换(相当于cd命令)，对RUN,CMD,ENTRYPOINT生效


## 常用命令：
### 镜像
1. 拉取镜像：docker pull <镜像名:tag>
1. 查看所有镜像：docker images
1. 删除指定镜像：docker rmi <镜像名or IMAGE ID>
1. 删除所有镜像：docker rmi $(docker images | grep none | awk '{print $3}' | sort -r)
1. 构建自己的镜像：docker build -t <镜像名> <Dockerfile路径>
    例：docker build -t webapp .

### 容器
1. 查看正在运行的容器：docker ps
1. 查看所有容器：docker ps -a
1. 启动新容器，同时为它命名、端口映射、文件夹映射
    例：docker run --name webapp-1 -p 8000:80 -d webapp-image
1. 后台运行(-d)、并暴露端口(-p)
    例：docker run -d -p 127.0.0.1:33301:22 centos6-ssh
1. 删除所有容器：docker rm $(docker ps -a -q)
1. 删除单个容器：docker rm <容器名orID>
1. 启动一个容器：docker start <容器名orID>
1. 停止一个容器：docker stop <容器名orID>
1. 杀死一个容器：docker kill <容器名orID>
1. 查看容器日志：docker logs -f <容器名orID>
