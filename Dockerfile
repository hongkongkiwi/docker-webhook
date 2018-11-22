FROM almir/webhook
MAINTAINER  Andy Savage <andy@savage.hk>
RUN         apk add --update util-linux bash curl && \
            rm -rf /var/cache/apk/*
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
