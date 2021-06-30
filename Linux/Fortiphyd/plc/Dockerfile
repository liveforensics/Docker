# escape=`
FROM liveforensics/centosbase:1.0.0

RUN dnf update -y && `
    dnf install sudo dos2unix gcc gcc-c++ make pkg-config bison flex autoconf automake libtool nodejs git -y && `
    dnf clean all




ENTRYPOINT ["/usr/sbin/sshd", "-D"]

