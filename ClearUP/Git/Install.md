yum remove git


mkdir /tmp/git && cd /tmp/git
curl -O --progress https://www.kernel.org/pub/software/scm/git/git-2.7.4.tar.gz
tar -xzf git-2.7.4.tar.gz
cd git-2.7.4
./configure
make prefix=/usr/local all
#如果make除错请安装  yum install perl-ExtUtils-CBuilder perl-ExtUtils-MakeMaker
# 安装到/usr/local/bin
make prefix=/usr/local install
# 验证git版本号
git --version
#查看git安装路径
which git
