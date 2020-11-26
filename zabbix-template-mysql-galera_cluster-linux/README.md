# zabbix-template-mysql-galera_cluster-linux
Zabbix Template for monitoring MariaDB &amp; Galera Cluster in a linux environment. 

## Installation

```
git clone https://github.com/yigitgokcu/zabbix-templates.git /tmp/zabbix-templates
cp /tmp/zabbix-templates/zabbix-template-mysql-galera_cluster-linux/userparameter_mysql.conf $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
rm -rf /tmp/zabbix-mysql*

mysql -e "CREATE USER 'zabbix'@'localhost' IDENTIFIED BY '$PASS';"
mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'zabbix'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"

touch /var/lib/zabbix/.my.cnf

echo "[client]
user=zabbix
password=$PASS" >> /var/lib/zabbix/.my.cnf

chown -R zabbix:zabbix /var/lib/zabbix/.my.cnf

service zabbix-agent restart
```
Link ```Template DB MySQL.xml``` with your host on zabbix server.

## For Galera

```
cp /tmp/zabbix-templates/zabbix-template-mysql-galera_cluster-linux/userparameter_galera.conf $(find /etc/zabbix/ -name zabbix_agentd*.d -type d | head -n1)
rm -rf /tmp/zabbix-templates
service zabbix-agent restart
```

Import ```Template DB Galera Cluster.xml``` to zabbix server and link with your host.
Add Value Mapping Information in Galera - Value Mapping.txt 
