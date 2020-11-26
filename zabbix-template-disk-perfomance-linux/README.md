# zabbix-template-disk-perfomance-linux
Zabbix Template for monitoring disk performance in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-disk-perfomance-linux/userparameter_check_disk_stat.conf  $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-templates/zabbix-template-disk-perfomance-linux/zabbix_check_disk_stat.py /var/lib/zabbix/scripts/
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_check_disk_stat.py
chmod a+x /var/lib/zabbix/scripts/zabbix_check_disk_stat.py
rm -rf /tmp/zabbix-templates

service zabbix-agent restart
```
Import ```Template Disk Perfomance.xml``` to zabbix server and link with your host.
