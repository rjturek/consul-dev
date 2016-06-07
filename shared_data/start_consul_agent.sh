#!/bin/bash
# Capture the IP of this VM
CONSUL_IP=$(ifconfig  eth1 | grep "inet addr" | cut -d":" -f 2 | cut -d" " -f1)

# Grab the IP of the leader consul server
CONSUL_LEADER_IP=$(cat /host_shared_data/consul-leader-ip)

# Start agent, advertise this IP, join the leader
# TODO can join multiple times. Write out all IPs, agents and servers to a file and join them all.
consul agent -ui -data-dir /tmp/consul-data -advertise $CONSUL_IP -join $CONSUL_LEADER_IP
