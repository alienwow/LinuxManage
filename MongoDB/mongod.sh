#!/bin/bash 
# 
# Init file for mongod 
# 
# chkconfig: - 80 12 
# description: mongod 
# 
# processname: mongod 
# config: /etc/mongod.conf
# pidfile: /data/mongod/mongod.pid

source /etc/init.d/functions
BIN="/walkingtec/mongodb/bin"
CONFIG="/etc/mongodb.conf"
PIDFILE="/data/mongodb/mongodb.pid"
### Read configuration 
[ -r "$SYSCONFIG" ] && source "$SYSCONFIG" 
RETVAL=0 
prog="mongod" 
desc="MongoDB" 
start() { 
        if [ -e $PIDFILE ];then 
             echo "$desc already running...." 
             exit 1 
        fi 
        echo -n $"Starting $desc: " 
        daemon $BIN/$prog --config=$CONFIG 
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
  status) 
        status $prog 
        RETVAL=$? 
        ;; 
   *) 
        echo $"Usage: $0 {start|stop|restart|status}" 
        RETVAL=1 
esac 
export PATH=$BIN:$PATH
exit $RETVAL