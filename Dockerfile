FROM almir/webhook
MAINTAINER  Andy Savage <andy@savage.hk>
RUN         apk add --no-cache --update \
							jq util-linux bash \
							curl docker && \
            rm -rf /var/cache/apk/*
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
