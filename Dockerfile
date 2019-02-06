FROM alpine:3.9

LABEL maintainer="s10l@github.com"

RUN apk update \
&& apk upgrade \
&& apk add --no-cache \
postfix=3.3.2-r0 \
cyrus-sasl=2.1.27-r0 \
cyrus-sasl-login=2.1.27-r0 \
rsyslog=8.40.0-r3 \
supervisor=3.3.4-r1

WORKDIR /etc

RUN echo "bar" | saslpasswd2 -c -p -a smtpauth -u example.net foo \
&& sasldblistusers2 && chown postfix /etc/sasl2/sasldb2

ADD build/ /

EXPOSE 25 465 587

CMD ["supervisord",  "-c", "/etc/supervisord.conf"]