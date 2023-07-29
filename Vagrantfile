# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "host1" do |host1|
    host1.vm.hostname = "host1"
    host1.vm.box = "acntech/ubuntu-server"
    host1.vm.box_version = "22.04"
    host1.vm.synced_folder ".", "/home/vagrant/naivenet", create: true
    host1.vm.network "public_network", use_dhcp_assigned_default_route: true
  end

  config.vm.define "host2" do |host2|
    host2.vm.hostname = "host2"
    host2.vm.box = "acntech/ubuntu-server"
    host2.vm.box_version = "22.04"
    host2.vm.synced_folder ".", "/home/vagrant/naivenet", create: true
    host2.vm.network "public_network", use_dhcp_assigned_default_route: true
  end

end
