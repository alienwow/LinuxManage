
# 启动 centos 容器

docker run \
--name centos-vscode \
-v ~/repos:/root/repos/ \
-it \
centos:7.6.1810 \
/bin/bash



docker run \
--name vscode3.0 \
-v ~/repos:/root/repos/ \
-it \
ubuntu-aspnetcore:3.0 \
/bin/bash

docker run \
--name vscode2.2 \
-v ~/repos:/root/repos/ \
-it \
ubuntu-aspnetcore:2.2 \
/bin/bash

docker build -f sdk3.0.Dockerfile --rm -t ubuntu-aspnetcore:3.0 .

docker build -f sdk2.2.Dockerfile --rm -t ubuntu-aspnetcore:2.2 .
