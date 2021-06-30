# escape=`
FROM liveforensics/centosbase:1.0.0

RUN dnf update -y && `
    dnf install sudo dos2unix build-essential pkg-config bison flex autoconf automake libtool make nodejs git -y && `
    dnf clean all




ENTRYPOINT ["/usr/sbin/sshd", "-D"]

