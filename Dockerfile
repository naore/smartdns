FROM alpine

ENV VERSION=Release31

ADD start.sh /start.sh
ADD config.conf /config.conf

RUN wget https://github.com/pymumu/smartdns/releases/download/$VERSION/smartdns-x86_64 \
  && mv smartdns-x86_64 /bin/smartdns \
  && chmod +x /bin/smartdns \
  && chmod +x /start.sh \
  
USER root

WORKDIR /

VOLUME ["/smartdns"]

EXPOSE 53/udp

CMD ["/start.sh"]
