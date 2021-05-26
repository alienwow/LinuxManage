# 安装 logstash

## 部署 logstash

```bash

docker pull logstash:7.11.1

mkdir -p /Users/vito/data/logstash/config/
mkdir -p /Users/vito/data/logstash/pipeline/
mkdir -p /Users/vito/data/logstash/patterns/

docker stop logstash
docker rm logstash

docker run \
--name logstash \
-e "TZ=Asia/Shanghai" \
-p 5044:5044 \
-p 9600:9600 \
-v /Users/vito/data/logstash/pipeline/:/usr/share/logstash/pipeline/ \
-v /Users/vito/data/logstash/config/:/usr/share/logstash/config/ \
-v /Users/vito/data/logstash/patterns/:/usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/logstash-patterns-core-4.1.2/patterns/ \
-d logstash:7.11.1

/usr/share/logstash/vendor/bundle/jruby/2.5.0/gems/logstash-patterns-core-4.1.2/patterns/

# grok 调试工具
https://grokdebug.herokuapp.com/

```

## grok

```bash

172.11.80.69 - - [25/May/2021:15:38:11 +0800] "GET /core/api/videoshares?pageSize=10 HTTP/1.1" 200 6974 - "https://testing.xuantong.cn/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36 Edg/90.0.818.56" "172.11.80.69" "0.069" "172.11.80.16:18001" "0.069"



%{IPV4:remote_addr} - (%{USERNAME:user}|-) \[%{HTTPDATE:timestamp}\] "((%{WORD:request_method}|-) (%{URIPATH1:request_path}|-)(%{URIPARM1:request_params}|-)(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:statuscode} (?:%{NUMBER:body_bytes_sent}|-) (?:%{DATA:request_body}|-) %{QS:http_referer} %{QS:http_user_agent} %{QS:proxy_add_x_forwarded_for} "%{NUMBER:request_time}" "%{HOSTPORT1:upstream_addr}" "%{NUMBER:upstream_response_time}"

别人的
URIPARM1 [A-Za-z0-9$.+!*'|(){},~@#%&/=:;^\\_<>`?\-\[\]]*
URIPATH1 (?:/[\\A-Za-z0-9$.+!*'(){},~:;=@#%\[\]_<>^\-&?]*)+
HOSTNAME1 \b(?:[0-9A-Za-z_\-][0-9A-Za-z-_\-]{0,62})(?:\.(?:[0-9A-Za-z_\-][0-9A-Za-z-:\-_]{0,62}))*(\.?|\b)
STATUS ([0-9.]{0,3}[, ]{0,2})+
HOSTPORT1 (%{IPV4}:%{POSINT}[, ]{0,2})+
FORWORD (?:%{IPV4}[,]?[ ]?)+|%{WORD}



%{IPV4:remote_addr} - (%{USERNAME:user}|-) \[%{HTTPDATE:timestamp}\] "((%{WORD:request_method}|-) (%{URIPATH1:request_path}|-)(\?%{URIPARM1:request_params}|-)(?: HTTP/%{NUMBER:httpversion})?|%{DATA:rawrequest})" %{NUMBER:statuscode} (?:%{NUMBER:body_bytes_sent}|-) (?:%{DATA:request_body}|-) %{QS:http_referer} %{QS:http_user_agent} %{QS:proxy_add_x_forwarded_for} "%{NUMBER:request_time}" "%{HOSTPORT1:upstream_addr}" "%{NUMBER:upstream_response_time}"

自定义：
URIPARM1 [A-Za-z0-9$.+!*'(),~@#%&/=:;^\_?-\[\]]*
URIPATH1 (?:/[A-Za-z0-9$.+!*'(),~@#%&/=:;^\_?-\[\]]*)+
HOSTNAME1 \b(?:[0-9A-Za-z_\-][0-9A-Za-z-_\-]{0,62})(?:\.(?:[0-9A-Za-z_\-][0-9A-Za-z-:\-_]{0,62}))*(\.?|\b)
STATUS ([0-9.]{0,3}[, ]{0,2})+
HOSTPORT1 (%{IPV4}:%{POSINT}[, ]{0,2})+
FORWORD (?:%{IPV4}[,]?[ ]?)+|%{WORD}



|   :   %7C
{   :   %7B
}   :   %7D
<   :   %3C
>   :   %3E
`   :   %60
```


你可以使用下面的命令来检查你的配置文件：

`bin/logstash -f first-pipeline.conf --config.test_and_exit`

`--config.test_and_exit` 选项会分析你的配置文件并将其中的错误输出。

如果配置文件通过了检查，你可以使用下面的命令来启动Logstash：

`bin/logstash -f first-pipeline.conf --config.reload.automatic`

`--config.reload.automatic` 选项可以让Logstash在你修改配置文件之后重载而不必重新启动。


https://www.kancloud.cn/devops-centos/centos-linux-devops/397460

https://juejin.cn/post/6844904049079222286

