FROM node:alpine

MAINTAINER Elliot J. Reed <docker-contact@elliotjreed.com>

RUN apk update && apk upgrade && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/community >> /etc/apk/repositories && \
    echo @edge http://nl.alpinelinux.org/alpine/edge/main >> /etc/apk/repositories && \
    apk add --no-cache chromium@edge nss@edge

RUN yarn global add puppeteer

RUN addgroup -S puppet && adduser -S -g puppet puppet && \
    mkdir -p /home/puppet/Downloads && \
    chown -R puppet:puppet /home/puppet && \
    chown -R puppet:puppet /opt

USER puppet

WORKDIR /opt

CMD ["chromium-browser", "--headless"]
