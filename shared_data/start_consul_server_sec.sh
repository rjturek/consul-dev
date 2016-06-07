#!/bin/bash

# Retrieve the IP address assigned to this VM.
CONSUL_IP=$(ifconfig  eth1 | grep "inet addr" | cut -d":" -f 2 | cut -d" " -f1)

#Get the IP of the leader consul server
CONSUL_LEADER_IP=$(cat /host_shared_data/consul-leader-ip)

# Start up the consul server node, advertising this VM's IP and joining to the leader server IP
# TODO can join multiple times. Write out all IPs, agents and servers to a file and join them all.
consul agent -data-dir /tmp/consul-data -advertise $CONSUL_IP -server -client 0.0.0.0 -join $CONSUL_LEADER_IP -ui
