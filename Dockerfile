FROM alpine:3.7

LABEL maintainer="s10l@github.com"

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postfix=3.2.4-r1 \
cyrus-sasl=2.1.26-r11 \
rsyslog=8.31.0-r0 \
supervisor=3.3.3-r1

WORKDIR /etc

RUN echo "bar" | saslpasswd2 -c -p -a smtpauth -u example.net foo \
&& sasldblistusers2 && chown postfix /etc/sasldb2

ADD build/ /

EXPOSE 25 465 587

CMD ["supervisord",  "-c", "/etc/supervisord.conf"]