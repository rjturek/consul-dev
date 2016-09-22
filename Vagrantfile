# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi machine - see: https://www.vagrantup.com/docs/multi-machine/

Vagrant.configure(2) do |config|

	config.vm.box = "ubuntu/trusty64"

	config.vm.define "consul1" do |consul1|
		consul1.vm.network "private_network", ip: "192.168.56.101"
		consul1.vm.hostname = "consul1"
	end

	 config.vm.define "consul2" do |consul2|
	 	consul2.vm.network "private_network", ip: "192.168.56.102"
	 	consul2.vm.hostname = "consul2"
    end

    config.vm.define "consul3" do |consul3|
	 	consul3.vm.network "private_network", ip: "192.168.56.103"
	 	consul3.vm.hostname = "consul3"
     end

	config.vm.define "box1" do |box1|
		box1.vm.network "private_network", ip: "192.168.56.104"
		box1.vm.hostname = "box1"
    end

	config.vm.define "box2" do |box2|
		box2.vm.network "private_network", ip: "192.168.56.105"
		box2.vm.hostname = "box2"
    end

    #config.vm.network "private_network", type: "dhcp"
	config.vm.synced_folder "./shared_data", "/host_shared_data"
	config.vm.provision :shell, path: "./shared_data/load-tools.sh"

	config.vm.provider "virtualbox" do |vb|
    	vb.memory = "1024"
	end

end
