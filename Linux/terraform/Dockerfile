FROM liveforensics/linuxstarter:1.0.0

RUN mkdir /home/jenkins/terraform

COPY inputs.conf /opt/splunkforwarder/etc/system/local/inputs.conf
COPY outputs.conf /opt/splunkforwarder/etc/system/local/outputs.conf


RUN yum -y install wget unzip && \
    wget https://releases.hashicorp.com/terraform/0.12.13/terraform_0.12.13_linux_amd64.zip && \
    unzip terraform_0.12.13_linux_amd64.zip -d /usr/local/bin/ && \
    wget https://dl.google.com/go/go1.13.5.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.13.5.linux-amd64.tar.gz && \
    rm -rf terraform_0.12.13_linux_amd64.zip && \
    rm -rf go1.13.5.linux-amd64.tar.gz