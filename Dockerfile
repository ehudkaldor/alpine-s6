################################################
#
#
#
#
#
################################################

FROM				alpine:latest
MAINTAINER	Ehud Kaldor <ehud@unfairfunction.org>

ENV					S6_LOGGING 1
ENV					S6_VERSION 1.22.1.0
ENV					SOCKLOG_VERSION 3.1.0-2
ENV					ARCH amd64

RUN					echo "http://dl-3.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
						apk add --update gnupg curl confd

ADD					https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-$ARCH.tar.gz /tmp/
ADD					https://github.com/just-containers/s6-overlay/releases/download/v$S6_VERSION/s6-overlay-$ARCH.tar.gz.sig /tmp/
ADD         https://github.com/just-containers/socklog-overlay/releases/download/v$SOCKLOG_VERSION/socklog-overlay-$ARCH.tar.gz /tmp/

RUN					curl https://keybase.io/justcontainers/key.asc | gpg --import && \
						gpg --verify /tmp/s6-overlay-$ARCH.tar.gz.sig /tmp/s6-overlay-$ARCH.tar.gz && \
						gunzip -c /tmp/socklog-overlay-amd64.tar.gz | tar -xf - -C / && \
						gunzip -c /tmp/s6-overlay-$ARCH.tar.gz | tar -xf - -C /

RUN					apk del curl gnupg && \
						rm -rf /tmp/* && \
						rm -rf /var/cache/apk/*

COPY				rootfs /

ENTRYPOINT	["/init"]
