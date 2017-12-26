#!/bin/bash
#
# Init file for Nginx
#
# chkconfig: - 80 12
# description: Nginx daemon
#
# processname: nginx
# config: /walkingtec/nginx/nginx.conf
# pidfile: /data/nginx/nginx.pid

source /etc/init.d/functions
BIN="/walkingtec/nginx/sbin"
CONFIG="/walkingtec/nginx/nginx.conf"
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
reload() {
      echo $"Reload $desc: "
      $BIN/$prog -s reload
      echo $"Reload $desc: success!"
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
reload)
      reload
      RETVAL=1
      ;;
status)
      status $prog
      RETVAL=$?
      ;;
*)
      echo $"Usage: $0 {start|stop|restart|reload|status}"
      RETVAL=1
esac
export PATH=$BIN:$PATH
exit $RETVAL