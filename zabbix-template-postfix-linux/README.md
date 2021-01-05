# zabbix-template-postfix-linux
Zabbix Template for monitoring Postfix in a linux environment.

## Installation

```
mkdir /var/lib/zabbix/scripts/zabbix_postfix
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/userparamater_postfix.conf  $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/pygtail.py /var/lib/zabbix/scripts/zabbix_postfix/
cp /tmp/zabbix-templates/zabbix-template-postfix-linux/zabbix-postfix-stats.sh /var/lib/zabbix/scripts/zabbix_postfix/
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_postfix/
chmod a+x /var/lib/zabbix/scripts/zabbix_postfix/zabbix_postfix-stats.sh 
chmod a+x /var/lib/zabbix/scripts/zabbix_postfix/pygtail.py
rm -rf /tmp/zabbix-templates


# Grant privileges to the script only
echo 'zabbix  ALL=(ALL) NOPASSWD: /var/lib/zabbix/scripts/zabbix_postfix/zabbix_postfix-stats.sh' >> /etc/sudoers  

service zabbix-agent restart
```
Import ```Template App Postfix.xml``` to zabbix server and link with your host.
