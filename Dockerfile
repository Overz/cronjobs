FROM alpine:latest

# força verificação se o container esta ok, caso contrario irá matar a execução
HEALTHCHECK --interval=3s CMD [ -e /tmp/.lock ] || exit 1

# Disable Prompt During Packages Installation
# ARG DEBIAN_FRONTEND=noninteractive

# define variaveis de ambiente
ENV PROXY_HTTP=""
ENV PROXY_HTTPS=""
ENV HOSTS_FILE=""
ENV DEFAULT_USER=""
ENV DEFAULT_GROUP=""
ENV DEFAULT_HOME=""
ENV SHRC=""
ENV TZ=""
ENV GIT_AUTH_TOKEN=""
ENV GIT_SSL_NO_VERIFY=""
ENV REPOSITORY_URL=""
ENV GIT_AUTH=""
ENV GIT_CONFIG=""
ENV REPOSITORY=""
ENV NAME=""
ENV VERSION=""
ENV WORKDIR=""
ENV IMAGE=""
ENV LOGS=""
ENV JOBS_DIR=""
ENV CROND_LOGS=""
ENV CRONTAB_CONFIG=""
ENV PID_DIR=""
ENV JAVA_8=""
ENV JAVA_HOME=""
ENV JAVA_CA_CERTS=""

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
