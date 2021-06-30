# escape=`
FROM centos:centos8.2.2004

RUN dnf update -y && `
    dnf install openssh-server java-11-openjdk initscripts passwd nano git gcc gcc-c++ make -y && `
    ssh-keygen -t rsa -f /root/.ssh/id_rsa -N '' && `
    ssh-keygen -A && `
    sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd && `
    sed -i "s/#UseDNS yes/UseDNS no/" /etc/ssh/sshd_config && `
    dnf clean all

ADD http://192.168.200.111/ssh/authorized_keys /root/.ssh/authorized_keys

RUN chmod 700 /root/.ssh && chmod 600 /root/.ssh/authorized_keys

EXPOSE 22

ENTRYPOINT ["/usr/sbin/sshd", "-D"]

