#!/bin/bash

function setup_system()
{ 
echo "Setting up System" 

#echo "server1.composehademo_default" >> ~informix/.rhosts
#echo "server2.composehademo_default" >> ~informix/.rhosts

#touch $INFORMIXDIR/etc/trusted.hosts
#chmod 640 $INFORMIXDIR/etc/trusted.hosts

#onmode -wf REMOTE_SERVER_CFG=trusted.hosts
#onmode -wf CDR_AUTO_DISCOVER=1
#onmode -wf TEMPTAB_NOLOG=1
#onmode -wf ENABLE_SNAPSHOT_COPY=1
#onmode -wf LOG_INDEX_BUILDS=1

#dbaccess sysadmin <<!
#--execute function sysadmin:admin ('cdr add trustedhost', 'server2 informix, server1 informix, server2.composehademo_default informix, server1.composehademo_default informix')
#!


onmode -ky
rm /opt/ibm/data/spaces/root*
#sleep 60
echo "Setting up HDR"
while true 
do
   echo "Running ifxclone"
   ifxclone --source=informix_1 --sourceIP=server1 --sourcePort=9088  --target=informix_2 --targetIP=server2 --targetPort=9088  --trusted  --createchunkfile  --disposition=HDR  --autoconf 
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


