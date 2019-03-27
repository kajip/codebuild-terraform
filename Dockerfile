#
# Copyright (c) 2017 Tomomi Kajita. All rights reserved.
#
# 参照先：
# TimeZone関連：https://qiita.com/dtan4/items/8359e389b95cbc60952d
#
FROM alpine:latest
MAINTAINER Tomomi Kajita <t-kajita@biglobe.co.jp>

ARG TF_VERSION=0.11.11

ENV TZ=Asia/Toky
ENV LANG=ja_JP.UTF-8

RUN apk --update add --no-cache bash tzdata python py-pip ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    pip install awscli && \
    apk del --purge py-pip && \
    rm -rf "/root/.cache"

ADD https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip /tmp/terraform.zip
RUN unzip /tmp/terraform.zip -d /usr/bin
