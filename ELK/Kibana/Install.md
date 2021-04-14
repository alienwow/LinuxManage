# 安装 Kibana

## 部署 kibana

```bash

docker pull kibana:7.11.1

mkdir -p /Users/vito/data/kibana/config/
touch /Users/vito/data/kibana/config/kibana.yml

# kibana 配置
echo "
# Default Kibana configuration for docker target
server.name: kibana
server.host: \"0\"
elasticsearch.hosts: [\"http://172.11.80.69:9201\",\"http://172.11.80.69:9202\",\"http://172.11.80.69:9203\"]
elasticsearch.username: \"kibana\"
elasticsearch.password: \"h\!I\!Nq5WQJdGM81HxTF*%B\$c\$kGQx&61\"
"> /Users/vito/data/kibana/config/kibana.yml

# kibana 配置
echo "
# Default Kibana configuration for docker target
server.name: kibana
server.host: \"0\"
elasticsearch.hosts: [\"http://192.168.1.100:9201\",\"http://192.168.1.100:9202\",\"http://192.168.1.100:9203\"]
elasticsearch.username: \"kibana\"
elasticsearch.password: \"h\!I\!Nq5WQJdGM81HxTF*%B\$c\$kGQx&61\"
"> /Users/vito/data/kibana/config/kibana.yml

docker stop kibana
docker rm kibana

docker run \
--name kibana \
-e "TZ=Asia/Shanghai" \
--log-driver json-file \
--log-opt max-size=100m \
--log-opt max-file=2 \
-p 5601:5601 \
-v /Users/vito/data/kibana/config/kibana.yml:/usr/share/kibana/config/kibana.yml \
-d kibana:7.11.1

```
