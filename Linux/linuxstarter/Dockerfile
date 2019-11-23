FROM centos:7.5.1804

# ADD epel.repo /etc/yum.repos.d/epel.repo
ENV SPLUNK_PRODUCT universalforwarder
ENV SPLUNK_VERSION 7.3.2
ENV SPLUNK_BUILD c60db69f8e32
# ENV SPLUNK_FILENAME splunkforwarder-${SPLUNK_VERSION}-${SPLUNK_BUILD}-Linux-x86_64.tgz
ENV SPLUNK_FILENAME splunkforwarder-${SPLUNK_VERSION}-${SPLUNK_BUILD}-linux-2.6-x86_64.rpm
ENV SPLUNK_HOME /opt/splunk
ENV SPLUNK_GROUP splunk
ENV SPLUNK_USER splunk
ENV SPLUNK_BACKUP_DEFAULT_ETC /var/opt/splunk
ARG DEBIAN_FRONTEND=noninteractive

RUN yum -y update

RUN yum -y install openssh-server initscripts epel-release
RUN /usr/sbin/sshd-keygen
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

# install java
RUN yum -y install java-11-openjdk git nano tree net-tools python2 wget python-pip

RUN pip install --upgrade pip
# RUN yum -y install git nano tree net-tools

# Add user jenkins to the image
RUN adduser jenkins && \
# Set password for the jenkins user (you may want to alter this).
echo "jenkins:jenkins" | chpasswd && \
mkdir /home/jenkins/.m2 

# ADD settings.xml /home/jenkins/.m2/
COPY authorized_keys /root/.ssh/authorized_keys
COPY authorized_keys /home/jenkins/.ssh/authorized_keys

RUN chown -R jenkins:jenkins /home/jenkins/.m2/ && \
    chown -R jenkins:jenkins /home/jenkins/.ssh/ && \
    chmod -R go= /home/jenkins/.ssh

# Standard SSH port
EXPOSE 22

# set the root password
RUN echo "root:test" | chpasswd

RUN mkdir -p ${SPLUNK_HOME} && \
    wget -qO /tmp/${SPLUNK_FILENAME} https://download.splunk.com/products/${SPLUNK_PRODUCT}/releases/${SPLUNK_VERSION}/linux/${SPLUNK_FILENAME} && \
    rpm -i /tmp/${SPLUNK_FILENAME} && \
    mkdir /var/log/to_splunk
# RUN mkdir /opt/splunkforwarder/etc/system/local
COPY inputs.conf /opt/splunkforwarder/etc/system/local/inputs.conf
COPY outputs.conf /opt/splunkforwarder/etc/system/local/outputs.conf
COPY user-seed.conf /opt/splunkforwarder/etc/system/local/user-seed.conf
# RUN /opt/splunkforwarder/bin/splunk start --accept-license --answer-yes --no-prompt
COPY run.sh /bin/run.sh
RUN chmod 755 /bin/run.sh
# because stupid effing linux gets confused with line endings
RUN sed -i -e 's/\r$//' /bin/run.sh


# set command to run
CMD ["/bin/run.sh"]