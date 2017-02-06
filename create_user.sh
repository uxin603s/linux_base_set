read -p "請輸入帳號:" account
passwd="passwd"
passwd_again="passwd_again"
while true; do 
	echo -n "請輸入密碼:"
	read -s passwd
	echo 
	echo -n "再次確認密碼:"
	read -s passwd_again
	echo 
	if [ $passwd == $passwd_again ]; then
		echo "兩次密碼相同"
		break
	else
		echo "兩次密碼不相同，請再輸入一次"
	fi
done
# echo $account
# echo $passwd

mysql_passwd=`cat ~/passwd.txt`


useradd $account
if [ $? == 0 ]; then
	echo $passwd | passwd $account --stdin
	/bin/cp -rf conf /home/$account/conf
	chown -R $account:$account /home/$account/conf
	
	/bin/cp -rf public_html /home/$account/public_html	
	chown -R $account:$account /home/$account/public_html
	
	
	sed -i "s/REPLACE_USER/${account}/g" /home/$account/conf/php-fpm/php-fpm.conf
	sed -i "s/REPLACE_USER/${account}/g" /home/$account/conf/nginx/php-fpm.conf
	sed -i "s/REPLACE_USER/${account}/g" /home/$account/conf/nginx/nginx.conf
	read -p "請輸入網域:" server_name
	sed -i "s/SERVER_NAME_REPLACE/${server_name}/g" /home/$account/conf/nginx/nginx.conf
	echo "include=/home/$account/conf/php-fpm/php-fpm.conf" >> /usr/local/php-fpm/include.conf
	echo "include /home/$account/conf/nginx/nginx.conf;" >> /usr/local/nginx/conf/include.conf
	
	mysql -uroot -p$mysql_passwd -e "CREATE DATABASE $account;"
	mysql -uroot -p$mysql_passwd -e "CREATE USER '$account'@'localhost' IDENTIFIED BY '$passwd';"
	mysql -uroot -p$mysql_passwd -e "GRANT ALL PRIVILEGES ON $account.* TO '$account'@'localhost';"
	mysql -uroot -p$mysql_passwd -e "FLUSH PRIVILEGES;"
fi


service nginx reload
service php-fpm reload