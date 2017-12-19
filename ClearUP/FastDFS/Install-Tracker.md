#创建用户与组：
groupadd fastdfs
useradd -g fastdfs -s /sbin/nologin fdfs
#创建目录
mkdir -p /data/fastdfs/logs
mkdir -p /data/fastdfs/tracker
mkdir -p /data/fastdfs/client
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

vi /etc/fdfs/tracker.conf
vi /etc/fdfs/client.conf
设置
tracker.conf配置中要修改的几个项：
base_path=/data/fastdfs/tracker
bind_addr=192.168.137.103
port=22122
http.server_port=8080

同时将以下两个文件复制到/etc/fdfs/
cp /walkingtec/fastdfs/conf/http.conf /etc/fdfs/
cp /walkingtec/fastdfs/conf/mime.types /etc/fdfs/


启动脚本
vi /etc/init.d/fdfs-tracker

#!/bin/bash
#
# Init file for FastDFS
#
# chkconfig: - 80 12
# description: FastDFS-TrackerServer
#
# processname: fdfs-tracker
# config: /etc/fdfs/tracker.conf
# pidfile: /data/fastdfs/tracker/data/fdfs_trackerd.pid

source /etc/init.d/functions
BIN="/usr/bin/"
CONFIG="/etc/fdfs/tracker.conf"
PIDFILE="/data/fastdfs/tracker/data/fdfs_trackerd.pid"
### Read configuration
[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"
RETVAL=0
prog="fdfs_trackerd"
desc="FastDFS-TrackerServer "
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

然后增加服务并开机自启动：
chmod 755 /etc/init.d/fdfs-tracker
chkconfig --add fdfs-tracker
chkconfig --level 345 fdfs-tracker on
chkconfig --list fdfs-tracker