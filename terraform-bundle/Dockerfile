FROM golang:alpine

RUN pwd
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

