FROM ubuntu:latest


RUN dpkg --add-architecture i386 && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wine-development && \
    apt-get clean  && \
    rm -rf /var/lib/apt/lists/*

ENV WINEARCH=win64 \
    WINEDEBUG=-all
	
RUN wineboot --init

WORKDIR /opt/server
COPY scripts/. /usr/local/bin


ENTRYPOINT [ "docker-entrypoint.sh" ]
