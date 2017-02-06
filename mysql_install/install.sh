PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH
BASE_PATH=`readlink -e $(dirname $0)`
#service mysql stop
#yum erase -y MariaDB-server MariaDB-client
#/bin/rm -rf /var/lib/mysql

/bin/cp -f ${BASE_PATH}/maria.repo /etc/yum.repos.d/maria.repo

yum install -y MariaDB-server MariaDB-client

/bin/cp -f ${BASE_PATH}/my.cnf /etc/my.cnf
passwd=`cat ~/passwd.txt`

chkconfig mysql on
service mysql start
mysql -e "UPDATE mysql.user SET Password = PASSWORD('$passwd') WHERE User = 'root'"
# Kill the anonymous users
mysql -e "DROP USER ''@'localhost'"
# Because our hostname varies we'll use some Bash magic here.
mysql -e "DROP USER ''@'$(hostname)'"
# Kill off the demo database
mysql -e "DROP DATABASE test"
# Make our changes take effect
mysql -e "FLUSH PRIVILEGES"
