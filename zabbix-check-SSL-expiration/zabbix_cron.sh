#!/bin/bash

cd $(dirname $0)

fn=$(mktemp)

(while read domain; do

echo -e "$domain\t$(./zabbix_info_ssl.sh $domain)" >> $fn

done) < domains.txt

mv $fn result.cache
chown -R zabbix:zabbix /var/lib/zabbix/scripts/zabbix_check_ssl/result.cache
