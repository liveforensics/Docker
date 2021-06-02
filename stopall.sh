#!/bin/bash

RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color


echo -e "${RED}***********************************************************************************************************************"
echo -e "*                                                                                                                     *"
echo -e "*   CLOSING EVERYTHING DOWN                                                                                           *"
echo -e "*                                                                                                                     *"
echo -e "***********************************************************************************************************************${NC}"
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


