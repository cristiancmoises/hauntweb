    sudo iptables -t nat -A OUTPUT -p tcp -m owner --uid-owner USERAQUI -m tcp -j REDIRECT --to-ports 9040
    sudo iptables -t nat -A OUTPUT -p udp -m owner --uid-owner USERAQUI -m udp --dport 53 -j REDIRECT --to-ports 53
    sudo iptables -t filter -A OUTPUT -p tcp -m owner --uid-owner USERAQUI -m tcp --dport 9040 -j ACCEPT
    sudo iptables -t filter -A OUTPUT -p udp -m owner --uid-owner USERAQUI -m udp --dport 53 -j ACCEPT
    sudo iptables -t filter -A OUTPUT -m owner --uid-owner USERAQUI -j DROP
