# escape=`
FROM centos:centos8.2.2004

ARG VERSION=4.3
ARG user=jenkins
ARG group=jenkins
ARG uid=1000
ARG gid=1000

RUN groupadd -g ${gid} ${group}
RUN useradd -c "Jenkins user" -d /home/${user} -u ${uid} -g ${gid} -m ${user}
LABEL Description="This is a base image, which provides the Jenkins agent executable (agent.jar)" Vendor="Jenkins project" Version="${VERSION}"

ARG AGENT_WORKDIR=/jenkinsroot

RUN mkdir /jenkinsroot && `
    dnf update -y && `
    dnf -y install openssh-server initscripts passwd nano git gcc gcc-c++ && `
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && `
    ssh-keygen -A && `
    ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' && `
    # set the root password
    echo "root:test" | chpasswd && `
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && `
    sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config && `
    rm -f /run/nologin && `
    dnf clean all && `
    curl --create-dirs -fsSLo /usr/share/jenkins/agent.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar && `
    chmod 755 /usr/share/jenkins && `
    chmod 644 /usr/share/jenkins/agent.jar && `
    ln -sf /usr/share/jenkins/agent.jar /usr/share/jenkins/slave.jar

USER ${user}
ENV AGENT_WORKDIR=${AGENT_WORKDIR}
RUN mkdir /home/${user}/.jenkins

VOLUME /home/${user}/.jenkins
VOLUME ${AGENT_WORKDIR}
WORKDIR /home/${user}