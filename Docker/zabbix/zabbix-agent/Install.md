# 安装 zabbix agent

在下面找到要安装的agent `https://repo.zabbix.com/zabbix/5.4/rhel/7/x86_64/`

可以看到现在存在两个版本的agent：

1. zabbix-agent-5.4.0-8.el7.x86_64.rpm: 原始版本的agent
1. zabbix-agent2-5.4.0-8.el7.x86_64.rpm: agent2 是 Zabbix 5.0 版本推出的使用 go 语言重写的 agent2

建议使用 go版本重写的 agent2，另外不允许两个版本的agent同时安装。

```bash

cd /data
wget https://repo.zabbix.com/zabbix/5.4/rhel/7/x86_64/zabbix-agent2-5.4.0-8.el7.x86_64.rpm
     https://repo.zabbix.com/zabbix/5.3/rhel/8/x86_64/zabbix-release-5.3-1.el8.noarch.rpm

rpm -Uvh zabbix-agent2-5.4.0-8.el7.x86_64.rpm

# 修改配置文件
cat /etc/zabbix/zabbix_agent2.conf

service zabbix-agent2 restart

# 设置开机启动
systemctl enable --now zabbix-agent2

```
