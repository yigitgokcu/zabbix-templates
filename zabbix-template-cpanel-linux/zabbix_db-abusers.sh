#!/bin/sh

# Envs
# ---------------------------------------------------\

PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)


# Vars
# ---------------------------------------------------\

FILENAME=$(hostname | cut -d '.' -f 1)

# Main
# ---------------------------------------------------\

# Check if there's a query log file
# ---------------------------------------------------\

if [ -s /var/lib/mysql/$FILENAME.log ] then

truncate -s 0 /var/lib/mysql/$FILENAME.log

else

touch /var/lib/mysql/$FILENAME.log 
chown -R mysql:mysql /var/lib/mysql/$FILENAME.log

fi

# Enable logging & Gather data & Disable logging
# ---------------------------------------------------\

mysql -e "set global general_log = 'ON';"
mysql -e "set global general_log_file = '/var/lib/mysql/$FILENAME.log';"
sleep 1m
mysql -e "set global general_log = 'OFF';"

array=(`grep  "[0-9] Connect" /var/lib/mysql/$FILENAME.log |grep -v Query|awk '{print $4}'|cut -d"@" -f1|sort|uniq`)

for user in ${array[@]} ;do
                user_conn=(`grep $user /var/lib/mysql/$FILENAME.log|awk '{print $2}'|sort|uniq`)
                user_finish=0
                for connection in ${user_conn[@]};do
                        conn_number=$(grep $connection /var/lib/mysql/$FILENAME.log|wc -l)
                        user_finish=$((($user_finish + $conn_number)))
                done

        echo $user_finish $user
done

# ---------------------------------------------------\

# Delete .txt files older than 1 day
# ---------------------------------------------------\

find /path/to/zabbix/scripts/db_abusers/ -name "*.txt" -type f -mtime +1 -exec rm -f {} \;

exit
