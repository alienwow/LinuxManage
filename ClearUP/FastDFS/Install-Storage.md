#创建用户与组：
groupadd fastdfs
useradd -g fastdfs -s /sbin/nologin fdfs
#创建目录
mkdir -p /data/fastdfs/logs
mkdir -p /data/fastdfs/storage
mkdir -p /data/fastdfs/client
touch /data/fastdfs/logs/mod_fastdfs.log
chown -R fdfs:fastdfs /data/fastdfs
chmod -R 755 /data/fastdfs

#1、安装libfastcommon：
cd /softwares
tar -zxf libfastcommon-1.0.7.tar.gz
mv libfastcommon-1.0.7 /walkingtec/libfastcommon
cd /walkingtec/libfastcommon
./make.sh
./make.sh install

#libfastcommon.so默认安装到了/usr/lib64/libfastcommon.so，而FastDFS主程序设置的lib目录是/usr/local/lib，所以设置软连接
ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so


#2、安装FastDFS:
cd /softwares
tar -zxf FastDFS_v5.05.tar.gz
mv /softwares/FastDFS /walkingtec/fastdfs
cd /walkingtec/fastdfs
./make.sh
./make.sh install
cd /etc/fdfs

#配置文件设置： 导入配置文件
#cp tracker.conf.sample tracker.conf
#cp storage.conf.sample storage.conf
#cp client.conf.sample client.conf

设置
storage.conf配置中要修改的几个项：
group_name=g1
bind_addr=192.168.137.104
port=23000
base_path=/data/fastdfs/storage
store_path0=/data/fastdfs/storage
tracker_server=192.168.137.103:22122
http.server_port=8080

启动storage
fdfs_storaged /etc/fdfs/storage.conf

3、安装nginx插件：
    cd /softwares/fastdfs
    tar -zxf fastdfs-nginx-module_v1.16.tar.gz
    mv /softwares/fastdfs/fastdfs-nginx-module /walkingtec/fastdfs-nginx-module
    cd /walkingtec/fastdfs-nginx-module/src
config文件修改：
    vi config
    修改如下配置，我这里原来是
CORE_INCS="$CORE_INCS /usr/local/include/fastdfs /usr/local/include/fastcommon/"
改成
CORE_INCS="$CORE_INCS /usr/include/fastdfs /usr/include/fastcommon/"
这个是很重要的，不然在nginx编译的时候会报错的，我看网上很多在安装nginx的fastdfs的插件报错，都是这个原因，而不是版本不匹配。

cp  /walkingtec/fastdfs-nginx-module/mod_fastdfs.conf /etc/fdfs

修改配置
vi /etc/fdfs/mod_fastdfs.conf
group_name=g1
tracker_server=192.168.137.103:22122
store_path0=/data/fastdfs/storage
base_path=/data/fastdfs/storage
url_have_group_name = true

配置文件服务器的软连接
ln -s /data/fastdfs/storage/data /data/fastdfs/storage/data/M00  (配置文件中stoage存放数据的路径)

同时将以下两个文件复制到/etc/fdfs/
cp /walkingtec/fastdfs/conf/http.conf /etc/fdfs/
cp /walkingtec/fastdfs/conf/mime.types /etc/fdfs/

4、nginx安装：
yum install pcre*
yum install openssl*
yum install zlib

->调到Nginx安装

最后在在server中添加
location /g1/M00{
    root /data/fastdfs/storage;
    ngx_fastdfs_module;
}


启动脚本
#vi /etc/init.d/fdfs-storage

#!/bin/bash
#
# Init file for FastDFS
#
# chkconfig: - 80 12
# description: FastDFS-StorageServer
#
# processname: fdfs-storage
# config: /etc/fdfs/storage.conf
# pidfile: /data/fastdfs/storage/data/fdfs_storaged.pid

source /etc/init.d/functions
BIN="/usr/bin"
CONFIG="/etc/fdfs/storage.conf"
PIDFILE="/data/fastdfs/storage/data/fdfs_storaged.pid"
### Read configuration
[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"
RETVAL=0
prog="fdfs_storaged"
desc="FastDFS-StorageServer "
start() {
        if [ -e $PIDFILE ];then
             echo "$desc already running...."
             exit 1
        fi
        echo -n $"Starting $desc: "
        daemon $BIN/$prog $CONFIG
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && touch /var/lock/subsys/$prog
        return $RETVAL
}
stop() {
        echo -n $"Stop $desc: "
        killproc $prog
        RETVAL=$?
        echo
        [ $RETVAL -eq 0 ] && rm -f /var/lock/subsys/$prog $PIDFILE
        return $RETVAL
}
restart() {
        stop
        start
}
case "$1" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  restart)
        restart
        ;;
  condrestart)
        [ -e /var/lock/subsys/$prog ] && restart
        RETVAL=$?
        ;;
  status)
        status $prog
        RETVAL=$?
        ;;
   *)
        echo $"Usage: $0 {start|stop|restart|condrestart|status}"
        RETVAL=1
esac
exit $RETVAL

#然后增加服务并开机自启动：
chmod 755 /etc/init.d/fdfs-storage
chkconfig --add fdfs-storage
chkconfig --level 345 fdfs-storage on
chkconfig --list fdfs-storage


检测storage服务器
fdfs_monitor /etc/fdfs/storage.conf
删除storage服务器
fdfs_monitor /etc/fdfs/client.conf delete g1 115.29.249.16

pics1.silentwind.com.cn/g1/M00/00/00/wKiJZlWfwj2AMqKsAALPMZVjMKc307.jpg