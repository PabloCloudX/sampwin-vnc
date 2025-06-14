FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/container

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y \
    software-properties-common \
    wget curl unzip zip p7zip-full \
    supervisor xvfb x11vnc fluxbox \
    xterm net-tools \
    wine32 wine64 cabextract && \
    apt clean

# Pakai user container (default Pterodactyl)
USER container

WORKDIR /home/container

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 7777 2000-2100 7000-7100 5900-5999

CMD ["/entrypoint.sh"]
