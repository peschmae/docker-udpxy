FROM debian:buster as build

LABEL maintainer="mathis.petermann@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
ENV HOME /tmp
WORKDIR /tmp

RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y wget make gcc && \
    wget http://www.udpxy.com/download/udpxy/udpxy-src.tar.gz && \
    tar -xzvf udpxy-src.tar.gz && \
    cd udpxy-1.0.23-12 && make && \
    chmod 0755 udpxy && chmod 0755 udpxrec

FROM debian:buster-slim as udpxy

COPY --from=build /tmp/udpxy-1.0.23-12/udpxy /usr/local/bin/udpxy
COPY --from=build /tmp/udpxy-1.0.23-12/udpxrec /usr/local/bin/udpxrec

EXPOSE 4022

CMD ["/usr/local/bin/udpxy", "-T", "-p", "4022"]
