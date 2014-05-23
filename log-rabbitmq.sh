#!/bin/bash -ex

mkdir -p /var/log/kazoup/rabbitmq_runit
exec svlogd -tt /var/log/kazoup/rabbitmq_runit
