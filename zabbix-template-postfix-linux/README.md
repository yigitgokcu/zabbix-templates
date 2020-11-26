# zabbix-template-postfix-linux
Zabbix Template for monitoring Postfix in a linux environment.

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/userparamater_postfix.conf  $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/pygtail.py /var/lib/zabbix/scripts/
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/zabbix-postfix-stats.sh /var/lib/zabbix/scripts/
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix-postfix-stats.sh
chmod a+x /var/lib/zabbix/scripts/zabbix-postfix-stats.sh
chown -R zabbix:zabbix /var/lib/zabbix/scripts/pygtail.py 
chmod a+x /var/lib/zabbix/scripts/pygtail.py
rm -rf /tmp/zabbix-templates


# Grant privileges to the script only
echo 'zabbix  ALL=(ALL) NOPASSWD: /var/lib/zabbix/scripts/zabbix-postfix-stats.sh' >> /etc/sudoers  

service zabbix-agent restart
```
Import ```Template App Postfix.xml``` to zabbix server and link with your host.
