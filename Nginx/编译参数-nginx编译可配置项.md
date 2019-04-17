# nginx 模块配置项

## 安装路径配置

  --prefix=PATH                                 set installation prefix                                         指向安装目录
  --sbin-path=PATH                              set nginx binary pathname                                       指定执行程序文件存放位置
  --modules-path=PATH                           set modules path                                                指定第三方模块的存放路径
  --conf-path=PATH                              set nginx.conf pathname                                         指定配置文件存放位置
  --error-log-path=PATH                         set error log pathname                                          指定错误日志存放位置
  --pid-path=PATH                               set nginx.pid pathname                                          指定 pid 文件存放位置
  --lock-path=PATH                              set nginx.lock pathname                                         指定 lock 文件存放位置

  --build=NAME                                  set build name
  --builddir=DIR                                set build directory                                             指向编译目录

## 用户及用户组配置

  --user=USER                                   set non-privileged user for worker processes                    指定程序运行时的非特权用户
  --group=GROUP                                 set non-privileged group for worker processes                   指定程序运行时的非特权用户组
  --with-select_module                          enable select module                                            启用 select 模块支持，一种轮询处理方式，不推荐在高并发环境中使用
  --without-select_module                       disable select module                                           禁用 select 模块支持
  --with-poll_module                            enable poll module                                              启用 poll 模块支持,功能与select相同，不推荐在高并发环境中使用
  --without-poll_module                         disable poll module                                             禁用 poll 模块支持
  --with-threads                                enable thread pool support                                      启用 thread pool 支持
  --with-file-aio                               enable file AIO support                                         启用 file aio 支持
  --with-http_ssl_module                        enable ngx_http_ssl_module                                      启用 https 支持
  --with-http_v2_module                         enable ngx_http_v2_module                                       启用 ngx_http_v2_module 支持
  --with-http_realip_module                     enable ngx_http_realip_module                                   允许从请求报文头中更改客户端的ip地址，默认为关
  --with-http_addition_module                   enable ngx_http_addition_module                                 启用 ngix_http_additon_mdoule 支持（作为一个输出过滤器，分部分响应请求)
  --with-http_xslt_module                       enable ngx_http_xslt_module                                     启用 ngx_http_xslt_module 支持，过滤转换XML请求
  --with-http_xslt_module=dynamic               enable dynamic ngx_http_xslt_module                             
  --with-http_image_filter_module               enable ngx_http_image_filter_module                             启用 ngx_http_image_filter_module 支持，传输 JPEG\GIF\PNG 图片的一个过滤器，默认不启用，需要安装gd库
  --with-http_image_filter_module=dynamic       enable dynamic ngx_http_image_filter_module                     
  --with-http_geoip_module                      enable ngx_http_geoip_module                                    启用 ngx_http_geoip_module 支持，用于创建基于 MaxMind GeoIP 二进制文件相配的客户端IP地址的ngx_http_geoip_module变量
  --with-http_geoip_module=dynamic              enable dynamic ngx_http_geoip_module                            
  --with-http_sub_module                        enable ngx_http_sub_module                                      启用 ngx_http_sub_module 支持，允许用一些其他文本替换nginx响应中的一些文本
  --with-http_dav_module                        enable ngx_http_dav_module                                      启用 ngx_http_dav_module 支持，增加PUT、DELETE、MKCOL创建集合，COPY和MOVE方法，默认为关闭，需要编译开启
  --with-http_flv_module                        enable ngx_http_flv_module                                      启用 ngx_http_flv_module 支持，提供寻求内存使用基于时间的偏移量文件
  --with-http_mp4_module                        enable ngx_http_mp4_module                                      启用 ngx_http_mp4_module 支持，启用对mp4类视频文件的支持
  --with-http_gunzip_module                     enable ngx_http_gunzip_module                                   
  --with-http_gzip_static_module                enable ngx_http_gzip_static_module                              启用 ngx_http_gzip_static_module 支持，支持在线实时压缩输出数据流
  --with-http_auth_request_module               enable ngx_http_auth_request_module                             
  --with-http_random_index_module               enable ngx_http_random_index_module                             启用 ngx_http_random_index_module 支持，从目录中随机挑选一个目录索引
  --with-http_secure_link_module                enable ngx_http_secure_link_module                              启用 ngx_http_secure_link_module 支持，计算和检查要求所需的安全链接网址
  --with-http_degradation_module                enable ngx_http_degradation_module                              启用 ngx_http_degradation_module 支持允许在内存不足的情况下返回204或444代码
  --with-http_slice_module                      enable ngx_http_slice_module                                    
  --with-http_stub_status_module                enable ngx_http_stub_status_module                              启用 ngx_http_stub_status_module 支持查看nginx的状态页
  --without-http_charset_module                 disable ngx_http_charset_module                                 禁用 ngx_http_charset_module 这一模块，可以进行字符集间的转换，从其它字符转换成UTF-8或者从UTF8转换成其它字符。它只能从服务器到客户端方向，只有一个字节的字符可以转换
  --without-http_gzip_module                    disable ngx_http_gzip_module                                    禁用 ngx_http_gzip_module 支持，同 --with-http_gzip_static_module 功能一样
  --without-http_ssi_module                     disable ngx_http_ssi_module                                     禁用 ngx_http_ssi_module 支持，提供了一个在输入端处理服务器包含文件（SSI）的过滤器
  --without-http_userid_module                  disable ngx_http_userid_module                                  禁用 ngx_http_userid_module 支持，该模块用来确定客户端后续请求的cookies
  --without-http_access_module                  disable ngx_http_access_module                                  禁用 ngx_http_access_module 支持，提供了基于主机ip地址的访问控制功能
  --without-http_auth_basic_module              disable ngx_http_auth_basic_module                              禁用 ngx_http_auth_basic_module 支持，可以使用用户名和密码认证的方式来对站点或部分内容进行认证
  --without-http_mirror_module                  disable ngx_http_mirror_module                                  
  --without-http_autoindex_module               disable ngx_http_autoindex_module                               禁用 ngx_http_authindex_module，该模块用于在 ngx_http_index_module 模块没有找到索引文件时发出请求，用于自动生成目录列表
  --without-http_geo_module                     disable ngx_http_geo_module                                     禁用 ngx_http_geo_module 支持，这个模块用于创建依赖于客户端ip的变量
  --without-http_map_module                     disable ngx_http_map_module                                     禁用 ngx_http_map_module 支持，使用任意的键、值 对设置配置变量
  --without-http_split_clients_module           disable ngx_http_split_clients_module                           禁用 ngx_http_split_clients_module 支持，该模块用于基于用户ip地址、报头、cookies 划分用户
  --without-http_referer_module                 disable ngx_http_referer_module                                 禁用 ngx_http_referer_modlue 支持，该模块用来过滤请求，报头中Referer值不正确的请求
  --without-http_rewrite_module                 disable ngx_http_rewrite_module                                 禁用 ngx_http_rewrite_module 支持。该模块允许使用正则表达式改变URI，并且根据变量来转向以及选择配置。如果在server级别设置该选项，那么将在location之前生效，但如果location中还有更进一步的重写规则，location部分的规则依然会被执行。如果这个URI重写是因为location部分的规则造成的，那么location部分会再次被执行作为新的URI，这个循环会被执行10次，最后返回一个500错误
  --without-http_proxy_module                   disable ngx_http_proxy_module                                   禁用 ngx_http_proxy_module 支持，http代理功能
  --without-http_fastcgi_module                 disable ngx_http_fastcgi_module                                 禁用 ngx_http_fastcgi_module 支持，该模块允许nginx与fastcgi进程交互，并通过传递参数来控制fastcgi进程工作
  --without-http_uwsgi_module                   disable ngx_http_uwsgi_module                                   禁用 ngx_http_uwsgi_module 支持，该模块用来使用uwsgi协议，uwsgi服务器相关
  --without-http_scgi_module                    disable ngx_http_scgi_module                                    禁用 ngx_http_scgi_module 支持，类似于fastcgi，也是应用程序与http服务的接口标准
  --without-http_grpc_module                    disable ngx_http_grpc_module                                    
  --without-http_memcached_module               disable ngx_http_memcached_module                               禁用 ngx_http_memcached 支持，用来提供简单的缓存，提高系统效率
  --without-http_limit_conn_module              disable ngx_http_limit_conn_module                              禁用 ngx_http_limit_conn_module 支持，该模块可以根据条件进行会话的并发连接数进行限制
  --without-http_limit_req_module               disable ngx_http_limit_req_module                               禁用 ngx_limit_req_module 支持，该模块可以实现对于一个地址进行请求数量的限制
  --without-http_empty_gif_module               disable ngx_http_empty_gif_module                               禁用 ngx_http_empty_gif_module 支持，该模块在内存中常驻了一个1*1的透明gif图像，可以被非常快速的调用
  --without-http_browser_module                 disable ngx_http_browser_module                                 禁用 ngx_http_browser_mdoule 支持，创建依赖于请求报头的值 。如果浏览器为modern，则$modern_browser等于modern_browser_value的值；如果浏览器为old，则$ancient_browser等于$ancient_browser_value指令分配的值；如果浏览器为MSIE，则$msie等于1
  --without-http_upstream_hash_module           disable ngx_http_upstream_hash_module                           
  --without-http_upstream_ip_hash_module        disable ngx_http_upstream_ip_hash_module                        禁用 ngx_http_upstream_ip_hash_module 支持，该模块用于简单的负载均衡
  --without-http_upstream_least_conn_module     disable ngx_http_upstream_least_conn_module                     
  --without-http_upstream_random_module         disable ngx_http_upstream_random_module                         
  --without-http_upstream_keepalive_module      disable ngx_http_upstream_keepalive_module                      
  --without-http_upstream_zone_module           disable ngx_http_upstream_zone_module                           
  --with-http_perl_module                       enable ngx_http_perl_module                                     启用 ngx_http_perl_module 支持，它使nginx可以直接使用perl或通过ssi调用perl
  --with-http_perl_module=dynamic               enable dynamic ngx_http_perl_module                             
  --with-perl_modules_path=PATH                 set Perl modules path                                           设定 perl 模块路径
  --with-perl=PATH                              set perl binary pathname                                        设定 perl 库文件路径
  --http-log-path=PATH                          set http access log pathname                                    设定 access log 路径
  --http-client-body-temp-path=PATH             set path to store http client request body temporary files      设定 http 客户端请求临时文件路径
  --http-proxy-temp-path=PATH                   set path to store http proxy temporary files                    设定 http 代理临时文件路径
  --http-fastcgi-temp-path=PATH                 set path to store http fastcgi temporary files                  设定 http fastcgi临时文件路径
  --http-uwsgi-temp-path=PATH                   set path to store http uwsgi temporary files                    设定 http uwsgi 临时文件路径
  --http-scgi-temp-path=PATH                    set path to store http scgi temporary files                     设定 http scgi 临时文件路径
  --without-http                                disable HTTP server                                             禁用 http server 功能
  --without-http-cache                          disable HTTP cache                                              禁用 http cache 功能
  --with-mail                                   enable POP3/IMAP4/SMTP proxy module                             启用 POP3、IMAP4、SMTP 代理模块
  --with-mail=dynamic                           enable dynamic POP3/IMAP4/SMTP proxy module                     
  --with-mail_ssl_module                        enable ngx_mail_ssl_module                                      启用 ngx_mail_ssl_module 支持
  --without-mail_pop3_module                    disable ngx_mail_pop3_module                                    禁用 pop3 协议
  --without-mail_imap_module                    disable ngx_mail_imap_module                                    禁用 iamp 协议
  --without-mail_smtp_module                    disable ngx_mail_smtp_module                                    禁用 smtp 协议

