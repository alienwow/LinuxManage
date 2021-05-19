# 安装 Zabbix 服务端

## 安装 zabbix-server

```bash

# 在mysql服务器上创建用户并授权即可，无须创建对应数据库

# 创建目录
mkdir -p /data/docker/container/zabbix/zabbix
mkdir -p /data/docker/container/zabbix/alertscripts
mkdir -p /data/docker/container/zabbix/externalscripts
mkdir -p /data/docker/container/zabbix/modules
mkdir -p /data/docker/container/zabbix/enc
mkdir -p /data/docker/container/zabbix/ssh_keys
mkdir -p /data/docker/container/zabbix/ssl/certs
mkdir -p /data/docker/container/zabbix/ssl/keys
mkdir -p /data/docker/container/zabbix/ssl/ssl_ca
mkdir -p /data/docker/container/zabbix/snmptraps
mkdir -p /data/docker/container/zabbix/export
mkdir -p /data/docker/container/zabbix/mibs

# 拉取最新的官方 zabbix 镜像
# zabbix服务
docker pull zabbix/zabbix-server-mysql:5.4-alpine-latest
# web界面
docker pull zabbix/zabbix-web-nginx-mysql:5.4-alpine-latest

docker stop zabbix-srv
docker rm zabbix-srv

docker run \
-p 10051:10051 \
--name zabbix-srv -t \
--restart always \
-e DB_SERVER_HOST="internal-mysql.xuantong.cn" \
-e DB_SERVER_PORT="7002" \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e MYSQL_PASSWORD="qqWOLdyPnW6taFjL5WVq" \
-e MYSQL_ROOT_PASSWORD="abcd-1234" \
-e PHP_TZ="Asia/Shanghai" \
-e "TZ=Asia/Shanghai" \
-d zabbix/zabbix-server-mysql:5.4-alpine-latest

# 复制配置
docker cp zabbix-srv:/etc/zabbix /data/docker/container/zabbix/
docker cp zabbix-srv:/usr/lib/zabbix/alertscripts /data/docker/container/zabbix/
docker cp zabbix-srv:/usr/lib/zabbix/externalscripts /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/modules /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/enc /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/ssh_keys /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/ssl/certs /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/ssl/keys /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/ssl/ssl_ca /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/snmptraps /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/export /data/docker/container/zabbix/
docker cp zabbix-srv:/var/lib/zabbix/mibs /data/docker/container/zabbix/

docker stop zabbix-srv
docker rm zabbix-srv

# 启动 zabbix-srv
docker run \
-p 10051:10051 \
--name zabbix-srv -t \
--restart always \
-e DB_SERVER_HOST="internal-mysql.xuantong.cn" \
-e DB_SERVER_PORT="7002" \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e MYSQL_PASSWORD="qqWOLdyPnW6taFjL5WVq" \
-e MYSQL_ROOT_PASSWORD="abcd-1234" \
-e PHP_TZ="Asia/Shanghai" \
-e "TZ=Asia/Shanghai" \
-v /data/docker/container/zabbix/zabbix:/etc/zabbix \
-v /data/docker/container/zabbix/alertscripts:/usr/lib/zabbix/alertscripts \
-v /data/docker/container/zabbix/externalscripts:/usr/lib/zabbix/externalscripts \
-v /data/docker/container/zabbix/modules:/var/lib/zabbix/modules \
-v /data/docker/container/zabbix/enc:/var/lib/zabbix/enc \
-v /data/docker/container/zabbix/ssh_keys:/var/lib/zabbix/ssh_keys \
-v /data/docker/container/zabbix/ssl/certs:/var/lib/zabbix/ssl/certs \
-v /data/docker/container/zabbix/ssl/keys:/var/lib/zabbix/ssl/keys \
-v /data/docker/container/zabbix/ssl/ssl_ca:/var/lib/zabbix/ssl/ssl_ca \
-v /data/docker/container/zabbix/snmptraps:/var/lib/zabbix/snmptraps \
-v /data/docker/container/zabbix/export:/var/lib/zabbix/export \
-v /data/docker/container/zabbix/mibs:/var/lib/zabbix/mibs \
-d zabbix/zabbix-server-mysql:5.4-alpine-latest


# /usr/lib/zabbix/alertscripts：该卷用于保存自定义警报脚本，它是AlertScriptsPath参数zabbix_server.conf
# /usr/lib/zabbix/externalscripts：外部检查（项目类型）使用该卷，它是ExternalScripts参数zabbix_server.conf
# /etc/zabbix：该卷用于保存zabbix-server端的配置文件
# /var/lib/zabbix/modules：该卷允许加载其他模块并使用LoadModule功能扩展Zabbix服务器。
# /var/lib/zabbix/enc：该卷用于存储TLS相关文件。这些文件的名称使用规定ZBX_TLSCAFILE，ZBX_TLSCRLFILE，ZBX_TLSKEY_FILE和ZBX_TLSPSKFILE变量。
# /var/lib/zabbix/ssh_keys：该卷用作SSH检查和操作的公钥和私钥的位置。它是SSHKeyLocation参数zabbix_server.conf。
# /var/lib/zabbix/ssl/certs：该卷用作客户端身份验证的SSL客户端证书文件的位置。它是SSLCertLocation参数zabbix_server.conf。
# /var/lib/zabbix/ssl/keys：该卷用作客户端身份验证的SSL私钥文件的位置。它是SSLKeyLocation参数zabbix_server.conf。
# /var/lib/zabbix/ssl/ssl_ca：该卷用作SSL服务器证书验证的证书颁发机构（CA）文件的位置。它是SSLCALocation参数zabbix_server.conf。
# /var/lib/zabbix/snmptraps：该卷用作snmptraps.log文件的位置。它可以由zabbix-snmptraps容器共享，并volumes_from在创建Zabbix服务器的新实例时使用Docker选项继承。可以使用共享卷和交换ZBX_ENABLE_SNMP_TRAPS环境变量来启用SNMP陷阱处理功能true。
# /var/lib/zabbix/mibs：该卷允许添加新的MIB文件。它不支持子目录，必须放置所有MIB /var/lib/zabbix/mibs
# 备注：通常会用到的是存放脚本的路径和配置文件的路径


```

