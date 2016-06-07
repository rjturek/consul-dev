#!/bin/bash

# Retrieve the IP address assigned to this VM.
CONSUL_IP=$(ifconfig  eth1 | grep "inet addr" | cut -d":" -f 2 | cut -d" " -f1)

# Start up the consul server node, advertising this VM's IP
consul agent -data-dir /tmp/consul-data -advertise $CONSUL_IP -server -client 0.0.0.0 -bootstrap -ui

# Write the IP to a file on the shared file system so that agents know the cluster to join
echo $CONSUL_IP > /host_shared_data/consul-leader-ip