## 开启4层反向代理功能

  --with-stream                                 enable TCP/UDP proxy module                                     
  --with-stream=dynamic                         enable dynamic TCP/UDP proxy module                             
  --with-stream_ssl_module                      enable ngx_stream_ssl_module                                    
  --with-stream_realip_module                   enable ngx_stream_realip_module                                 
  --with-stream_geoip_module                    enable ngx_stream_geoip_module                                  
  --with-stream_geoip_module=dynamic            enable dynamic ngx_stream_geoip_module                          
  --with-stream_ssl_preread_module              enable ngx_stream_ssl_preread_module                            
  --without-stream_limit_conn_module            disable ngx_stream_limit_conn_module                            
  --without-stream_access_module                disable ngx_stream_access_module                                
  --without-stream_geo_module                   disable ngx_stream_geo_module                                   
  --without-stream_map_module                   disable ngx_stream_map_module                                   
  --without-stream_split_clients_module         disable ngx_stream_split_clients_module                         
  --without-stream_return_module                disable ngx_stream_return_module                                
  --without-stream_upstream_hash_module         disable ngx_stream_upstream_hash_module                         
  --without-stream_upstream_least_conn_module   disable ngx_stream_upstream_least_conn_module                   
  --without-stream_upstream_random_module       disable ngx_stream_upstream_random_module                       
  --without-stream_upstream_zone_module         disable ngx_stream_upstream_zone_module                         


  --with-google_perftools_module                enable ngx_google_perftools_module                              启用 ngx_google_perftools_mdoule支持，调试用，可以用来分析程序性能瓶颈
  --with-cpp_test_module                        enable ngx_cpp_test_module                                      启用 ngx_cpp_test_module支持
  --add-module=PATH                             enable external module                                          指定外部模块路径，启用对外部模块的支持
  --add-dynamic-module=PATH                     enable dynamic external module                                  
  --with-compat                                 dynamic modules compatibility                                   
  --with-cc=PATH                                set C compiler pathname                                         指向 C 编译器路径
  --with-cpp=PATH                               set C preprocessor pathname                                     指向 C 预处理路径
  --with-cc-opt=OPTIONS                         set additional C compiler options                               设置 C 编译器参数，指定--with-cc-opt="-I /usr/lcal/include",如果使用select()函数，还需要同时指定文件描述符数量--with-cc-opt="-D FD_SETSIZE=2048"。 (PCRE库）
  --with-ld-opt=OPTIONS                         set additional linker options                                   设置连接文件参数，需要指定--with-ld-opt="-L /usr/local/lib"。（PCRE库）
  --with-cpu-opt=CPU                            build for the specified CPU, valid values:                      指定编译的 CPU 类型，如pentium,pentiumpro,...amd64,ppc64...
                                                pentium, pentiumpro, pentium3, pentium4,
                                                athlon, opteron, sparc32, sparc64, ppc64

## pcre

  --without-pcre                                disable PCRE library usage                                      禁用 pcre库
  --with-pcre                                   force PCRE library usage                                        启用 pcre库
  --with-pcre=DIR                               set path to PCRE library sources                                指向 pcre库文件目录
  --with-pcre-opt=OPTIONS                       set additional build options for PCRE                           在编译时为 pcre 库设置附加参数
  --with-pcre-jit                               build PCRE with JIT compilation support                         

## zlib

  --with-zlib=DIR                               set path to zlib library sources                                指向zlib库文件目录
  --with-zlib-opt=OPTIONS                       set additional build options for zlib                           在编译时为zlib设置附加参数
  --with-zlib-asm=CPU                           use zlib assembler sources optimized                            为指定的CPU使用汇编源进行优化
                                                for the specified CPU, valid values:
                                                pentium, pentiumpro

## openssl

  --with-openssl=DIR                            set path to OpenSSL library sources                             指向openssl安装目录
  --with-openssl-opt=OPTIONS                    set additional build options for OpenSSL                        在编译时为openssl设置附加参数

## libatomic

  --with-libatomic                              force libatomic_ops library usage                               为原子内存的更新操作的实现提供一个架构
  --with-libatomic=DIR                          set path to libatomic_ops library sources                       指向libatomic_ops的安装目录

## 其他
  --with-debug                                  enable debug logging                                            启用debug日志