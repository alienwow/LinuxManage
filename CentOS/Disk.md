## 磁盘分区：
### 1、查看磁盘
```bash
fdisk -l
fdisk -l <磁盘>
```
### 2、开始分区
```bash
fdisk /dev/xvdb
# 操作命令符
# p、打印分区表。
# n、新建一个新分区。
# d、删除一个分区。
# q、退出不保存。
# w、把分区写进分区表，保存并退出
```
### 3、格式化硬盘
```bash
mkfs -t ext4 /dev/xvdb1
```
### 4、挂载分区
```bash
vi /etc/fstab
# 然后添加即可
/dev/xvdb1 /softwares ext4 defaults 0 0
/dev/xvdb2 /litsoft ext4 defaults 0 0
/dev/xvdb3 /data ext4 defaults 0 0
```