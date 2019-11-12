# compose-hq-demo

## Default compose file:
    docker-compose.yml

## Full Documentation
1.  See __doc__ folder.


## Quickstart Steps

### Pre-requisites
1.  docker
2.  docker-compose

### Start docker compose:
1.  cd to project directory 
2.  Run __chmod -R 777 *__
3.  Run __docker-compose up -d informix-hqserver informix-server1 informix-server2__
    - This will start an HQSERVER, and 2 informix database servers.  (Primary & Secondary)
4.  Wait cpl minutes.  Go the the HQ server website.  When The HDR Pari is up and running, start the RSS
    - Run __docker-compose up -d informix-server3__

### Up & Running:
    1.  After a few minutes 2 informix containers will be  start.  With a load placed on both servers.
    2.  An HQ server will be started 
    3.  Go to http://<ip address> (user: admin Password: Passw0rd) 

### Stop and remove Containers & volume
1.  docker-compose down -v