## 安装 zabbix-web

```bash

# 启用 zabbix-web
docker stop zabbix-web
docker rm zabbix-web

docker run \
-p 8087:8080 \
--name zabbix-web -t \
--restart always \
-e DB_SERVER_HOST="internal-mysql.xuantong.cn" \
-e DB_SERVER_PORT="7002" \
-e MYSQL_DATABASE="zabbix" \
-e MYSQL_USER="zabbix" \
-e MYSQL_PASSWORD="qqWOLdyPnW6taFjL5WVq" \
-e MYSQL_ROOT_PASSWORD="abcd-1234" \
-e PHP_TZ="Asia/Shanghai" \
-e "TZ=Asia/Shanghai" \
-e ZBX_SERVER_HOST="internal-zabbix.xuantong.cn" \
-e ZBX_SERVER_PORT="10051" \
-d zabbix/zabbix-web-nginx-mysql:5.4-alpine-latest

# 默认密码：Admin/zabbix

```

## 解决 zabbix-web 乱码问题

```bash
# 下载字体simkai.ttf

# 拷贝字体到docker 容器内部
docker cp /data/simkai.ttf zabbix-web:/usr/share/zabbix/assets/fonts/

# 通过超管权限进去进入容器
docker exec -it -u root zabbix-web /bin/sh

# 备份以前的字体文件
mv /usr/share/zabbix/assets/fonts/DejaVuSans.ttf /usr/share/zabbix/assets/fonts/DejaVuSans.ttf_bak

# 链接
ln -s simkai.ttf DejaVuSans.ttf
```
