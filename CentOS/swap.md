# 关闭 swap

```bash

# 查看
free -h

# 删除 swap 区所有内容
swapoff -a

# 删除 swap 挂载，这样系统下次启动不会再挂载 swap
# 注释 swap 行
vi /etc/fstab

```
