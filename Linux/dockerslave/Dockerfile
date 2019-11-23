FROM centos:7.5.1804

# ADD epel.repo /etc/yum.repos.d/epel.repo

RUN yum -y update

RUN yum -y install openssh-server initscripts 
RUN /usr/sbin/sshd-keygen
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
RUN sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config

# install docker
# ADD docker-ce.repo /etc/yum.repos.d/docker-ce.repo
RUN yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
RUN yum -y --nogpgcheck install docker-ce docker-compose

# install java
RUN yum -y install java-11-openjdk

RUN yum -y install git nano tree net-tools

ADD authorized_keys /root/.ssh/authorized_keys
ADD id_rsa /root/.ssh/
ADD id_rsa.pub /root/.ssh/

RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys
# set the root password
RUN echo "root:test" | chpasswd

# set command to run
CMD ["/usr/sbin/sshd", "-D"]