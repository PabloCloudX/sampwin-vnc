#!/bin/bash

export HOME=/home/container

supervisord &

sleep 2

if [ "$TYPE" == "server" ]; then
    echo "[INFO] Menjalankan SA-MP Server..."
    wine /home/container/samp-server.exe

elif [ "$TYPE" == "pawno" ]; then
    echo "[INFO] Menjalankan Pawno Editor..."
    
    mkdir -p /home/container/.vnc
    x11vnc -storepasswd 1235678 /home/container/.vnc/passwd

    x11vnc -display :0 -rfbauth /home/container/.vnc/passwd -rfbport "$VNC_PORT" -forever &

    wine /home/container/pawno/pawno.exe

else
    echo "[INFO] TYPE tidak valid. Gunakan 'server' atau 'pawno'."
    sleep infinity
fi
