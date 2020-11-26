# zabbix-template-disk-perfomance-linux
Zabbix Template for monitoring disk performance in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-template-disk-perfomance-linux.git /tmp/zabbix-disk-performance
cp /tmp/zabbix-disk-performance/userparameter_check_disk_stat.conf  $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-disk-performance/zabbix_check_disk_stat.py /var/lib/zabbix/scripts/
rm -rf /tmp/zabbix-disk-performance*
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_check_disk_stat.py
chmod a+x /var/lib/zabbix/scripts/zabbix_check_disk_stat.py

service zabbix-agent restart
```
Import ```Template Disk Perfomance.xml``` to zabbix server and link with your host.
