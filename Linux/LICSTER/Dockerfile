FROM ubuntu:18.04


RUN apt-get update -y
RUN apt-get install software-properties-common -y
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa
RUN apt-get update -y
RUN apt-get install gcc-arm-embedded -y
RUN apt-get install git nano tree net-tools wget gcc make -y
RUN mkdir /home/licster

WORKDIR /home/licster

ENTRYPOINT ["/bin/bash", "-c", "tail -f /dev/null"]