# zabbix-template-check-updates-linux
Zabbix Template for monitoring Pending Updates in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-template-check-updates-linux.git /tmp/zabbix-template-check-updates
cp /tmp/zabbix-template-check-updates/userparameter_checkupdates.conf $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
rm -rf /tmp/zabbix-template-check-updates*
service zabbix-agent restart
```
## Add CronJob (RHEL/CentOS)
```(crontab -u root -l; echo "0 4 * * * yum check-update --quiet | grep '^[a-Z0-9]' | wc -l > /var/lib/zabbix/zabbix.count.updates" ) | crontab -u root -```

## Add CronJob (Ubuntu/Debian)
```(crontab -u root -l; echo "0 4 * * * sudo /usr/bin/apt-get upgrade -s | grep -P '^\d+ upgraded' | cut -d" " -f1 > /var/lib/zabbix/zabbix.count.updates" ) | crontab -u root -```

Import ```Template Check Updates Linux OS.xml``` to zabbix server and link with your host.
