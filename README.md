# Vagrant setup for Consul and Docker VMs

Multiple VMs are configured through this one Vagrantfile.

### ./shared_data directory contains these scripts
- load-tools.sh ....... runs tools-setup.sh at provisioning time
- start_consul_agent.sh ...... starts consul agent
- start_consul_server_prim.sh ..... starts consul server, leader
- start_consul_server_sec.sh ..... starts consul server, follower
- tools-setup.sh

consul-server-ip


 VM named consul1  

Static IPs are assigned as DHCP doesn't work on our environment.

http://192.168.56.101:8500/ui
