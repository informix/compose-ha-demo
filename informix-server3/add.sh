#!/bin/bash


curl -G http://server1:27018/sysadmin/%24cmd --data-urlencode "query={'runFunction':'admin', 'arguments':['cdr add trustedhost','server4 informix']}"

