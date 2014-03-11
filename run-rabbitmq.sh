#!/bin/bash

# call 'rabbitmqctl stop' when exiting"
export HOME=/srv/kazoup/kazoup-services/rabbitmq/tmp
trap '{ echo Stopping rabbitmq; /srv/kazoup/kazoup-services/rabbitmq/rabbitmq_server/sbin/rabbitmqctl stop; exit 0;}' EXIT

echo 'Starting rabbitmq'
/srv/kazoup/kazoup-services/rabbitmq/rabbitmq_server/sbin/rabbitmq-server
