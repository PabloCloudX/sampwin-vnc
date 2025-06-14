FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV HOME=/home/container
ENV DISPLAY=:1

RUN dpkg --add-architecture i386 && apt update && apt install -y \
    wine32 wine64 cabextract xvfb x11vnc fluxbox xterm \
    curl unzip zip wget p7zip-full net-tools \
    && apt clean

RUN echo '#!/bin/bash\n\
export HOME=/home/container\n\
export DISPLAY=:1\n\
\n\
VNC_PORT="${VNC_PORT:-5900}"\n\
VNC_PASS="${VNC_PASS:-12345678}"\n\
\n\
if [ "$TYPE" = "pawno" ]; then\n\
    echo "[INFO]: Start Pawno Editor"\n\
    echo "[INFO]: VNC akan berjalan di port $VNC_PORT"\n\
    mkdir -p /home/container/.vnc\n\
    x11vnc -storepasswd "$VNC_PASS" /home/container/.vnc/passwd >/dev/null 2>&1\n\
    Xvfb :1 -screen 0 1024x768x16 >/dev/null 2>&1 &\n\
    sleep 2\n\
    x11vnc -display :1 -rfbauth /home/container/.vnc/passwd -rfbport "$VNC_PORT" -forever -shared -noxdamage >/dev/null 2>&1 &\n\
    /home/container/pawno/pawno.exe\n\
elif [ "$TYPE" = "samp" ]; then\n\
    echo "[INFO]: Start SA-MP Server"\n\
    wine /home/container/samp-server.exe\n\
else\n\
    echo "[ERROR]: TYPE tidak valid. Gunakan '\''samp'\'' atau '\''pawno'\''"\n\
    sleep infinity\n\
fi' > /pablo.sh && chmod +x /pablo.sh

WORKDIR /home/container

EXPOSE 7777 2000-2100 5900-5999

USER 1000:1000

CMD ["/pablo.sh"]
