# zabbix-template-zimbra-linux
Zabbix Template for monitoring Zimbra in a linux environment. 

## Installation

```
mkdir /var/lib/zabbix/scripts/zabbix_zimbra
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-zimbra-linux/zabbix_zimbra-*.sh  /var/lib/zabbix/scripts/zabbix_zimbra
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_zimbra-stats/zabbix_zimbra-*.sh
chmod a+x /var/lib/zabbix/scripts/zabbix_zimbra-stats/zabbix_zimbra-*.sh
rm -rf /tmp/zabbix-templates

# Grant privileges to the script only
echo 'zabbix ALL=NOPASSWD: /opt/zimbra/common/bin/pflogsumm.pl, /var/lib/zabbix/scripts/zabbix_zimbra/zabbix_zimbra-stats.sh' >> /etc/sudoers 
echo 'zabbix ALL=NOPASSWD: /var/lib/zabbix/scripts/zabbix_zimbra/zabbix_zimbra-services.sh' >> /etc/sudoers

service zabbix-agent restart
```
## Add CronJob
```(crontab -u root -l; echo "* * * * * /var/lib/zabbix/scripts/zabbix_zimbra/zabbix_zimbra-get-stats.sh HOSTNAME >/dev/null 2>&1" ) | crontab -u root - ```

Import  ```Template App Zimbra Services & Template App Zimbra Statistics```  to zabbix server and link with your host.
