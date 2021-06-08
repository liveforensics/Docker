    docker pull portainer:agent:latest
    docker kill portainer_agent
    docker rm portainer_agent
    
    docker run -d --name portainer_agent --restart always --network testlab-network -e AGENT_CLUSTER_ADDR=tasks.portainer_agent --mount type=npipe,source=\\.\pipe\docker_engine,target=\\.\pipe\docker_engine portainer/agent:latest

    # docker run -d --name portainer_agent --restart always --network portainer_agent_network -e AGENT_CLUSTER_ADDR=tasks.portainer_agent --mount type=npipe,source=\\.\pipe\docker_engine,target=\\.\pipe\docker_engine portainer/agent:windows1803-amd64