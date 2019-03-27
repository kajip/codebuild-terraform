#
# Copyright (c) 2017 Tomomi Kajita. All rights reserved.
#
# 参照先：
# TimeZone関連：https://qiita.com/dtan4/items/8359e389b95cbc60952d
#
FROM alpine:latest
MAINTAINER Tomomi Kajita <t-kajita@biglobe.co.jp>

ARG TF_URL=https://releases.hashicorp.com/terraform/0.11.13/terraform_0.11.13_linux_amd64.zip

ENV TZ=Asia/Toky
ENV LANG=ja_JP.UTF-8

RUN apk --update add --no-cache bash tzdata python py-pip ca-certificates && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    pip install awscli && \
    apk del --purge py-pip && \
    rm -rf "/root/.cache"

ADD ${TF_URL} /tmp/terraform.zip
RUN unzip /tmp/terraform.zip -d /usr/bin
