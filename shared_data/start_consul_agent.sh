#!/bin/bash
CONSUL_IP=$(ifconfig  eth1 | grep "inet addr" | cut -d":" -f 2 | cut -d" " -f1)

CONSUL_SERVER_IP=$(cat /host_shared_data/consul-server-ip)

consul agent -ui -data-dir /tmp/consul-data -advertise $CONSUL_IP -join $CONSUL_SERVER_IP
