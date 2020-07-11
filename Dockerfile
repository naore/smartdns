FROM alpine

ENV VERSION=Release31

RUN wget https://github.com/pymumu/smartdns/releases/download/$VERSION/smartdns-x86_64 \
  && mv smartdns-x86_64 /bin/smartdns \
  && chmod +x /bin/smartdns \
  && echo '#!/bin/sh
if [ ! -f /smartdns/smartdns.conf ]; then
	mkdir -p /smartdns
	cp -u /config.conf /smartdns/smartdns.conf
fi
/bin/smartdns -f -x -c /smartdns/smartdns.conf' > /start.sh \
  && chmod +x /start.sh \
  && echo '# https://github.com/pymumu/smartdns/blob/master/etc/smartdns/smartdns.conf
bind-tcp [::]:53
bind [::]:53
tcp-idle-time 3
cache-size 4096
prefetch-domain yes
serve-expired yes
serve-expired-ttl 0
speed-check-mode tcp:80,tcp:443,ping
rr-ttl-min 60
rr-ttl-max 86400
log-level warn
server 8.8.8.8 -blacklist-ip -check-edns
server 223.5.5.5
server-tcp 119.29.29.29
server-tcp 64.6.64.6
server-tcp 114.114.114.119
server-tls 1.1.1.1
server-tls 8.8.4.4
server-tls 9.9.9.9
server-https https://cloudflare-dns.com/dns-query' > /config.conf 
  
USER root

WORKDIR /

VOLUME ["/smartdns"]

EXPOSE 53/udp

CMD ["/start.sh"]
