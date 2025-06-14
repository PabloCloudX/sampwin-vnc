FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/container
ENV DISPLAY=:1

RUN dpkg --add-architecture i386 && apt update && apt install -y \
    wget curl unzip zip xterm net-tools supervisor \
    fluxbox xvfb x11vnc wine32 wine64 cabextract \
    && apt clean

WORKDIR /home/container
COPY . /home/container

RUN chmod +x /home/container/entrypoint.sh

EXPOSE 7777 7000-7099

# Pterodactyl non-root
USER 1000:1000

CMD ["/home/container/entrypoint.sh"]
