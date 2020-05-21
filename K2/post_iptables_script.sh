#!/bin/sh

### Custom user script
### Called after internal iptables reconfig (firewall update)

ipset -N gfwlist iphash -!
iptables -t nat -A PREROUTING -p tcp -m set --match-set gfwlist dst -j REDIRECT --to-port 1080
/etc/storage/ssr-redir -c /etc/storage/ssr.json &
/etc/storage/ssr-tunnel -c /etc/storage/ssr.json -l 5353 -L 8.8.8.8:53 -u &

##dnsmasq.conf conf-dir=/etc/storage/dnsmasq.d