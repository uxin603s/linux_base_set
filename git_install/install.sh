PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

yum install -y curl-devel expat-devel gettext-devel \
openssl-devel zlib-devel perl-devel
	
cd BASE_PATH
wget https://www.kernel.org/pub/software/scm/git/git-2.11.0.tar.xz -O git-2.11.0.tar.xz
tar -Jxf git-2.11.0.tar.xz 

cd git-2.11.0
 
make prefix=/usr/local all
sudo make prefix=/usr/local install

cd contrib/subtree
make
make install