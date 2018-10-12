#Base Utils
apt-get install sudo ansible nano apt-transport-https ca-certificates net-tools policykit-1

# OPNrpi GUI Specific
sudo apt-get install lighttp php-fpm php-curl php-gd php-json php-mbstring mysql-server php-mysql
mysql_secure_installation

nano /etc/php/7.0/fpm/php.ini
#### ==============================================
cgi.fix_pathinfo=1
#### ==============================================
cd /etc/lighttpd/conf-available/
cp 15-fastcgi-php.conf 15-fastcgi-php.conf.bak
nano 16-fastcgi-php-fpm.conf
#### ==============================================
# /usr/share/doc/lighttpd-doc/fastcgi.txt.gz
# http://redmine.lighttpd.net/projects/lighttpd/wiki/Docs:ConfigurationOptions#mod_fastcgi-fastcgi

## Start an FastCGI server for php (needs the php7.0-cgi package)
fastcgi.server += ( ".php" =>
        ((
                "socket" => "/var/run/php/php7.0-fpm.sock",
                "broken-scriptfilename" => "enable"
        ))
)
#### ==============================================
sudo ln -s /etc/lighttpd/conf-available/10-fastcgi.conf /etc/lighttpd/conf-enabled/10-fastcgi.conf
sudo ln -s /etc/lighttpd/conf-available/16-fastcgi-php.conf /etc/lighttpd/conf-enabled/15-fastcgi-php.conf
sudo systemctl restart lighttpd
sudo mkdir -p /usr/local/www/lighttpd
mkdir -p /var/cache/lighttpd

curl -s https://packagecloud.io/install/repositories/phalcon/stable/script.deb.sh | sudo bash
sudo apt-get update
sudo apt-get install php7.0-phalcon
sudo systemctl restart php7.0-fpm
