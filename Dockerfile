FROM alpine:3.6

LABEL maintainer="s10l@github.com"

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postfix=3.1.4-r1 \
cyrus-sasl=2.1.26-r10 \
rsyslog=8.26.0-r0 \
supervisor=3.2.4-r0

WORKDIR /etc

RUN echo "bar" | saslpasswd2 -c -p -a smtpauth -u example.net foo \
&& sasldblistusers2 && chown postfix /etc/sasldb2

ADD build/ /

EXPOSE 25 465 587

CMD ["supervisord",  "-c", "/etc/supervisord.conf"]