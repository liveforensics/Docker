# escape=`
FROM liveforensics/centosbase:1.0.0

RUN dnf update -y && `
    dnf install sudo dos2unix gcc gcc-c++ make pkg-config bison flex autoconf automake libtool nodejs git -y && `
    dnf clean all

WORKDIR /usr/local/src/

RUN git clone https://github.com/thiagoralves/OpenPLC_v2.git && `
    find . -type f -exec dos2unix {} \; && `
    printf "n\n1\n" | bash /usr/local/src/OpenPLC_v2/build.sh

ENTRYPOINT ["/usr/sbin/sshd", "-D"]

