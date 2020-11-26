# zabbix-template-cpanel-linux
Zabbix Template for monitoring Cpanel Services in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-cpanel-linux/userparameter_cpanel.conf  $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
cp /tmp/zabbix-templates/zabbix-template-cpanel-linux/zabbix_exim-* /var/lib/zabbix/scripts/
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_exim-*
chmod a+x /var/lib/zabbix/scripts/zabbix_exim-*
rm -rf /tmp/zabbix-templates

# Grant privileges to the scripts only
echo 'zabbix ALL=(ALL) NOPASSWD: /usr/sbin/exim -bp' >> /etc/sudoers
echo 'zabbix ALL=(ALL) NOPASSWD: /usr/sbin/whmapi1' >> /etc/sudoers
echo 'zabbix ALL=(ALL) NOPASSWD: /var/lib/zabbix/scripts/zabbix_exim-delete-frozen.sh' >> /etc/sudoers
echo 'zabbix ALL=(ALL) NOPASSWD: /var/lib/zabbix/scripts/zabbix_exim-find-spammer.py' >> /etc/sudoers

service zabbix-agent restart
```
Import  ```Template for Cpanel.xml ```  to zabbix server and link with your host.
