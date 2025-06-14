FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/container
ENV DISPLAY=:1

RUN dpkg --add-architecture i386 && apt update && apt install -y \
    wine32 wine64 cabextract xvfb x11vnc fluxbox xterm \
    curl unzip zip wget p7zip-full net-tools \
    && apt clean

WORKDIR /home/container
COPY . /home/container
RUN chmod +x /home/container/entrypoint.sh

EXPOSE 7777 2000-2100 5900-5999

USER 1000:1000

CMD ["bash entrypoint.sh"]
