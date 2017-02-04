需安裝
git iptables memcached imagick mysql > php > php extension > php-fpm > nginx

/etc/profile
把一般使用者umask改成0022
shopt -s checkwinsize 避免putty斷行
export VISUAL="vim" 預設編輯器
export EDITOR="vim" 預設編輯器
/etc/login.defs
把umask 077 改成 022
/etc/pam.d/su
auth required pam_wheel.so use_uid  
去除註解可以防止su切換root帳號

php-fpm 需要 ulimit -n 5000

