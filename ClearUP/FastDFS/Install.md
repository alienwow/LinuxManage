创建用户与组：
groupadd fastdfs
useradd -g fastdfs -s /sbin/nologin fdfs
创建目录
mkdir -p /data/fastdfs/storage
mkdir -p /data/fastdfs/tracker
mkdir -p /data/fastdfs/client
chown fdfs:fastdfs /data/fastdfs
chmod 774 /data/fastdfs

1、安装libfastcommon：
cd /softwares/fastdfs
tar -zxvf libfastcommon-1.0.7.tar.gz
mv libfastcommon-1.0.7 /walkingtec/libfastcommon
cd /walkingtec/libfastcommon
./make.sh
./make.sh install

libfastcommon.so默认安装到了/usr/lib64/libfastcommon.so，而FastDFS主程序设置的lib目录是/usr/local/lib，所以设置软连接
ln -s /usr/lib64/libfastcommon.so /usr/local/lib/libfastcommon.so
ln -s /usr/lib64/libfastcommon.so /usr/lib/libfastcommon.so
ln -s /usr/lib64/libfdfsclient.so /usr/local/lib/libfdfsclient.so
ln -s /usr/lib64/libfdfsclient.so /usr/lib/libfdfsclient.so


2、安装FastDFS:
cd /softwares/fastdfs
tar -zxvf FastDFS_v5.05.tar.gz
mv FastDFS /walkingtec/fastdfs
cd /walkingtec/fastdfs
./make.sh
./make.sh install
cd /etc/fdfs

配置文件设置：
cp tracker.conf.sample tracker.conf
cp storage.conf.sample storage.conf
cp client.conf.sample client.conf

详细设置见附件
tracker.conf配置中要修改的几个项：
base_path=/usrdata/fastdfs
bind_addr=192.168.137.102
port=22122
http.server_port=8080

storage.conf配置中要修改的几个项：
group_name=group1
bind_addr=192.168.137.102
port=23000
base_path=/usrdata/fastdfs
store_path0=/usrdata/fastdfs
tracker_server=192.168.137.102:22122
http.server_port=8888

启动
启动tracker storage.conf
fdfs_trackerd /etc/fdfs/tracker.conf
fdfs_storaged /etc/fdfs/storage.conf

3、安装nginx插件：
    tar -zxvf fastdfs-nginx-module_v1.16.tar.gz
    cd fastdfs-nginx-module/src
config文件修改：
    vi config
    修改如下配置，我这里原来是
CORE_INCS="$CORE_INCS /usr/local/include/fastdfs /usr/local/include/fastcommon/"
改成
CORE_INCS="$CORE_INCS /usr/include/fastdfs /usr/include/fastcommon/"
这个是很重要的，不然在nginx编译的时候会报错的，我看网上很多在安装nginx的fastdfs的插件报错，都是这个原因，而不是版本不匹配。

cp  mod_fastdfs.conf /etc/fdfs

修改配置
vi /etc/fdfs/mod_fastdfs.conf
group_name=group1
tracker_server=192.168.137.102:22122
store_path0=/data/fastdfs
base_path=/data/fastdfs
url_have_group_name = true

配置文件服务器的软连接
ln -s /data/fastdfs/data /data/fastdfs/data/M00  (配置文件中stoage存放数据的路径)

同时将以下两个文件复制到/etc/fdfs/
cp /litsoft/fastdfs/conf/http.conf /etc/fdfs/
cp /litsoft/fastdfs/conf/mime.types /etc/fdfs/

4、nginx安装：
yum install pcre*
yum install openssl*
yum install zlib

->调到Nginx安装

最后在在server中添加
location /group1/M00{
    root /data/fastdfs/data;
    ngx_fastdfs_module;
}


启动fastdfs
fdfs_trackerd /etc/fdfs/tracker.conf
fdfs_storaged /etc/fdfs/storage.conf


fdfs_monitor /etc/fdfs/client.conf delete g1 115.29.249.16