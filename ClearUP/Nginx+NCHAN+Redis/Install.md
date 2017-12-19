安装说明
系统环境：CentOS-6.3
软件：nginx-1.2.6.tar.gz
安装方式：源码编译安装
安装位置：/usr/local/nginx
下载地址：http://nginx.org/en/download.html



#################安装前提###############################
1、支持rewrite，安装pcre: yum install pcre*
2、支持ssl，安装openssl:yum install openssl*

#在安装nginx前，统需要确保系安装了g++、gcc、openssl-devel、pcre-devel和zlib-devel软件。
#安装必须软件：
yum -y install wget gcc-c++ zlib zlib-devel openssl openssl-devel pcre pcre-devel

#卸载原有的Nginx：
yum remove nginx

groupadd nginx
useradd -g nginx -s /sbin/nologin nginx

##################安装##############################
#               开始安装
##################安装##############################
将安装包文件上传到/litsoft中执行以下操作：
cd /softwares
#wget http://nginx.org/download/nginx-1.9.1.tar.gz
tar -xzf nginx-1.10.0.tar.gz
cd /softwares/nginx-1.10.0

#--with-ngx_http_headers_module
./configure \
--prefix=/litsoft/nginx \
--conf-path=/litsoft/nginx/nginx.conf \
--with-http_ssl_module \
--with-http_stub_status_module \
--add-module=/softwares/nchan-master
make & make install


##################配置##############################
#修改防火墙配置：
vi  /etc/sysconfig/iptables
#-A INPUT -m state --state NEW -m tcp -p tcp --dport 80 -j ACCEPT
service iptables restart

##################创建目录###############################
mkdir -p /data/nginx/logs/
touch /data/nginx/logs/error.log
touch /data/nginx/logs/access.log

chown -R nginx:nginx /data/nginx
chmod -R 755 /data/nginx



#############启动脚本
vi /etc/init.d/nginx

#!/bin/bash
#
# Init file for Nginx
#
# chkconfig: - 80 12
# description: Nginx daemon
#
# processname: nginx
# config: /litsoft/nginx/nginx.conf
# pidfile: /data/nginx/nginx.pid

source /etc/init.d/functions
BIN="/litsoft/nginx/sbin"
CONFIG="/litsoft/nginx/nginx.conf"
PIDFILE="/data/nginx/nginx.pid"
### Read configuration
[ -r "$SYSCONFIG" ] && source "$SYSCONFIG"
RETVAL=0
prog="nginx"
desc="Nginx Server"
start() {
        if [ -e $PIDFILE ];then
             echo "$desc already running...."
             exit 1
        fi
        echo -n $"Starting $desc: "
        daemon $BIN/$prog -c $CONFIG
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
export PATH=$BIN:$PATH
exit $RETVAL


然后增加服务并开机自启动：
chmod 755 /etc/init.d/nginx
chkconfig --add nginx
chkconfig --level 345 nginx on





##################启动###############################
方法1
/litsoft/nginx/sbin/nginx -c /litsoft/nginx/nginx.conf
#方法2
cd /litsoft/nginx/sbin
./nginx

###############停止##################################
#查询nginx主进程号
ps -ef | grep nginx
#停止进程
kill -QUIT 主进程号
#快速停止
kill -TERM 主进程号
#强制停止
pkill -9 nginx

###############重启##################################
/litsoft/nginx/sbin/nginx -s reload