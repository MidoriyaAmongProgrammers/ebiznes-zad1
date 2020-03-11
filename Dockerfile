FROM  frolvlad/alpine-scala

ENV SCALA_VERSION=2.12.8 \
SBT_VERSION=1.3.8

RUN \
  echo "$SCALA_VERSION $SBT_VERSION" && \
  apk add --no-cache bash curl bc ca-certificates && \
  update-ca-certificates && \
  scala -version && \
  scalac -version && \
  curl -fsL https://github.com/sbt/sbt/releases/download/v$SBT_VERSION/sbt-$SBT_VERSION.tgz | tar xfz - -C /usr/local && \
  $(mv /usr/local/sbt-launcher-packaging-$SBT_VERSION /usr/local/sbt || true) && \
  ln -s /usr/local/sbt/bin/* /usr/local/bin/ && \
  apk del curl && \
  sbt sbtVersion

RUN  apk add \
        git \
        vim \
	unzip

RUN apk add curl gnupg
RUN apk add --update nodejs npm
RUN npm install -g npm@6.8.0

EXPOSE 8000
EXPOSE 9000
EXPOSE 5000
EXPOSE 8888

VOLUME /home/latkowski/projekt
