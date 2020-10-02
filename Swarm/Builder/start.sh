docker pull jenkins/jenkins:latest
docker pull sonatype/nexus3

docker stack deploy --compose-file=build-stack.yml builder
