docker pull jenkins/jenkins:latest
docker pull liveforensics/buildbox:2004-powerpc
docker pull liveforensics/buildbox:2004-buildtools2019
docker pull sonatype/nexus3

docker stack deploy --compose-file=build-stack.yml builder
