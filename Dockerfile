FROM almir/webhook
MAINTAINER  Andy Savage <andy@savage.hk>
RUN         apk add --update \
							openrc \
							util-linux bash \
							curl docker && \
						rc-update add docker boot && \
            rm -rf /var/cache/apk/*
VOLUME      ["/etc/webhook"]
EXPOSE      9000
ENTRYPOINT  ["/usr/local/bin/webhook"]
