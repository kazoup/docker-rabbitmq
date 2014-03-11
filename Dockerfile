FROM phusion/baseimage:0.9.8

RUN apt-get update
RUN apt-get upgrade -y


RUN apt-get install -y erlang \
                       erlang-doc \
                       wget

RUN cd /tmp \
    && wget -O rabbitmq_server.tgz http://www.rabbitmq.com/releases/rabbitmq-server/v3.2.3/rabbitmq-server-generic-unix-3.2.3.tar.gz --no-check-certificate \
    && tar -zxf rabbitmq_server.tgz \
    && rm -rf *.tgz \
    && mkdir -p /srv/kazoup/kazoup-services/rabbitmq/tmp \
    && mv /tmp/rabbitmq_server-3.2.3 /tmp/rabbitmq_server \
    && mv /tmp/rabbitmq_server /srv/kazoup/kazoup-services/rabbitmq/

RUN mkdir -p /etc/service/rabbitmq
ADD run-rabbitmq.sh /etc/service/rabbitmq/run

EXPOSE 22
EXPOSE 5672
CMD ["/sbin/my_init"]
