#!/usr/bin/python

import json
import requests
#from urllib3.exceptions import InsecureRequestWarning
import os
import socket
#requests.packages.urllib3.disable_warnings(category=InsecureRequestWarning)

mattermost_url=""

hostname = socket.gethostname()

outgoing_count = os.popen("sudo /usr/sbin/exim -bpr | grep '<' | awk {'print $4'} | cut -d '<' -f 2 | cut -d '>' -f 1 | sort -n | uniq -c | sort -n  | sort -hr | head -n 10").read()

mattermost_data = {'text': "\n " "\nTop Mail Senders - Possibly Spammers on " +str(hostname) + "\n " +str(outgoing_count)}

response = requests.post(mattermost_url, data=json.dumps(mattermost_data),headers={'Content-Type': 'application/json'})
#response = requests.post(mattermost_url, data=json.dumps(mattermost_data),headers={'Content-Type': 'application/json'}, verify=False)
