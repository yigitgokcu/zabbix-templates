#!/bin/sh

# Envs
# ---------------------------------------------------\
PATH=$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin
SCRIPT_PATH=$(cd `dirname "${BASH_SOURCE[0]}"` && pwd)

# User Configurable Variables
# ---------------------------------------------------\
HOSTNAME=$(hostname)

# 1 minute load avg
#MAX_LOAD=

# kB
#MAX_SWAP_USED=

# kB
#MAX_MEM_USED=

# packets per second inbound
#MAX_PPS_IN=
           
# packets per second outbound
#MAX_PPS_OUT=
            
# max processes in the process list
#MAX_PROCS=
# ---------------------------------------------------\

IFACE=`grep ETHDEV /etc/wwwacct.conf | awk '{print $2}'`
if [[ "$IFACE" =~ "ens" ]] ; then
    IFACE=ens192

elif [[ "$IFACE" =~ "eth" ]] ; then
    IFACE=eth0
fi

IFACE=${IFACE}:

# 1 min load avg
# ---------------------------------------------------\
ONE_MIN_LOADAVG=`cut -d . -f 1 /proc/loadavg`
echo "1 minute load avg: $ONE_MIN_LOADAVG"

# swap used
# ---------------------------------------------------\
SWAP_TOTAL=`grep ^SwapTotal: /proc/meminfo | awk '{print $2}'`
SWAP_FREE=`grep ^SwapFree: /proc/meminfo | awk '{print $2}'`

let "SWAP_USED = (SWAP_TOTAL - SWAP_FREE)"
echo "Swap used: $SWAP_USED kB"

# mem used
# ---------------------------------------------------\
MEM_TOTAL=`grep ^MemTotal: /proc/meminfo | awk '{print $2}'`
MEM_FREE=`grep ^MemFree: /proc/meminfo | awk '{print $2}'`

let "MEM_USED = (MEM_TOTAL - MEM_FREE)"
echo "Mem used: $MEM_USED kB"

# packets received
# ---------------------------------------------------\
PACKETS_RX_1=`grep $IFACE /proc/net/dev | awk '{print $2}'`
sleep 2;
PACKETS_RX_2=`grep $IFACE /proc/net/dev | awk '{print $2}'`

let "PACKETS_RX = (PACKETS_RX_2 - PACKETS_RX_1) / 2"
echo "packets received (2 secs): $PACKETS_RX"

# packets sent
# ---------------------------------------------------\
PACKETS_TX_1=`grep $IFACE /proc/net/dev | awk '{print $10}'`
sleep 2;
PACKETS_TX_2=`grep $IFACE /proc/net/dev | awk '{print $10}'`

let "PACKETS_TX = (PACKETS_TX_2 - PACKETS_TX_1) / 2"
echo "packets sent (2 secs): $PACKETS_TX"

let "SWAP_USED = SWAP_TOTAL - SWAP_FREE"
if [ ! "$SWAP_USED" == 0 ] ; then
    PERCENTAGE_SWAP_USED=`echo $SWAP_USED / $SWAP_TOTAL | bc -l`
    TOTAL_PERCENTAGE=`echo ${PERCENTAGE_SWAP_USED:1:2}%`
else
    TOTAL_PERCENTAGE='0%'
fi

# number of processes
# ---------------------------------------------------\
MAX_PROCS_CHECK=`ps ax | wc -l`

#send_alert_mail()
# {
# Write stats to a file
# ---------------------------------------------------\
#   cat >> /path/to/stats/$(date +%Y%m%d-%H-%M)-stats.txt <<EOL
#   
#   TOP 10 CPU CONSUMING PROCESSES
#   -----
#   $(/bin/ps -eo pcpu,user,pid,args | sort -k1 -r -n | head -10)
#   
#   TOP 10 MEMORY CONSUMING PROCESSES
#   -----
#   $(/bin/ps -eo pmem,user,vsize,pid,args | sort -k1 -r -n | head -10)
#
#   TOP DISK INTENSIVE PROCESSES
#   -----
#   $(iotop -bao -n1)
#
#   OUTGOING TRAFFIC
#    -----
#   $(iftop -npblBP -i ${IFACE} -t -s 1)
#
#   MYSQL NUMBER OF CONNECTION FOR EACH HOST
#   -----
#   $(mysql -u root -e "SELECT `HOST`, COUNT(*) FROM information_schema.processlist GROUP BY `HOST`;")
#
#   MYSQL - NUMBER OF CONNECTION FOR EACH USER 
#   -----
#   $(mysql -u root -e "SELECT `USER`, count(*) FROM information_schema.processlist GROUP by `USER`;")
#
#   MYSQL - AVERAGE QUERY TIME FOR EACH DB
#   -----
#   $(mysql -u root -e "SELECT `DB`, AVG(`TIME`) FROM information_schema.processlist GROUP BY `DB`;")
# EOL

