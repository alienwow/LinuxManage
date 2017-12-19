查看是否已经安装vsftpd
#rpm -qa | grep vsftpd

如果没有，就安装，并设置开机启动
#yum -y install vsftpd

管理vsftpd相关命令：
    启动vsftpd:  service vsftpd start
    停止vsftpd:  service vsftpd stop
    重启vsftpd:  service vsftpd restart

开机启动
    chkconfig vsftpd on

配置防火墙
    #-A INPUT -m state --state NEW -m tcp -p tcp --dport 21 -j ACCEPT
    
添加用户
    useradd -d /home/wwwroot/quietly -g ftp -s /sbin/nologin quietlyftp
    chmod -R 744 /home/wwwroot/quietly
    passwd quietlyftp #密码abcd-1234
创建目录与日志
    mkdir -p /data/vsftpd/logs
    mkdir -p /data/vsftpd/data
    touch /data/vsftpd/logs/xferlog
    chown -R ftp:ftp /data/vsftpd
    chmod -R 744 /data/vsftpd
    

    
配置vsftpd服务器
    #vi /etc/vsftpd/vsftpd.conf
去掉注释
将chroot_list_enable=YES与chroot_list_file=/etc/vsftpd/chroot_list

