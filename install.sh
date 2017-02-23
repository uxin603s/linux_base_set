PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

echo `openssl rand -base64 32` > ~/passwd.txt

chmod 600 ~/passwd.txt

#把一般使用者umask改成0022
sed -i 's/umask 002/umask 022/g' /etc/profile

#避免putty斷行
echo "shopt -s checkwinsize " >> /etc/profile

#預設編輯器
echo "export VISUAL=vim" >> /etc/profile
echo "export EDITOR=vim" >> /etc/profile
source /etc/profile

#創建帳號資料夾 把umask 077 改成 022
sed -i 's/UMASK           077/UMASK           022/g' /etc/login.defs

#防止su切換root帳號
sed  's/\#auth           required/#auth           required/g' /etc/pam.d/su
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/sysconfig/selinux

ulimit -n 5000

sh ${BASE_PATH}/disable_ipv6.sh
yum -y groupinstall 'Development Tools'
yum -y install wget vim
git config --global user.name "uxin603s"
git config --global user.email "uxin603s@gmail.com"


wget https://files.phpmyadmin.net/phpMyAdmin/4.6.6/phpMyAdmin-4.6.6-all-languages.tar.xz -O ${BASE_PATH}/public_html/phpMyAdmin-4.6.6-all-languages.tar.xz
tar -Jxf ${BASE_PATH}/public_html/phpMyAdmin-4.6.6-all-languages.tar.xz -C ${BASE_PATH}
rm -rf ${BASE_PATH}/public_html/phpMyAdmin-4.6.6-all-languages.tar.xz
/bin/mv ${BASE_PATH}/phpMyAdmin-4.6.6-all-languages ${BASE_PATH}/phpMyAdmin
cat ${BASE_PATH}/phpMyAdmin/config.sample.inc.php > ${BASE_PATH}/phpMyAdmin/config.inc.php

cat <<\EOF >> ${BASE_PATH}/phpMyAdmin/config.inc.php
//google reCaptcha
//$cfg['CaptchaLoginPublicKey']='';
//$cfg['CaptchaLoginPrivateKey']='';
EOF


sh ${BASE_PATH}/linux_iptables/iptables.rule 1
	
sh ${BASE_PATH}/git_install/install.sh

sh ${BASE_PATH}/fail2ban_install/install.sh
	
sh ${BASE_PATH}/memcached_install/install.sh

sh ${BASE_PATH}/imagick_install/install.sh

sh ${BASE_PATH}/mysql_install/install.sh

sh ${BASE_PATH}/nginx_install/install.sh

sh ${BASE_PATH}/php_install/install.sh
