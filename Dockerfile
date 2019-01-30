# Dockerfile for https://github.com/adnanh/webhook
FROM golang:alpine3.8 AS build
MAINTAINER Almir Dzinovic <almir@dzinovic.net>
ARG WEBHOOK_REPO="adnanh/webhook"
WORKDIR "/go/src/github.com/$WEBHOOK_REPO"
RUN apk add --update -t build-deps curl libc-dev gcc libgcc && \
curl -L --silent -o webhook.tar.gz https://github.com/adnanh/webhook/archive/$(curl -s "https://api.github.com/repos/$WEBHOOK_REPO/releases/latest" | awk -F '"' '/tag_name/{print $4}').tar.gz && \
tar -xzf webhook.tar.gz --strip 1 && \
go get -d && \
go build -o /usr/local/bin/webhook && \
apk del --purge build-deps && \
rm -rf /var/cache/apk/* && \
rm -rf /go

FROM docker:stable-dind
COPY --from=build /usr/local/bin/webhook /usr/local/bin/webhook

MAINTAINER  Andy Savage <andy@savage.hk>
RUN         apk add --no-cache --update \
							jq util-linux bash git \
							curl wget coreutils && \
            rm -rf /var/cache/apk/*
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
