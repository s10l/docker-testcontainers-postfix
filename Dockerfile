FROM alpine:3.8

LABEL maintainer="s10l@github.com"

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postfix=3.3.0-r4 \
cyrus-sasl=2.1.26-r14 \
rsyslog=8.34.0-r0 \
supervisor=3.3.4-r1

WORKDIR /etc

RUN echo "bar" | saslpasswd2 -c -p -a smtpauth -u example.net foo \
&& sasldblistusers2 && chown postfix /etc/sasldb2

ADD build/ /

EXPOSE 25 465 587

CMD ["supervisord",  "-c", "/etc/supervisord.conf"]