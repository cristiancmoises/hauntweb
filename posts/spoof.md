title:👻 SpoofMac
date: 2024-02-11 23:00
tags: projects
summary: Change mac address
---
Change mac address on reboot
---
![spoof](https://user-images.githubusercontent.com/86272521/158036393-e9df6c24-c152-481a-9c57-f6deee207fd8.png)

# Download
## [SpoofMac](/download/spoofmac.sh)
   [eth0](/download/eth0.sh)
   [enp6s0](/download/enp6s0)

### <> SPOOF YOUR MAC ADDRESS: </>

- *Install macchanger*;
- First run ifconfig and take your interface name;
- In the script i use: wlan0 (I created the enp6s0 script to enp6s0 interfaces)
- Download the macchanger.sh;
- chmod +x macchanger.sh
- crontab -e
- @reboot /home/Download/macchanger.sh
 > Have a nice day! :)

