# zabbix-template-exim-linux
Zabbix Template for monitoring Exim4 in a linux environment. 

## Installation

```
mkdir /var/lib/zabbix/scripts/zabbix_exim-stats
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-exim-linux/zabbix_exim-stats.sh  /var/lib/zabbix/scripts/zabbix_exim-stats
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_exim-stats/zabbix_exim-stats.sh
chmod a+x /var/lib/zabbix/scripts/zabbix_exim-stats/zabbix_exim-stats.sh
rm -rf /tmp/zabbix-templates

service zabbix-agent restart
```
## Add CronJob
```(crontab -u root -l; echo "*/5 * * * *  /var/lib/zabbix/scripts/zabbix_exim-stats/zabbix_exim-stats.sh >/dev/null" ) | crontab -u root -```

Import  ```Template App Exim by Zabbix Agent active ```  to zabbix server and link with your host.
