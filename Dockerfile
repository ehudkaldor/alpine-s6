################################################
#
#
#
#
#
################################################

FROM				alpine:3.7
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.org>

ENV					S6_LOGGING 1
ENV					S6_VERSION 1.21.4.0
ENV					ARCH amd64

RUN					echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
						apk add --update gnupg curl confd

ADD					https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-$ARCH.tar.gz /tmp/
ADD					https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-$ARCH.tar.gz.sig /tmp/

RUN					curl https://keybase.io/justcontainers/key.asc | gpg --import && \
						gpg --verify /tmp/s6-overlay-$ARCH.tar.gz.sig /tmp/s6-overlay-$ARCH.tar.gz && \
						gunzip -c /tmp/s6-overlay-$ARCH.tar.gz | tar -xf - -C /

RUN					apk del curl gnupg && \
						rm -rf /tmp/* && \
						rm -rf /var/cache/apk/*

COPY				rootfs /

ENTRYPOINT	["/init"]
