FROM python:3.7.0-alpine3.7

RUN apk update && apk add --no-cache nginx certbot runit gettext openssl

RUN mkdir /etc/service/nginx
RUN mkdir /run/nginx
RUN mkdir /acme

#Remove when it is volume
RUN mkdir /cert

COPY nginx.conf /nginx.conf
COPY certbot.sh /certbot.sh
RUN chmod a+x /certbot.sh

COPY ./crontab /var/spool/cron/crontabs/root

COPY nginx.sh /etc/service/nginx/run
RUN chmod a+x /etc/service/nginx/run
COPY crond.sh /etc/service/crond/run
RUN chmod a+x /etc/service/crond/run


COPY start.sh /start.sh
RUN chmod a+x /start.sh




ENTRYPOINT /start.sh

