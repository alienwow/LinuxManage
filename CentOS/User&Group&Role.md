# 用户与群组管理及角色管理

## 用户与群组管理

``` bash
# 查看所有群组
cat /etc/group

# 查看所有用户
cat /etc/passwd

# 添加群组：
groupadd <groupname>

# 添加用户：并禁止登入系统权限
useradd -g <groupname> -s /sbin/nologin <username>

# 删除用户：同时删除用户主目录
userdel -r <username>

# 禁用用户登入
usermod -s /sbin/nologin nginx

# useradd 选项 用户名
# 参 数 描 述
# ============================================================================
# -c comment 给新用户添加备注
# -d home_dir 为主目录指定一个名字（如果不想用登录名作为主目录名的话）
# -e expire_date 用YYYYY-MM-DD格式指定一个账户过期的日期
# -f inactive_days 指定这个帐户密码过期后多少天这个账户被禁用；0表示密码一过期就立即禁用，-1表示禁用这个功能
# -g initial_group 指定用户登录组的GID或组名
# -G group ... 指定用户除登录组之外所属的一个或多个附加组
# -k 必须和-m一起使用，将/etc/skel目录的内容复制到用户的HOME目录
# -m 创建用户的HOME目录
# -M 不创建用户的HOME目录（当默认设置里指定创建时，才用到）
# -n 创建一个同用户登录名同名的新组
# -r 创建系统账户
# -p passwd 为用户账户指定默认密码
# -s shell 指定默认登录shell
# -u uid 为账户指定一个唯一的UID
```

## 权限管理

``` bash
# 更改目录所有者
chown fdfs:fastdfs /data/fastdfs
# 更改目录读写权限
chmod 744 /data/fastdfs
# r(Read，读取)：4  对文件而言，具有读取文件内容的权限；对目录来说，具有浏览目 录的权限。
# w(Write,写入)：2  对文件而言，具有新增、修改文件内容的权限；对目录来说，具有删除、移动目录内文件的权限。
# x(eXecute，执行)：1  对文件而言，具有执行文件的权限；对目录了来说该用户具有进入目录的权
```