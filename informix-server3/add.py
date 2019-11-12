import requests
import json


query='''{"$sql": "execute function admin ('create dbspace', 'dbs1', '/opt/ibm/data/spaces/dbs1', '20M', '0')"  }'''
query='''{"$sql": "execute function admin ('cdr add trustedhost', 'server3 informix, server3.composehademo_default informix')" }'''



req = "http://server1:27018/sysadmin/system.sql?query="+query

reply = requests.get(req)
if reply.status_code == 200:
   print ("Query SUCCESS")
else:
   print ("Query FAILURE")

print (reply.content)
