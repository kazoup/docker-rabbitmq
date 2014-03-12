FROM phusion/baseimage:0.9.8

RUN apt-get update
RUN apt-get upgrade -y


RUN apt-get install -y erlang \
                       erlang-doc \
                       wget

# add the kazoup dev ssh key
ADD id_rsa.kazoup_dev.pub /tmp/id_rsa.kazoup_dev.pub
RUN cat /tmp/id_rsa.kazoup_dev.pub >> /root/.ssh/authorized_keys && rm -f /tmp/id_rsa.kazoup_dev.pub
#RUN chmod 600 /root/.ssh/authorized_keys

# generate a host key
RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

RUN cd /tmp \
    && wget -O rabbitmq_server.tgz http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.3/rabbitmq-server-generic-unix-3.2.3.tar.gz --no-check-certificate \
    && tar -zxf rabbitmq_server.tgz \
    && rm -rf *.tgz \
    && mkdir -p /srv/kazoup/kazoup-services/rabbitmq/tmp \
    && mv /tmp/rabbitmq_server-3.2.3 /tmp/rabbitmq_server \
    && mv /tmp/rabbitmq_server /srv/kazoup/kazoup-services/rabbitmq/

RUN mkdir -p /etc/service/rabbitmq
ADD run-rabbitmq.sh /etc/service/rabbitmq/run

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
EXPOSE 22
EXPOSE 5672
