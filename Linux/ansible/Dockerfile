FROM liveforensics/linuxstarter:1.0.1

RUN mkdir /home/jenkins/ansible

COPY inputs.conf /opt/splunkforwarder/etc/system/local/inputs.conf
COPY outputs.conf /opt/splunkforwarder/etc/system/local/outputs.conf

# RUN yum -y install epel-release ansible
RUN pip install ansible==2.7.6