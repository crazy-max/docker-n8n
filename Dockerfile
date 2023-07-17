# syntax=docker/dockerfile:1

ARG N8N_VERSION=0.236.1
ARG NODE_VERSION=18

FROM node:${NODE_VERSION}-alpine
RUN apk --update --no-cache add \
    ca-certificates \
    graphicsmagick \
    libc6-compat \
    libressl \
    openssh \
    shadow \
    tzdata \
  && apk --no-cache add --virtual fonts \
    fonts \
    fontconfig \
    msttcorefonts-installer \
  && update-ms-fonts \
  && fc-cache -f \
  && addgroup -g 1500 n8n \
  && adduser -u 1500 -G n8n -h /data -s /bin/sh -D n8n \
  && npm_config_user=n8n npm install -g full-icu \
  && apk del fonts \
  && rm -rf /tmp/*

WORKDIR /app
ARG N8N_VERSION
RUN apk --update --no-cache add --virtual .build \
    build-base \
    git \
    python3 \
  && npm_config_user=n8n npm install --omit=dev n8n@${N8N_VERSION} \
  && chown -R n8n. /app \
  && apk del .build \
  && rm -rf /root /tmp/* \
  && mkdir /root

USER n8n

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

VOLUME [ "/data" ]
EXPOSE 5678

ENTRYPOINT [ "node", "/app/node_modules/n8n/bin/n8n" ]
