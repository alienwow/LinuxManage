## 依赖性检查
```bash
# Docker需要一个64位系统的红帽系统，内核的版本必须大于3.10。可以用下面的命令来检查是否满足docker的要求。
# 3.10.0-229.el7.x86_64
uname -r
```

## 使用安装脚本安装
```bash
# 1、使用一个有sudo权限的帐号登录红帽系统。

# 2、更新现有的yum包。
sudo yum update

# 3、执行docker安装脚本。
curl -sSL https://get.docker.com/ | sh 

# 4、启动docker服务。
# 启动
sudo service docker start

# 5、确认docker安装成功。
sudo docker run hello-world
#Unable to find image 'hello-world:latest' locally
#latest: Pulling from hello-world
#a8219747be10: Pull complete 91c95931e552: Already exists 
#hello-world:latest: The image you are pulling has been verified. Important: image verification is a tech preview feature and should not be relied on to provide security. Digest: sha256:aa03e5d0d5553b4c3473e89c8619cf79df368babd1.7.1cf5daeb82aab55838d
#Status: Downloaded newer image for hello-world:latest
#Hello from Docker.
#This message shows that your installation appears to be working correctly.
#To generate this message, Docker took the following steps: 1. The Docker client contacted the Docker daemon. 2. #The Docker daemon pulled the "hello-world" image from the Docker Hub.
#        (Assuming it was not already locally available.) 3. The Docker daemon created a new container from that image which runs the executable that produces the output you are currently reading. 4. The Docker daemon streamed that output to the Docker client, which sent it to your terminal.

#To try something more ambitious, you can run an Ubuntu container with:
# $ docker run -it ubuntu bash
#For more examples and ideas, visit: http://docs.docker.com/userguide/

```

## yum安装
```bash
# 更新系统
sudo yum update

# 卸载旧版本(如果安装过旧版本的话)
sudo yum remove docker  docker-common docker-selinux docker-engine

# 安装需要的软件包， yum-util 提供yum-config-manager功能，另外两个是devicemapper驱动依赖的
sudo yum install -y yum-utils device-mapper-persistent-data lvm2

# 设置yum源
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

# 可以查看所有仓库中所有docker版本，并选择特定版本安装
yum list docker-ce --showduplicates | sort -r

# 安装docker
sudo yum install docker-ce  #由于repo中默认只开启stable仓库，故这里安装的是最新稳定版17.12.0
sudo yum install <FQPN>  # 例如：sudo yum install docker-ce-17.12.0.ce

# 启动并加入开机启动
sudo systemctl start docker
sudo systemctl enable docker

# 验证安装是否成功(有client和service两部分表示docker安装启动都成功了)
docker version

```

## 配置 docker
```bash
# docker的默认配置文件路径是 /etc/docker/daemon.json
# 默认不存在需要手动创建
mkdir -p /etc/docker
tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": ["https://registry.docker-cn.com","https://ljcq9oc9.mirror.aliyuncs.com"]
}
EOF
systemctl daemon-reload
service docker restart
```

## 添加用户及群组
```bash
useradd -g docker -s /sbin/nologin docker
sudo usermod -aG docker docker
```

## docker服务自动启动
```bash
systemctl enable docker.service
```

## 卸载docker
```bash
# 1、列出docker包的具体的名字。
yum list installed | grep docker
docker-engine.x86_64 1.7.1-0.1.el7

# 2、删除docker。
sudo yum -y remove docker-engine.x86_64 
# 备注：该命令只是删除docker运行环境，并不会删除镜像，容器，卷文件，以及用户创建的配置文件。

# 3、清除镜像和容器文件。
rm -rf /var/lib/docker

# 4、手工查找并删除用户创建的配置文件。

```