# zabbix-template-nginx-linux
Zabbix Template for monitoring NGINX in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-nginx-linux/zabbix-nginx/statistics.conf /etc/nginx/conf.d/ && service nginx restart
rm -rf /tmp/zabbix-templates

service zabbix-agent restart
```
Import ```  Template App Nginx by Zabbix agent.xml``` to zabbix server and link with your host.
