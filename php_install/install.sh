#export PHPRC=/usr/local/php
#export PHP_INI_SCAN_DIR=/usr/local/php/conf
#--with-config-file-path=/usr/local/php \
#--with-config-file-scan-dir=/usr/local/php/conf

PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

rpm -Uvh http://download.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
yum install -y yum-utils
yum-config-manager --enable remi
yum-config-manager --enable remi-php71

yum install -y php php-devel php-gd php-iconv php-imagick php-intl php-json php-libxml php-mbstring php-mcrypt php-memcached php-mysqlnd php-pdo php-fpm

chkconfig php-fpm on
service php-fpm start
