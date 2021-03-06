# nginx配置说明

## 定义Nginx运行的用户和用户组
user  nginx nginx;

## nginx进程数，建议设置为等于CPU总核心数
worker_processes  8;

## 全局错误日志定义类型，[ debug | info | notice | warn | error | crit ]
error_log /data/nginx/logs/error.log warn;

## 进程文件
pid /data/nginx/nginx.pid;

## 一个nginx进程打开的最多文件描述符数目，理论值应该是最多打开文件数（系统的值ulimit -n）与nginx进程数相除，但是nginx分配请求并不均匀，所以建议与ulimit -n的值保持一致。
worker_rlimit_nofile 65535;

## 工作模式与连接数上限
events {
    #参考事件模型，use [ kqueue | rtsig | epoll | /dev/poll | select | poll ]; epoll模型是Linux 2.6以上版本内核中的高性能网络I/O模型，如果跑在FreeBSD上面，就用kqueue模型。
    use epoll;
    #单进程最大连接数（最大连接数=连接数*进程数）  根据服务器性能进行配置
    worker_connections  20480;
}

## 设定http服务器
http {
    #导入配置文件
    include /vito/nginx/conf/reverse-proxy.conf;

    #文件扩展名与文件类型映射表
    include mime.types;

    #默认编码
    charset utf-8;

    #默认文件类型
    default_type  application/octet-stream;

    #访问日志存储目录
    #access_log /data/nginx/logs/access.log  main;

    #日志格式设定
    #log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
    #                  '$status $body_bytes_sent "$http_referer" '
    #                  '"$http_user_agent" "$http_x_forwarded_for"';


    #  $remote_addr与$http_x_forwarded_for用以记录客户端的ip地址；
    #  $remote_user：用来记录客户端用户名称；
    #  $time_local： 用来记录访问时间与时区；
    #  $request： 用来记录请求的url与http协议；
    #  $status： 用来记录请求状态；成功是200，
    #  $body_bytes_s ent ：记录发送给客户端文件主体内容大小；
    #  $http_referer：用来记录从那个页面链接访问过来的；
    #  $http_user_agent：记录客户毒啊浏览器的相关信息；


    #服务器名字的hash表大小
    #server_names_hash_bucket_size 128;

    # 客户端请求头部的缓冲区大小，这个可以根据你的系统分页大小来设置，一般一个请求头的大小不会超过1k，
    # 不过由于一般系统分页都要大于1k，所以这里设置为分页大小。
    # 分页大小可以用命令getconf PAGESIZE 取得。
    client_header_buffer_size 4k;

    # 客户请求头缓冲大小
    # nginx默认会用client_header_buffer_size这个buffer来读取header值，如果
    # header过大，它会使用large_client_header_buffers来读取
    # 如果设置过小HTTP头/Cookie过大 会报400 错误nginx 400 bad request
    # 求行如果超过buffer，就会报HTTP 414错误(URI Too Long)
    # nginx接受最长的HTTP头部大小必须比其中一个buffer大，否则就会报400的
    large_client_header_buffers 8 128k;

    client_max_body_size 50m;

    #开启高效文件传输模式，sendfile指令指定nginx是否调用sendfile函数来输出文件，
    #   对于普通应用设为 on，如果用来进行下载等应用磁盘IO重负载应用，
    #   可设置为off，以平衡磁盘与网络I/O处理速度，降低系统的负载。
    #   注意：如果图片显示不正常把这个改成off。
    sendfile        on;

    #开启目录列表访问，合适下载服务器，默认关闭。
    autoindex off;

    #去除请求头上的nginx版本号
    server_tokens off;

    #防止网络阻塞
    tcp_nopush on;

    #防止网络阻塞
    tcp_nodelay on;

    #
    keepalive_requests 100;
    #长连接超时时间，单位是秒
    keepalive_timeout  60;

    #FastCGI相关参数是为了改善网站的性能：减少资源占用，提高访问速度。下面参数看字面意思都能理解。
    fastcgi_connect_timeout 300;
    fastcgi_send_timeout 300;
    fastcgi_read_timeout 300;
    fastcgi_buffer_size 64k;
    fastcgi_buffers 4 64k;
    fastcgi_busy_buffers_size 128k;
    fastcgi_temp_file_write_size 128k;

    #gzip模块设置
    #开启gzip压缩输出
    gzip on;
    #最小压缩文件大小
    gzip_min_length 1k;
    #压缩缓冲区
    gzip_buffers 4 16k;
    #压缩版本（默认1.1，前端如果是squid2.5请使用1.0）
    gzip_http_version 1.0;
    #压缩等级
    gzip_comp_level 2;
    #压缩类型，默认就已经包含text/html，所以下面就不用再写了，写上去也不会有问题，但是会有一个warn。
    gzip_types text/plain application/x-javascript text/css application/xml;
    gzip_vary on;
    #开启限制IP连接数的时候需要使用
    #limit_zone crawler $binary_remote_addr 10m;

    #缓冲区代理缓冲用户端请求的最大字节数,可以理解为保存到本地再传给用户
    client_body_buffer_size 256k;
    client_header_buffer_size 16k;
    client_header_timeout 3m;
    client_body_timeout 3m;
    send_timeout 3m;
    proxy_connect_timeout 300s;

    #nginx跟后端服务器连接超时时间(代理连接超时)
    proxy_read_timeout 300s;

    #连接成功后，后端服务器响应时间(代理接收超时)
    proxy_send_timeout 300s;
    proxy_buffer_size 64k;

    #设置代理服务器（nginx）保存用户头信息的缓冲区大小
    proxy_buffers 4 32k;

    #proxy_buffers缓冲区，网页平均在32k以下的话，这样设置
    proxy_busy_buffers_size 64k;

    #高负荷下缓冲大小（proxy_buffers*2）
    proxy_temp_file_write_size 64k;

    #设定缓存文件夹大小，大于这个值，将从upstream服务器传递请求，而不缓冲到磁盘
    proxy_ignore_client_abort on;

    #websocket 配置开始
    map $http_upgrade $connection_upgrade {
        default upgrade;
        ''      close;
    }
    #websocket 配置结束

    #虚拟主机的配置
    server{
        #域名可以有多个，用空格隔开
        server_name     10.161.181.166;
        listen          80;
        index           50x.html;
        error_page      404 500 502 503 504  /50x.html;
        charset utf8;
        #定义本虚拟主机的访问日志
        #access_log      /data/nginx/logs/access.log;

        #图片缓存时间设置
        location ~ .*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$ {
            expires 10d;
        }
        #JS和CSS缓存时间设置
        location ~ .*.(js|css)?$ {
            expires 1h;
        }
        #错误页面
        location = /50x.html {
            internal;
            root html;
        }

        location /{
            root /home/wwwroot/quietly;
        }
        #location /g1/M00{
        #    root /data/fastdfs/storage;
        #    ngx_fastdfs_module;
        #}
        location /nginxstatus {
            stub_status on;
            access_log off;
            #allow 192.168.1.100;
            #deny all;
        }
    }

    # upstream的负载均衡，weight是权重，可以根据机器配置定义权重。
    # 1、轮询（默认）每个请求按时间顺序逐一分配到不同的后端服务器，如果后端服务器down掉，能自动剔除。
    # 2、weigth参数表示权值，可以不配置，权值越高被分配到的几率越大。weight和访问比率成正比，用于后端服务器性能不均的情况。
    # 3、ip_hash  每个请求按访问ip的hash结果分配，这样每个访客固定访问一个后端服务器，可以解决session的问题。
    upstream upstreamServer{
        ip_hash;
        server 10.162.55.6:8088 weigth=1;
        server 10.162.63.73:8088 weigth=1;
    }
    #反向代理服务器配置
    server{
        server_name tfs.silentwind.com.cn;
        listen 80;
        charset utf8;
        index index.html index.htm;
        error_page      404 500 502 503 504  /50x.html;
        #访问日志
        access_log off;
        #access_log /data/nginx/logs/tfs.log;
        #图片缓存时间设置
        location ~* \*.(htm|html|gif|jpg|jpeg|png|bmp|swf|ioc|rar|zip|txt|flv|mid|doc|ppt|pdf|xls|mp3|wma)$ {
            expires 10d;
        }
        #JS和CSS缓存时间设置
        location ~* \*.(js|css)?$ {
            expires 1h;
        }
        #错误页面
        location = /50x.html {
            internal;
            root html;
        }
        location / {
            proxy_redirect off;
            proxy_set_header Host $host;

            # 上一级代理 ip
            proxy_set_header X-Real-IP $remote_addr;

            # 自定义header 客户端真实ip
            proxy_set_header X-ClientReal-IP $http_x_real_ip;

            # 会将每一级的代理 ip 通过 “, ” 拼接
            # 例：192.168.159.1, 192.168.159.145
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_pass http://10.162.63.73:8080;

            ###################################还不太清楚效果###################################
            ##允许客户端请求的最大单文件字节数
            #client_max_body_size 10m;
            ##缓冲区代理缓冲用户端请求的最大字节数
            #client_body_buffer_size 128k;
            ##nginx跟后端服务器连接超时时间(代理连接超时)
            #proxy_connect_timeout 90;
            ##后端服务器数据回传时间(代理发送超时)
            #proxy_send_timeout 90;
            ##连接成功后，后端服务器响应时间(代理接收超时)
            #proxy_read_timeout 90;
            ##设置代理服务器（nginx）保存用户头信息的缓冲区大小
            #proxy_buffer_size 4k;
            ##proxy_buffers缓冲区，网页平均在32k以下的设置
            #proxy_buffers 4 32k;
            ##高负荷下缓冲大小（proxy_buffers*2）
            #proxy_busy_buffers_size 64k;
            ##设定缓存文件夹大小，大于这个值，将从upstream服务器传
            #proxy_temp_file_write_size 64k;
            ###################################还不太清楚效果###################################
        }
        #设定查看Nginx状态的地址
        location /nginxstatus {
            stub_status on;
            access_log off;
            #auth_basic "nginxstatus";
            #auth_basic_user_file conf/htpasswd;
            #htpasswd文件的内容可以用apache提供的htpasswd工具来产生。
            #访问IP
            #allow 192.168.1.100;
            #deny all;
        }
    }
}
