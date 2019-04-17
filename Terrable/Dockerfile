FROM golang:alpine as terraform-bundler-build

RUN apk --no-cache add git unzip tree
RUN git clone https://github.com/hashicorp/terraform.git /etc/mark
WORKDIR /etc/mark
RUN git checkout v0.11
# WORKDIR /go
# RUN tree
# RUN go get -d -u github.com/hashicorp/terraform@v0.11
RUN go install /etc/mark/tools/terraform-bundle

COPY terraform-bundle.hcl .

RUN terraform-bundle package terraform-bundle.hcl
RUN mkdir -p terraform-bundle
RUN unzip -d terraform-bundle terraform_*.zip

#####################################################################################

FROM ubuntu:18.04

MAINTAINER @liveforensics

# Install dependencies.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       software-properties-common \
       python-setuptools \
       python-pip \
       git-core \    
       nano \
       tree \   
       net-tools \
       iputils-ping \
       wget \
       unzip \
       rsyslog systemd systemd-cron sudo \
    && rm -Rf /var/lib/apt/lists/* \
    && rm -Rf /usr/share/doc && rm -Rf /usr/share/man \
    && apt-get clean
RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

COPY --from=terraform-bundler-build /etc/mark/terraform-bundle/* /usr/local/bin/

# Install Ansible via Pip.
RUN pip install ansible pyopenssl markupsafe xmltodict pywinrm 
ARG VER="0.11.13"

RUN mkdir -p /etc/terraform-projects \
    && wget https://releases.hashicorp.com/terraform/${VER}/terraform_${VER}_linux_amd64.zip \
    && unzip terraform_${VER}_linux_amd64.zip \
    && mv terraform /usr/local/bin/ \
    && rm terraform_${VER}_linux_amd64.zip

# RUN git clone https://github.com/hashicorp/terraform.git /etc/terraform

# Install Ansible inventory file.
RUN mkdir -p /etc/ansible
RUN mkdir -p /etc/ansible-projects
RUN echo "[local]\nlocalhost ansible_connection=local" > /etc/ansible/hosts

VOLUME ["/sys/fs/cgroup", "/tmp", "/run"]
CMD ["/lib/systemd/systemd"]