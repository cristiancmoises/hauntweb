title:📦 DockerVM
date: 2024-02-18 00:00
tags: projects
summary: Use docker like Qemu/VmWare/VirtualBox
---
Use docker like Qemu/VmWare/Virtualbox
---
![dockervm](/images/dockervm.png)

### [Exherbo](/download/exherbo.sh)
### [Fedora](/download/fedora.sh)
### [Kali](/download/kali.sh)
### [Void](/download/void.sh)

### ACCESS THE SYSTEM IN THE CONTAINER
       docker run -it IMAGE_ID_HERE /bin/bash
### START ALL STOPPED CONTAINERS
       docker start $(docker ps -a -q --filter "status=exited")
### RUN THE LAST STOPPED CONTAINER:
       docker start -a -i 'docker ps -q -l'
### LIST ALL IMAGES
       docker images
### LIST ALL CONTAINERS
       docker ps -a
### RE-ACCESS THE SYSTEMS
       docker exec -it CONTAINER_ID_HERE /bin/bash
# NOVNC 
### GRAPHICAL INTERFACE
    apt install xfce-desktop xorg -y
### CONFIGURE A PASSWORD FOR ROOT ON KALI
passwd
### FIREWALL - HOST CONFIG
    iptables -A INPUT -i docker0 -j ACCEPT
### CONFIG FOR KALI LINUX
    apt update && apt upgrade && apt install novnc x11vnc tigervnc-standalone-server dbus-x11 python-py python3-pip -y
### NUMPY INSTALL
    user > pip install numpy
    user > pip3 install numpy
### START DBUS
    dbus-launch
### START VNCSERVER
    vncserver
### START NOVNC
/usr/share/novnc/utils/novnc_proxy --listen 8081 --vnc localhost:5900
### ACESS VIA BROWSER
CONTAINER_IP:8081/vnc.html
### FIX SOME HOSTNAME BUGS
echo $(hostname -I | cut -d\  -f1) $(hostname) | sudo tee -a /etc/hosts
