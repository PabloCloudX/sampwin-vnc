#!/bin/bash

export HOME=/home/container
export DISPLAY=:1

# Variabel default
VNC_PORT="${VNC_PORT:-5900}"
VNC_PASS="${VNC_PASS:-12345678}"

if [ "$TYPE" = "pawno" ]; then
    echo "[INFO]: Start Pawno Editor"
    echo "[INFO]: VNC akan berjalan di port $VNC_PORT"

    # Setup password VNC
    mkdir -p /home/container/.vnc
    x11vnc -storepasswd "$VNC_PASS" /home/container/.vnc/passwd >/dev/null 2>&1

    # Start virtual display
    Xvfb :1 -screen 0 1024x768x16 >/dev/null 2>&1 &

    sleep 2

    # Start VNC dengan log dimatikan
    x11vnc -display :1 -rfbauth /home/container/.vnc/passwd -rfbport "$VNC_PORT" -forever -shared -noxdamage \
        >/dev/null 2>&1 &

    # Jalankan pawno.exe
    wine /home/container/pawno/pawno.exe

elif [ "$TYPE" = "samp" ]; then
    echo "[INFO]: Start SA-MP Server"
    wine /home/container/samp-server.exe

else
    echo "[ERROR]: TYPE tidak valid. Gunakan 'samp' atau 'pawno'"
    sleep infinity
fi
