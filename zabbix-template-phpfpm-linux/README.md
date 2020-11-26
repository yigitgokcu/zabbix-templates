# zabbix-template-phpfpm-linux
Zabbix Template for monitoring PHP-FPM in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-template-phpfpm-linux.git /tmp/zabbix-php-fpm
cp /tmp/zabbix-php-fpm/userparameter_php_fpm.conf $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-php-fpm/zabbix_php_fpm_*.sh /var/lib/zabbix/scripts/
cp /tmp/zabbix-php-fpm/statistics.conf /etc/nginx/conf.d/ && service nginx reload
rm -rf /tmp/zabbix-php-fpm*
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_php_fpm_*.sh
chmod a+x /var/lib/zabbix/scripts/zabbix_php_fpm_*.sh

# Grant privileges to the PHP-FPM auto discovery script only
echo 'zabbix ALL = NOPASSWD: /var/lib/zabbix/scripts/zabbix_php_fpm_discovery.sh' >> /etc/sudoers
echo 'zabbix ALL = NOPASSWD: /var/lib/zabbix/scripts/zabbix_php_fpm_status.sh' >> /etc/sudoers    

service zabbix-agent restart
```
Import ```Template App PHP-FPM.xml``` to zabbix server and link with your host.
