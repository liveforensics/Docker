docker kill agent
docker rm agent
docker run -d --rm --name agent -v \\.\pipe\docker_engine:\\.\pipe\docker_engine -e JENKINS_URL='http://192.168.0.65:8080/computer/windows/slave-agent.jnlp' -e JENKINS_SECRET='2af8070afb0e383ee454d7fe308d9dd0e83882ea1b520543ae8f1e9e239790a5'  liveforensics/jenkinsagent:1.0.0