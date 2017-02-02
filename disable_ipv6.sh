PATH=/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/sbin:/usr/local/bin; export PATH

for i in "net.ipv6.conf.all.disable_ipv6 = 1" "net.ipv6.conf.default.disable_ipv6 = 1"
do
	Exist=`cat /etc/sysctl.conf |grep "${i}" |wc -l`
	if [ $Exist == 0 ]; then
		echo ${i} >> /etc/sysctl.conf
	fi
done

sysctl -p

echo 1 > /proc/sys/net/ipv6/conf/all/disable_ipv6
echo 1 > /proc/sys/net/ipv6/conf/default/disable_ipv6