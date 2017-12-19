1. 安装配置依赖项
如果已经安装了Postfix来发送邮件请在安装期间选择 'Internet Site' . 
你也可以用Sendmail或者 使用自定义的SMTP服务器来代替Postfix. 如果希望使用 Exim, 请 把它当做SMTP来配置.
在Centos 6和7上, 下面的命令也会配置系统防火墙,把HTTP和SSH端口开放.

sudo yum install curl openssh-server postfix cronie
sudo service postfix start
sudo chkconfig postfix on
sudo lokkit -s http -s ssh

2. 添加并安装GitLab软件包
curl http://packages.gitlab.cc/install/gitlab-ce/script.rpm.sh | sudo bash
sudo yum install gitlab-ce

如果不习惯这种通过管道命令安装的方式,可以在这里找到完整的安装脚本.
或者你可以 选择对应系统的GitLab安装包 并使用下面的命令进行安装
curl -LJO http://mirror.tuna.tsinghua.edu.cn/gitlab-ce/yum/el6/gitlab-ce-XXX.rpm/download
rpm -i gitlab-ce-XXX.rpm

https://packages.gitlab.com/gitlab/gitlab-ce/packages/el/6/gitlab-ce-8.3.2-ce.0.el6.x86_64.rpm
http://mirror.tuna.tsinghua.edu.cn/gitlab-ce/yum/el6/


3. 配置和使用GitLab
sudo gitlab-ctl reconfigure


4. 在浏览器访问GitLab主机名
Username: root 
Password: 5iveL!fe


GitLab服务启动与关闭
gitlab-ctl stop
gitlab-ctl start
gitlab-ctl restart