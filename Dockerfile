FROM openjdk:8-alpine

VOLUME [ "/server", "config", "plugins" ]
WORKDIR /server

ENV WATERFALL_HOME=/server\
    WATERFALL_BASE_URL=https://papermc.io/ci/job/Waterfall\
    MEMORY=512m\
    UID=1000\
    GID=1000

COPY *.sh /usr/bin/run-waterfall.sh

RUN apk --no-cache add curl bash sudo

EXPOSE 25577


RUN set -x\
    && addgroup -g ${GID} -S waterfall\
    && adduser -u ${UID} -D -S -G waterfall waterfall\
    && addgroup waterfall wheel\
    && chmod +x /usr/bin/*.sh

CMD [ "/usr/bin/run-waterfall.sh" ]