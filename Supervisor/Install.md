## 1、安装
```bash
mkdir -p /data/logs
yum install python-setuptools
easy_install pip
pip install supervisor
# 卸载
pip uninstall supervisor
```

## 2、配置
```bash
mkdir -p /sundot/supervisor/conf
echo_supervisord_conf > /sundot/supervisor/supervisord.conf

###########配置#####################
[include]
files = /sundot/supervisor/conf/*.conf
################################

# 启动 Supervisor 服务
supervisord -c /sundot/supervisor/supervisord.conf

# 进入 Supervisor 命令行界面
supervisorctl -c /sundot/supervisor/supervisord.conf

# 使配置文件生效
supervisorctl -c /sundot/supervisor/supervisord.conf reload
```

## 3、设置 supervisor 开机启动
```bash
# 方式1
    # 进入/lib/systemd/system目录，并创建supervisor.service文件
    touch /lib/systemd/system/supervisor.service
    chmod 766 /lib/systemd/system/supervisor.service
    vi /lib/systemd/system/supervisor.service

    # 设置开机启动
    systemctl enable supervisor.service
    # CentOS7下要重新加载
    systemctl daemon-reload


# 方式2
    # 设置service
    touch /etc/rc.d/init.d/supervisor
    chmod 755 /etc/rc.d/init.d/supervisor
    vi /etc/rc.d/init.d/supervisor

    # CentOS7下要重新加载
    systemctl daemon-reload

    # 设置开机启动
    chkconfig supervisor on

```