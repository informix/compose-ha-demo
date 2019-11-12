#!/bin/bash

function setup_system()
{ 
echo "Setting up System" 

onmode -ky
rm /opt/ibm/data/spaces/root*
#sleep 60
echo "Setting up HDR"
while true 
do
   echo "Running ifxclone"
   ifxclone --source=informix_1 --sourceIP=server1 --sourcePort=9088  --target=informix_3 --targetIP=server3 --targetPort=9088  --trusted  --createchunkfile  --disposition=RSS  --autoconf 
   rc=$?
   if [[ $rc == "0" ]]
   then
      echo "ifxclone SUCCESS"
      break
   else
      sleep 5
   fi
done

}

function wait_for_remote() {
while true 
do
   cnt=`curl http://server1:9088 2>&1|grep Empty|wc -l `
   if [[ $cnt == "1" ]]
   then
      break
   else
      sleep 1
   fi

done

}


function wait_for_sysadmin() {
while true 
do
   cnt=`echo "select count(*) from sysdatabases where name='sysadmin' "| dbaccess sysmaster - |grep -v count|tr -d ' \n'`
   if [[ $cnt == "1" ]]
   then
      break
   else
      sleep 1
   fi

done
}



wait_for_sysadmin
wait_for_remote
setup_system


