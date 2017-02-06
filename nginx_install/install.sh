PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`
cd ${BASE_PATH}

wget https://www.openssl.org/source/openssl-1.0.2k.tar.gz -O openssl-1.0.2k.tar.gz
tar -zxf openssl-1.0.2k.tar.gz 
OPEN_SSL_PATH=${BASE_PATH}/openssl-1.0.2k
#openssl需要1.02版才會支援http2

wget https://nginx.org/download/nginx-1.11.9.tar.gz -O nginx-1.11.9.tar.gz
tar -zxf nginx-1.11.9.tar.gz

cd ${BASE_PATH}/nginx-1.11.9

./configure \
--with-http_realip_module \
--with-http_ssl_module \
--with-http_v2_module \
--with-openssl=${OPEN_SSL_PATH} 
make 
make install

/bin/cp ${BASE_PATH}/init.sh ${BASE_PATH}/nginx
chmod 700 ${BASE_PATH}/nginx

/bin/mv ${BASE_PATH}/nginx /etc/init.d/nginx

CONF_FILE_ARRAY=${BASE_PATH}/conf/*
for i in $CONF_FILE_ARRAY ; do
/bin/cp -rf $i /usr/local/nginx/conf/$(basename $i);
done

chkconfig nginx on
service nginx start
