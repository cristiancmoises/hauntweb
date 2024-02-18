title: 🖥️ ServerVM
date: 2024-02-16 19:00
tags: projects
summary: Graphical interface for servers using VNC
---
Graphical Interface for Servers with NoVnc
---
    apt install novnc psmisc x11vnc tigervnc-standalone-server xterm terminator wget dbus-x11 python-py python3-pip xfce4 xorg -y

# StartVnc Server
 
     tigervncserver -geometry 1366x768 -xstartup /usr/bin/terminator

# Start NOVNC

    /usr/share/novnc/utils/launch.sh --listen 8080 --vnc localhost:5901

# Access Your Server:

     http://SERVERIP:8080/vnc.html

# Kill the connection:
    fuser -k 8080/tcp
