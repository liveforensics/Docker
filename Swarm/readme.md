# Introduction

Start by creating the public network that glues all the containers together

`docker network create -d overlay --attachable --scope swarm --subnet 10.12.0.0/16 testlab-network`

