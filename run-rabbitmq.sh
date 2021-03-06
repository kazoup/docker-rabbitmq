#!/bin/bash

# call 'rabbitmqctl stop' when exiting"
export HOME=/srv/kazoup/kazoup-services/rabbitmq/tmp
export RABBITMQ_NODENAME=kazoup-rabbitmq@localhost
trap '{ echo Stopping rabbitmq; /srv/kazoup/kazoup-services/rabbitmq/rabbitmq_server/sbin/rabbitmqctl stop; exit 0;}' EXIT

echo 'Starting rabbitmq'
exec /srv/kazoup/kazoup-services/rabbitmq/rabbitmq_server/sbin/rabbitmq-server 2>&1
