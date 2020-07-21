# escape=`

FROM centos:centos8.2.2004
LABEL maintainer=liveforensics description="Linux Build Base Image"

RUN dnf update -y && `
    dnf -y install openssh-server initscripts passwd python3 nano git gcc gcc-c++ && `
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' && `
    ssh-keygen -A && `
    ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' && `
    # set the root password
    echo "root:test" | chpasswd && `
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && `
    sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config && `
    rm -f /run/nologin && `
    dnf clean all

ADD ./id_rsa.pub /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]