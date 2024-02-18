title: 👾 Space Invaders
date: 2024-02-15 19:00
tags: projects
summary: SSH for hacking
---
### Amazing tricks for hacking [SSH]
---
![mask](/images/mask.png)
## POWER UP YOUR SEGFAULT ACCESS WITH SOME TRICKS! LET'S HACK!

### Automation with SSH for Hacking
![tor](/images/tor.png)

#### First steps: 
Debian:                                                                 |
    apt update && apt upgrade && apt install sshpass pssh torsocks -y       
Fedora:                                                                   
    dnf update && dnf upgrade && dnf install sshpass pssh tor torsocks -y   
Gentoo:                                                                 
    emerge sshpass pssh tor torsocks                                        

#### START TOR!            
##### SYSTEMD USERS       
    systemctl enable tor  
    systemctl start tor   
##### OPENRC USERS        
    rc-service tor enable 
    rc-service tor start  

### Are you prepared? OK... start with this:

          torify sshpass -p "segfault" pssh -A -i -H "root@lsd.segfault.net:22" uname -a  
### [_Tutorial YouTube_](https://www.youtube.com/embed/OqZiuoV75wQ)

## Do you want go deep? OK...
![dark](/images/dark.png)


## DEEEEEEEEP TUTORIAL...
### [_Tutorial YouTube_](https://youtu.be/fTgD2YGEvrE)
Go to Segfault interactive shell [here](https://shell.segfault.net) 
##### When your machine starts, do this: 
    ssh@lsd.segfault.net       
##### Before access complete do this:     
    ssh@adm.segfault.net         

## And repeat to infinity!
![tunnel](https://github.com/cristiancmoises/spaceinvaders/assets/86272521/a4a527f9-b749-476c-b517-480a5f173143)

> # Knowledge is power. Use it.
