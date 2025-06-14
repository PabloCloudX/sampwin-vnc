FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y \
    software-properties-common \
    wget curl unzip zip p7zip-full \
    supervisor xvfb x11vnc fluxbox \
    xterm net-tools \
    wine32 wine64 cabextract \
    && apt clean

RUN useradd -m -s /bin/bash sampuser
RUN mkdir -p /home/sampuser/server /root/.vnc
WORKDIR /home/sampuser/server

RUN x11vnc -storepasswd 1235678 /root/.vnc/passwd
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

USER sampuser
EXPOSE 7777 2000-2100 7000-7100 5900-5999

CMD ["/entrypoint.sh"]
