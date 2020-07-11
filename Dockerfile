FROM alpine

ADD start.sh /start.sh
ADD config.conf /config.conf

RUN wget https://github.com/pymumu/smartdns/releases/download/Release31/smartdns.1.2020.05.04-0005.x86_64-linux-all.tar.gz \
  && tar zxvf smartdns.*.tar.gz \
  && mv smartdns/usr/sbin /bin/smartdns \
  && chmod +x /bin/smartdns \
  && chmod +x /start.sh \
  && rm -rf smartdns* \
  && mkdir -p /smartdns
  
USER root

WORKDIR /

VOLUME ["/smartdns"]

EXPOSE 53

CMD ["/start.sh"]
