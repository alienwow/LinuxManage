# 安装 logstash

## 部署 logstash

```bash

docker pull logstash:7.11.1

mkdir -p /Users/vito/data/logstash/config/
touch /Users/vito/data/logstash/config/logstash.yml

# logstash 配置
echo "
// 0.0.0.0：允许任何IP访问
http.host: \"0.0.0.0\"
// 配置elasticsearch集群地址
xpack.monitoring.elasticsearch.hosts: [\"http://172.11.80.69:9201\",\"http://172.11.80.69:9202\",\"http://172.11.80.69:9203\"]
// 允许监控
xpack.monitoring.enabled: true
// 启动时读取配置文件指定
path.config: /usr/share/logstash/config/logstash.conf
"> /Users/vito/data/logstash/config/logstash.yml

# logstash 配置
echo "
// 0.0.0.0：允许任何IP访问
http.host: \"0.0.0.0\"
// 配置elasticsearch集群地址
elasticsearch.hosts: [\"http://192.168.1.100:9201\",\"http://192.168.1.100:9202\",\"http://192.168.1.100:9203\"]
// 允许监控
xpack.monitoring.enabled: true
// 启动时读取配置文件指定
path.config: /usr/share/logstash/config/logstash.conf
"> /Users/vito/data/logstash/config/logstash.yml

```

https://www.kancloud.cn/devops-centos/centos-linux-devops/397460

https://juejin.cn/post/6844904049079222286

