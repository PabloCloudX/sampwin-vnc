#!/bin/bash

export HOME=/home/container
export DISPLAY=:1

# Buat password VNC
mkdir -p /home/container/.vnc
x11vnc -storepasswd 1235678 /home/container/.vnc/passwd

# Jalankan Xvfb (virtual display)
Xvfb :1 -screen 0 1024x768x16 &

# Jalankan VNC server
x11vnc -display :1 -rfbauth /home/container/.vnc/passwd -rfbport "$VNC_PORT" -forever &

sleep 2

if [ "$TYPE" = "pawno" ]; then
    echo "[INFO] Menjalankan Pawno Editor"
    wine /home/container/pawno/pawno.exe
elif [ "$TYPE" = "server" ]; then
    echo "[INFO] Menjalankan SA-MP Server"
    wine /home/container/samp-server.exe
else
    echo "[ERROR] TYPE tidak valid: gunakan 'pawno' atau 'server'"
    sleep infinity
fi
