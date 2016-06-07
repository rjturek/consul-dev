## Vagrant setup for Consul and Docker experimentation

Multiple VMs are configured through this one Vagrantfile.

#### IP addresses
DHCP

#### ./shared_data directory contains these scripts.
These are run when the VM is provisioned:
- load-tools.sh ....... runs tools-setup.sh at provisioning time
- tools-setup.sh ..... installs hashitools, docker, etc.

You'll run these manually to start the consul agent in the different modes:
- start_consul_server_prim.sh ..... starts consul server, leader
- start_consul_server_sec.sh ..... starts consul server, follower (optional)
- start_consul_agent.sh ...... starts consul agent


This file is written to the shared directory at runtime. It is not committed to git:
- consul-leader-ip

#### Consul VM Roles
See: https://www.consul.io/docs/agent/basics.html

###### Consul Server Nodes
 The VM named consul1 will be the consul leader server. Always start this VM, as there must always be one leader.

- Run /host_shared_data/start_consul_server_prim.sh to start the primary server.


 VMs consul2 and consul3 are for secondary servers. These are optional; comment them out if you don't want to experiment with a cluster of server nodes.  Use both consul2 and consul3 or use neither.  (We should run only 1, 3, or 5 Consul servers.)

 - Run /host_shared_data/start_consul_server_sec.sh to start the secondary servers.


###### Consul Client Nodes
 VMs named box1, box2 will run the consul agent in client mode (i.e. they are not part of the Raft consensus quorum.)

Static IPs are assigned as DHCP doesn't work on our environment.


http://192.168.56.101:8500/ui
