FROM almir/webhook
MAINTAINER  Andy Savage <andy@savage.hk>
RUN         apk add --no-cache --update \
							jq util-linux bash git openssh-client \
							curl wget coreutils docker && \
            rm -rf /var/cache/apk/*
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
