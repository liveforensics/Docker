FROM liveforensics/linuxstarter:1.0.0

RUN mkdir /home/jenkins/terraform

COPY inputs.conf /opt/splunkforwarder/etc/system/local/inputs.conf
COPY outputs.conf /opt/splunkforwarder/etc/system/local/outputs.conf


RUN yum -y install wget unzip && \
    wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip && \
    unzip terraform_0.12.13_linux_amd64.zip -d /usr/local/bin/