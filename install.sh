PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

echo `openssl rand -base64 32` > ~/passwd.txt

#把一般使用者umask改成0022
sed -i 's/umask 002/umask 022/g' /etc/profile

#避免putty斷行
echo "shopt -s checkwinsize " >> /etc/profile

#預設編輯器
echo "export VISUAL=vim" >> /etc/profile
echo "export EDITOR=vim" >> /etc/profile

#創建帳號資料夾 把umask 077 改成 022
sed -i 's/UMASK           077/UMASK           022/g' /etc/login.defs

#防止su切換root帳號
sed -i 's/\#auth           required        pam_wheel.so use_uid/auth           required        pam_wheel.so use_uid/g' /etc/pam.d/su

ulimit -n 5000

sh ${BASE_PATH}/disable_ipv6.sh
yum -y groupinstall 'Development Tools'
yum -y install wget vim
git config --global user.name "uxin603s"
git config --global user.email "uxin603s@gmail.com"

git clone git@github.com:uxin603s/linux_iptables.git ${BASE_PATH}/linux_iptables
sh ${BASE_PATH}/linux_iptables/iptables.rule 1
	
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



service php-fpm start
service nginx start


# service php-fpm start

# if [ 0 == 1 ];then
# fi





