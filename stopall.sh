#!/bin/bash
echo '***********************************************************************************************************************'
echo '*                                                                                                                     *'
echo '*   CLOSING EVERYTHING DOWN                                                                                           *'
echo '*                                                                                                                     *'
echo '***********************************************************************************************************************'
cd Swarm

cd Builder
pwd
sh stop.sh 

cd ..
cd traefik
pwd
sh stop.sh

cd ..
cd portainer
pwd
sh stop.sh

cd ..
pwd 

echo .
echo .
echo .
echo .
echo .

docker node ls
docker service ls


