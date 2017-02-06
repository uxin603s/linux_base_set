PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH

cp -rf atrpms.repo /etc/yum.repos.d/atrpms.repo

yum install -y fail2ban

chkconfig fail2ban on 
service fail2ban start