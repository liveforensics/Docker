# escape=`
FROM liveforensics/centosbase:1.0.0

RUN dnf update -y && `
    dnf install sudo dos2unix gcc gcc-c++ make pkg-config bison flex autoconf automake libtool nodejs git -y && `
    dnf clean all

COPY run.sh /bin/run.sh
RUN chmod 755 /bin/run.sh
# because stupid effing linux gets confused with line endings
RUN sed -i -e 's/\r$//' /bin/run.sh    

WORKDIR /usr/local/src/

RUN git clone https://github.com/thiagoralves/OpenPLC_v2.git

RUN find . -type f -exec dos2unix {} \;

WORKDIR /usr/local/src/OpenPLC_v2

RUN printf "n\n1\n" | bash build.sh

#Start the server
# CMD node server.js
CMD ["/bin/run.sh"]
# ENTRYPOINT ["/usr/sbin/sshd", "-D"]

