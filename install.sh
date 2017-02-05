PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

# if [ 0 == 1 ];then
	sh ${BASE_PATH}/disable_ipv6.sh
	yum -y groupinstall 'Development Tools'
	yum -y install wget vim
	git config --global user.name "uxin603s"
	git config --global user.email "uxin603s@gmail.com"
	
	git clone git@github.com:uxin603s/linux_iptables.git ${BASE_PATH}/linux_iptables
	sh ${BASE_PATH}/linux_iptables/iptables.rule
		
	git clone git@github.com:uxin603s/memcached_install.git ${BASE_PATH}/memcached_install
	sh ${BASE_PATH}/memcached_install/install.sh
	
	git clone git@github.com:uxin603s/imagick_install.git ${BASE_PATH}/imagick_install
	sh ${BASE_PATH}/imagick_install/install.sh
	
	git clone git@github.com:uxin603s/mysql_install.git ${BASE_PATH}/mysql_install
	sh ${BASE_PATH}/mysql_install/install.sh
	
	git clone git@github.com:uxin603s/php_install.git ${BASE_PATH}/php_install
	sh ${BASE_PATH}/php_install/install.sh
	
	git clone git@github.com:uxin603s/nginx_install.git ${BASE_PATH}/nginx_install
	sh ${BASE_PATH}/nginx_install/install.sh
# fi





