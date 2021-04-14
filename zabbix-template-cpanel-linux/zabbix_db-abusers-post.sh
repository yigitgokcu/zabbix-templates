#!/bin/sh

# Envs
# ---------------------------------------------------\

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

WEBHOOK_URL=

sudo sh /path/to/zabbix/scripts/db_abusers/zabbix_db-abusers.sh | sort -nr | head -n 10 > /path/to/zabbix/scripts/db_abusers/$(date +%Y%m%d-%H-%M)-db_abusers.txt
sudo curl -X POST -H 'Content-type: application/json' --data "{\"text\": \" \n :warning: $(printf "**Top DB Users by MySQL Queries on `hostname`** \n\n" && cat $(find /path/to/zabbix/scripts/db_abusers/ -name "*.txt" -type f -exec ls -at {} + | head -1))\"}" https://$WEBHOOK_URL

exit
