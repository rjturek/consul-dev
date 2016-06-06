# -*- mode: ruby -*-
# vi: set ft=ruby :

# Multi machine - see: https://www.vagrantup.com/docs/multi-machine/

Vagrant.configure(2) do |config|

	config.vm.box = "ubuntu/trusty64"

	config.vm.define "consul1" do |consul1|
		consul1.vm.hostname = "consul1"
		consul1.vm.network "forwarded_port", guest: 8080, host: 8888
		consul1.vm.network "forwarded_port", guest: 8500, host: 18500
	end

	config.vm.define "box1" do |box1|
		box1.vm.hostname = "box1"
    end

	config.vm.define "box2" do |box2|
		box2.vm.hostname = "box2"
		box2.vm.network "forwarded_port", guest: 8500, host: 18502
    end

	config.vm.network "private_network", type: "dhcp"
	config.vm.synced_folder "../data", "/mac_shared_data"

	config.vm.provider "virtualbox" do |vb|
    	vb.memory = "1024"
	end

end
