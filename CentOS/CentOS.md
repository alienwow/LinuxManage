## 关闭 SELINUX
```bash
# 注释 SELINUXTYPE 并把 SELINUX改为disabled
vi /etc/selinux/config
#SELINUX=enforcing
#SELINUXTYPE=targeted
SELINUX=disabled
# 重启服务器
```

## 文件系统
``` bash
# 软件安装文件目录
/softwares
# 软件安装目录
/walkingtec
# 软件数据目录
/data
# 网站目录
/websites
```

## 修改yum源为阿里源

```bash
# CentOS 6
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo

# CentOS 7
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo
```

## 目录管理
```bash
# 删除目录（递归）
rm -rf <dir>

# 创建目录（递归）
mkdir -p <dir>/<dir>/...
```

## 查看进程
```bash
# 进程
ps -ef |grep mongod
# 端口
netstat -ntp
```

## 链接/软链接：设置快捷方式： 可以在命令行界面使用mysql命令了
```bash
ln -s /mysql/3306/bin/mysql /usr/bin
```

## 修改系统启动顺序：
```bash
cd /etc/rc.d
# 其中启动顺序需要修改rc.d下的rc[3,4,5].d目录下的文件名
# S为start，K为kill。
# 其后的数字代表了启动顺序
# 例如：mv /etc/rc.d/rc3.d/S85redis /etc/rc.d/rc3.d/S84redis
```

## 自动启动
```bash
chkconfig --add nginx
chkconfig --level 345 nginx on 
```

## 添加环境变量
``` bash
# 环境变量目录
vi /etc/profile

# 导入环境变量
export PATH=/walkingtec/ffmpeg/include/:$PATH
export PATH=/walkingtec/ffmpeg/lib/:$PATH

```



## 递归查找并删除文件
```bash
# 递归查找文件
find /data/websites/ -name "*.map.gz"

# 递归删除文件
find /data/websites/ -name "*.map.gz" |xargs rm -rf

```
