# 安装 filebeat

## 部署 filebeat

```bash

# 官方镜像
docker pull docker.elastic.co/beats/filebeat:7.11.1

docker pull elastic/filebeat:7.11.1


# docker stop filebeat
# docker rm filebeat

# docker run \
# --name filebeat \
# -e "TZ=Asia/Shanghai" \
# -d elastic/filebeat:7.11.1 \
# setup -E setup.kibana.host=172.11.80.69:5601 \
# -E "output.elasticsearch.hosts=[\"172.11.80.69:9201\",\"172.11.80.69:9202\",\"172.11.80.69:9203\"]" \
# -E "output.elasticsearch.username=elastic" \
# -E "output.elasticsearch.password=h\!I\!Nq5WQJdGM81HxTF*%B\$c\$kGQx&61"


docker stop filebeat
docker rm filebeat

docker run \
--name filebeat \
--user root \
-e "TZ=Asia/Shanghai" \
-v /Users/vito/data/filebeat/:/var/log/:ro \
-v /Users/vito/data/filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml \
-v /Users/vito/data/filebeat/nginx.yml:/usr/share/filebeat/modules.d/nginx.yml \
-d elastic/filebeat:7.11.1


docker stop filebeat
docker rm filebeat

docker run \
--name filebeat \
--user root \
-e "TZ=Asia/Shanghai" \
-v /Users/vito/data/filebeat/:/var/log/:ro \
-v /Users/vito/data/filebeat/filebeat.yml:/usr/share/filebeat/filebeat.yml \
-d elastic/filebeat:7.11.1


```