#    EMAIL=""
#    SUBJECTLINE=" $HOSTNAME [L: $ONE_MIN_LOADAVG] [P: $MAX_PROCS_CHECK] [Swap Use: $TOTAL_PERCENTAGE ] [Mem Used: $MEM_USED kB] [pps in: $PACKETS_RX  pps out: $PACKETS_TX]"
#    FILE=/path/to/stats/$(ls -at /path/to/stats/ | head -1)
#    mailx -a $FILE -s "$SUBJECTLINE" $EMAIL  < /dev/null
#    exit
# }

send_alert_mattermost()

 {

# Write stats to a file
# ---------------------------------------------------\

cat >> /path/to/stats/$(date +%Y%m%d-%H-%M)-stats.txt <<EOL

TOP 10 CPU CONSUMING PROCESSES
-----
$(/bin/ps -eo pcpu,user,pid,args | sort -k1 -r -n | head -10)

TOP 10 MEMORY CONSUMING PROCESSES
-----
$(/bin/ps -eo pmem,user,vsize,pid,args | sort -k1 -r -n | head -10)

TOP DISK INTENSIVE PROCESSES
-----
$(iotop -bao -n1)

OUTGOING TRAFFIC
-----
$(iftop -npblBP -i ${IFACE} -t -s 1)

MYSQL NUMBER OF CONNECTION FOR EACH HOST
-----
$(mysql -u root -e 'SELECT `HOST`, COUNT(*) FROM information_schema.processlist GROUP BY `HOST`;')

MYSQL - NUMBER OF CONNECTION FOR EACH USER 
-----
$(mysql -u root -e 'SELECT `USER`, count(*) FROM information_schema.processlist GROUP by `USER`;')

MYSQL - AVERAGE QUERY TIME FOR EACH DB
-----
$(mysql -u root -e 'SELECT `DB`, AVG(`TIME`) FROM information_schema.processlist GROUP BY `DB`;')

EOL

   FILE=$(find /path/to/stats/ -name "*.txt" -type f -exec ls -at {} + | head -1)
   MSG=$(printf %s "$HOSTNAME [L: $ONE_MIN_LOADAVG] [P: $MAX_PROCS_CHECK] [Swap Use: $TOTAL_PERCENTAGE ] [Mem Used: $MEM_USED kB] [pps in: $PACKETS_RX  pps out: $PACKETS_TX] \n -----" && printf %s "\n -----" && cat $FILE && printf %s "\n -----")
   PAYLOAD="payload={\"channel\": \"$CHANNEL\", \"text\": \":warning: $MSG\"}"
   CHANNEL=""
   WEBHOOK_URL=

   curl -X POST --data-urlencode "$PAYLOAD" "$WEBHOOK_URL"
   exit
 }

# Delete .txt files older than 1 day
# ---------------------------------------------------\
find /path/to/stats/ -name "*-stats.txt" -type f -mtime +1 -exec rm -f {} \;

send_alert_mattermost

# If the thresholds have been reached send alert
# ---------------------------------------------------\
#   if   [ $ONE_MIN_LOADAVG -gt $MAX_LOAD      ] ; then send_alert_mattermost
#   elif [ $SWAP_USED       -gt $MAX_SWAP_USED ] ; then send_alert_mattermost
#   elif [ $MEM_USED        -gt $MAX_MEM_USED  ] ; then send_alert_mattermost
#   elif [ $PACKETS_RX      -gt $MAX_PPS_IN    ] ; then send_alert_mattermost
#   elif [ $PACKETS_TX      -gt $MAX_PPS_OUT   ] ; then send_alert_mattermost
#   elif [ $MAX_PROCS_CHECK -gt $MAX_PROCS     ] ; then send_alert_mattermost
#fi
