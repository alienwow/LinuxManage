## Install
```bash
# 1.
yum install goaccess

# 2.
cd /softwares
wget https://tar.goaccess.io/goaccess-1.2.tar.gzc
tar -xzvf goaccess-1.2.tar.gz
cd /softwaresgoaccess-1.2/
./configure --enable-utf8 --enable-geoip=legacy
make
make install

# 打开防火墙
firewall-cmd --zone=public --add-port=7890/tcp --permanent
firewall-cmd --reload
```

## 基本信息
```bash
# 默认配置文件
/etc/goaccess.conf
```

## 使用
```bash

goaccess /data/nginx/logs/com.stonemonth.tjise.api.log -o /data/websites/goaccess/tjise.html --log-format=COMBINED --real-time-html --ws-url=apitest.stonemonth.com:80

--port=80

```


cat /data/nginx/logs/com.stonemonth.tjise.api.log  | awk '{print substr($4,14,5)}' | uniq -c | awk '{print $2","$1}' > access.csv