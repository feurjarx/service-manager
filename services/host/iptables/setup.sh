#!/usr/bin/env bash

## based on http://khaos.su/basic-iptables-setup/
apt-get install --reinstall -y iptables

## anti scan
iptables -N block-scan
iptables -A block-scan -j DROP

## DDos protection (null packages)
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
## DDos protection (SYN-flood)
iptables -A INPUT -p tcp ! --syn -m state NEW -j DROP
## anti scan (XMAS packages)
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

## IP spoofing protection
iptables -A INPUT -p tcp --tcp-flags SYN,FIN SYN,FIN -j DROP
iptables -A INPUT -p tcp --tcp-flags SYN,RST SYN,RST -j DROP
iptables -A INPUT -s 169.254.0.0/16 -j DROP
iptables -A INPUT -s 127.0.0.0/8 -j DROP

## DDos protection
iptables -A INPUT -p tcp --dport 80 -m limit --limit 20/minute --limit-burst 100 -j ACCEPT

## Resolve all traffic from lo
iptables -A INPUT -i lo -j ACCEPT
## Open needed TCP-ports
iptables -A INPUT -p tcp -m tcp --dport 21 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport $SSH_PORT -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 443 -j ACCEPT
## Resolve inbound connections
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

## Drop package by default
iptables -P OUTPUT ACCEPT
iptables -P INPUT DROP

## lock inbound ping (ICMP protocol)
iptables -I INPUT -p icmp --icmp-type 8 -j DROP

## Show rules
iptables -L -n

# Saving of rules
savedRules="/etc/iptables.up.rules"
iptables-save > $savedRules
# Auto loading rules
preUpDir="/etc/network/if-pre-up.d"
mkdir $preUpDir
cat << EOF > $preUpDir/iptables
#!/bin/sh
/sbin/iptables-restore < $savedRules
EOF
chmod +x $preUpDir/iptables

echo "iptables was configured successfully"