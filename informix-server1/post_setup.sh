#!/bin/bash


function setup_system()
{ 

#echo "server1.composehademo_default" >> ~informix/.rhosts
#echo "server2.composehademo_default" >> ~informix/.rhosts

touch $INFORMIXDIR/etc/trusted.hosts
chmod 640 $INFORMIXDIR/etc/trusted.hosts

onmode -wf REMOTE_SERVER_CFG=trusted.hosts
onmode -wf CDR_AUTO_DISCOVER=1
onmode -wf TEMPTAB_NOLOG=1
onmode -wf ENABLE_SNAPSHOT_COPY=1
onmode -wf LOG_INDEX_BUILDS=1
dbaccess sysadmin <<!
execute function sysadmin:admin ('cdr add trustedhost', 'server2 informix, server2.composehademo_default informix, server1 informix, server1.composehademo_default informix')
!

dbaccessdemo7 -log db1



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
setup_system

