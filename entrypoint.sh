#!/bin/bash

export HOME=/home/container

supervisord &

sleep 2

if [ "$TYPE" == "server" ]; then
    echo "[INFO] Menjalankan SA-MP Server..."
    wine samp-server.exe
elif [ "$TYPE" == "pawno" ]; then
    echo "[INFO] Menjalankan Pawno Editor..."
    x11vnc -display :0 -rfbport "$VNC_PORT" -usepw -forever &
    wine pawno.exe
else
    echo "[INFO] Tidak ada TYPE valid."
    sleep infinity
fi
