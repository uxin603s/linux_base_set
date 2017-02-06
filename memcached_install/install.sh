PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

yum install -y cyrus-sasl-devel #記得要安裝這個在裝其他東西不然sasl不會開啟

if [ ! -e $BASE_PATH/libevent-2.1.8-stable.tar.gz ]; then
	wget https://github.com/libevent/libevent/releases/download/release-2.1.8-stable/libevent-2.1.8-stable.tar.gz -O $BASE_PATH/libevent-2.1.8-stable.tar.gz
	tar -zxf $BASE_PATH/libevent-2.1.8-stable.tar.gz -C $BASE_PATH
fi

cd $BASE_PATH/libevent-2.1.8-stable
./configure
make 
make install

if [ ! -e $BASE_PATH/memcached-1.4.34.tar.gz ]; then
	wget http://www.memcached.org/files/memcached-1.4.34.tar.gz -O $BASE_PATH/memcached-1.4.34.tar.gz
	tar -zxf $BASE_PATH/memcached-1.4.34.tar.gz -C $BASE_PATH	
fi

cd $BASE_PATH/memcached-1.4.34
# sed -i "s/\#define MAX_NUMBER_OF_SLAB_CLASSES (63 + 1)/\#define MAX_NUMBER_OF_SLAB_CLASSES (200 + 1)/g" memcached.h
./configure
make 
make install

/bin/cp -f ${BASE_PATH}/init.sh /etc/init.d/memcached
chmod 700 /etc/init.d/memcached


if [ ! -e /usr/lib64/libevent-2.1.so.6 ]; then
	ln -s /usr/local/lib/libevent-2.1.so.6 /usr/lib64/libevent-2.1.so.6
fi
chkconfig memcached on
service memcached start
# ldd memcached
# LD_DEBUG=libs ./memcached -v
