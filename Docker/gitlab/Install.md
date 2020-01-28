# 安装 GitLab

```bash

# 创建目录
mkdir -p /Users/vito/data/gitlab/repos
# For storing application data
mkdir -p /Users/vito/data/gitlab/data
# For storing logs
mkdir -p /Users/vito/data/gitlab/logs
# For storing the GitLab configuration files
mkdir -p /Users/vito/data/gitlab/config

# 拉取最新的官方 gitlab/gitlab-ce 镜像
docker pull gitlab/gitlab-ce:latest

docker run --detach \
--hostname git.alienwow.cc \
--publish 443:443 --publish 80:80 --publish 22:22 \
--name gitlab \
--restart always \
--volume Users/vito/data/gitlab/config:/etc/gitlab \
--volume Users/vito/data/gitlab/logs:/var/log/gitlab \
--volume Users/vito/data/gitlab/data:/var/opt/gitlab \
gitlab/gitlab-ce:latest



docker run -d \
--name gitlab \
gitlab/gitlab-ce:latest \
-p 443:443 \
-p 80:80 \
-p 22:22 \
-v Users/vito/data/gitlab/config:/etc/gitlab \
-v Users/vito/data/gitlab/logs:/var/log/gitlab \
-v Users/vito/data/gitlab/data:/var/opt/gitlab

docker run -d \
--name gitlab \
gitlab/gitlab-ce:latest \
-p 443:443 \
-p 80:80 \
-p 22:22



```