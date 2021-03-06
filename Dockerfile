FROM alpine:latest

# força verificação se o container esta ok, caso contrario irá matar a execução
HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

# argumentos de build
ARG PROXY_HTTP
ARG PROXY_HTTPS
ARG HOSTS_FILE
ARG DEFAULT_USER
ARG DEFAULT_GROUP
ARG DEFAULT_HOME
ARG SHRC
ARG TZ
ARG GIT_AUTH_TOKEN
ARG GIT_SSL_NO_VERIFY
ARG REPOSITORY_URL
ARG GIT_AUTH
ARG GIT_CONFIG
ARG REPOSITORY
ARG NAME
ARG VERSION
ARG WORKDIR
ARG IMAGE
ARG LOGS
ARG JOBS_DIR
ARG CROND_LOGS
ARG CRONTAB_CONFIG
ARG PID_DIR
ARG JAVA_8
ARG JAVA_HOME
ARG JAVA_CA_CERTS
# Disable Prompt During Packages Installation
# ARG DEBIAN_FRONTEND=noninteractive

# define variaveis de ambiente
ENV PROXY_HTTP=${PROXY_HTTP}
ENV PROXY_HTTPS=${PROXY_HTTPS}
ENV HOSTS_FILE=${HOSTS_FILE}
ENV DEFAULT_USER=${DEFAULT_USER}
ENV DEFAULT_GROUP=${DEFAULT_GROUP}
ENV DEFAULT_HOME=${DEFAULT_HOME}
ENV SHRC=${SHRC}
ENV TZ=${TZ}
ENV GIT_AUTH_TOKEN=${GIT_AUTH_TOKEN}
ENV GIT_SSL_NO_VERIFY=${GIT_SSL_NO_VERIFY}
ENV REPOSITORY_URL=${REPOSITORY_URL}
ENV GIT_AUTH=${GIT_AUTH}
ENV GIT_CONFIG=${GIT_CONFIG}
ENV REPOSITORY=${REPOSITORY}
ENV NAME=${NAME}
ENV VERSION=${VERSION}
ENV WORKDIR=${WORKDIR}
ENV IMAGE=${IMAGE}
ENV LOGS=${LOGS}
ENV JOBS_DIR=${JOBS_DIR}
ENV CROND_LOGS=${CROND_LOGS}
ENV CRONTAB_CONFIG=${CRONTAB_CONFIG}
ENV PID_DIR=${PID_DIR}
ENV JAVA_8=${JAVA_8}
ENV JAVA_HOME=${JAVA_HOME}
ENV JAVA_CA_CERTS=${JAVA_CA_CERTS}

# adc java ao path
ENV PATH=$PATH:$JAVA_HOME

# add dependencies
RUN apk update --no-cache
RUN apk add --no-cache git tini openrc nano curl tzdata procps openjdk8 autoconf net-tools busybox-initscripts
RUN apk upgrade --no-cache

ADD ${HOSTS_FILE} ${HOSTS_FILE}
ADD ${GIT_CONFIG} ${GIT_CONFIG}
ADD ${SHRC} ${SHRC}
ADD /entrypoint /entrypoint

ENTRYPOINT [ "tini", "--" ]

CMD [ "/entrypoint" ]
