# zabbix-check-SSL-expiration
Scripts for monitoring SSL statuses of domains in Zabbix

## Installation

```
mkdir /var/lib/zabbix/scripts/zabbix_check_ssl/
git clone https://github.com/yigitgokcu/zabbix-check-SSL-expiration.git /tmp/zabbix-check-SSL-expiration
cp /tmp/zabbix-check-SSL-expiration/userparameter_ssl-check.conf $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-check-SSL-expiration/zabbix_*.sh /var/lib/zabbix/scripts/zabbix_ssl_check/
rm -rf /tmp/zabbix-check-SSL-expiration*
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_ssl_check/zabbix_*.sh
chmod a+x /var/lib/zabbix/scripts/zabbix_*.sh

echo 'domain.tld' >> /var/lib/zabbix/scripts/zabbix_ssl_check/domains.txt # add some domains
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_ssl_check/
crontab -u root -l | (cat - ; echo "0 4 * * * /var/lib/zabbix/scripts/zabbix_check_ssl/zabbix_cron.sh &> /dev/null") | crontab -u root -

service zabbix-agent restart
```
Import  ```Template Module SSL Check.xml```  to zabbix server and link with your host.
