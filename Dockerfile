FROM zabbix/zabbix-web-service:ubuntu-6.4-latest

USER root

RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y install iputils-ping fping dnsutils telnet && \
  cd /usr/sbin; ln -s /usr/bin/fping && \
  chown root:zabbix /usr/bin/fping && \
  chmod u+s /usr/bin/fping && \
  apt-get clean all && \
  unset DEBIAN_FRONTEND

RUN mkdir /var/lib/zabbix && chown zabbix:zabbix /var/lib/zabbix

USER zabbix

RUN echo 'alias nocomments="sed -e :a -re '"'"'s/<\!--.*?-->//g;/<\!--/N;//ba'"'"' | sed -e :a -re '"'"'s/\/\*.*?\*\///g;/\/\*/N;//ba'"'"' | grep -v -P '"'"'^\s*(#|;|--|//|$)'"'"'"' >> ~/.bashrc
