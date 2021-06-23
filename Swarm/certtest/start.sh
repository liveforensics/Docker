#!/bin/bash
docker pull traefik:latest

export NODE_ID=$(docker info -f '{{.Swarm.NodeID}}')
export EMAIL=liveforensicsuk@gmail.com
export DOMAIN=murraykatt.net
export USERNAME=admin
export PASSWORD=rainbowlightning
export HASHED_PASSWORD=$(openssl passwd -apr1 $PASSWORD)
export USE_HOSTNAME=$HOSTNAME

echo $NODE_ID
echo $EMAIL
echo $HASHED_PASSWORD

docker stack deploy -c traefik.yaml traefik