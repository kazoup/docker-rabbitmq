# ubuntu 13.10
FROM ubuntu:13.10

RUN apt-get update
RUN apt-get upgrade -y

# Configure ssh
RUN apt-get install -y openssh-server
RUN mkdir -p /var/run/sshd
RUN echo "root:root" | chpasswd
RUN sed -i "s/UsePAM yes/UsePAM no/g" /etc/ssh/sshd_config

RUN apt-get install -y erlang \
                            erlang-doc \
                            supervisor \
                            wget

RUN cd /tmp; wget -O rabbitmq_server.tgz http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.3/rabbitmq-server-generic-unix-3.2.3.tar.gz --no-check-certificate; tar -zxf rabbitmq_server.tgz; rm -rf *.tgz
RUN mkdir -p /srv/kazoup/kazoup-services/rabbitmq/tmp
RUN mv /tmp/rabbitmq_server-3.2.3 /tmp/rabbitmq_server
RUN mv /tmp/rabbitmq_server /srv/kazoup/kazoup-services/rabbitmq/

ADD rabbitmq.sh /srv/kazoup/kazoup-services/rabbitmq.sh
RUN chmod +x /srv/kazoup/kazoup-services/rabbitmq.sh

ADD supervisord.conf /etc/supervisor/supervisord.conf

EXPOSE 22
EXPOSE 5672
CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
