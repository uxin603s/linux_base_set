PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`

cp -rf ${BASE_PATH}/atrpms.repo /etc/yum.repos.d/atrpms.repo

yum install -y fail2ban

chkconfig fail2ban on 
service fail2ban start