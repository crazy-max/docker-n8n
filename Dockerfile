ARG N8N_VERSION=0.114.0

FROM node:14-alpine AS builder
RUN apk --update --no-cache add \
    build-base \
    ca-certificates \
    gcc \
    git \
    python \
  && rm -rf /tmp/* /var/cache/apk/*

ARG N8N_VERSION
WORKDIR /dist
RUN git clone --branch n8n@${N8N_VERSION} https://github.com/n8n-io/n8n .
RUN npm config set unsafe-perm true
RUN npm install -g lerna
RUN npm install --production --loglevel notice
RUN lerna bootstrap --hoist -- --production
RUN npm run build

FROM node:14-alpine
LABEL maintainer="CrazyMax"

RUN apk --update --no-cache add \
    ca-certificates \
    graphicsmagick \
    libressl \
    shadow \
    tzdata \
  && apk --no-cache add --virtual fonts \
    fontconfig \
    msttcorefonts-installer \
  && update-ms-fonts \
  && fc-cache -f \
  && addgroup -g 1500 n8n \
  && adduser -u 1500 -G n8n -h /data -s /bin/sh -D n8n \
  && mkdir /app \
  && chown n8n. /app \
  && npm_config_user=n8n npm install -g full-icu \
  && apk del fonts \
  && rm -rf /tmp/* /var/cache/apk/*

ENV TZ="UTC" \
  NODE_ICU_DATA="/usr/local/lib/node_modules/full-icu" \
  DATA_FOLDER="/data"

COPY --from=builder --chown=n8n:n8n  /dist /app

WORKDIR /app
USER n8n

VOLUME [ "/data" ]
EXPOSE 5678

ENTRYPOINT [ "node", "/app/packages/cli/bin/n8n" ]
