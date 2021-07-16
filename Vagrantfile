# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV['VAGRANT_NO_PARALLEL'] = 'yes'

Vagrant.configure(2) do |config|

  config.vm.provision "shell", path: "provision/vagrant/main.sh"

  # Kubernetes Master Server
  config.vm.define "master" do |node|
  
    node.vm.box               = "generic/ubuntu2004"
    node.vm.box_check_update  = false
    node.vm.box_version       = "3.2.18"
    node.vm.hostname          = "master"

    node.vm.network "private_network", ip: "172.0.0.100"
  
    node.vm.provider :virtualbox do |v|
      v.name    = "master"
      v.memory  = 2048
      v.cpus    =  2
    end
  
    node.vm.provider :libvirt do |v|
      v.memory  = 2048
      v.nested  = true
      v.cpus    = 2
    end
  
    node.vm.provision "shell", path: "provision/vagrant/master.sh"
  
  end


  # Kubernetes Worker Nodes
  NodeCount = 2

  (1..NodeCount).each do |i|

    config.vm.define "worker#{i}" do |node|

      node.vm.box               = "generic/ubuntu2004"
      node.vm.box_check_update  = false
      node.vm.box_version       = "3.2.18"
      node.vm.hostname          = "worker#{i}"

      node.vm.network "private_network", ip: "172.0.1.10#{i}"

      node.vm.provider :virtualbox do |v|
        v.name    = "worker#{i}"
        v.memory  = 1024
        v.cpus    = 1
      end

      node.vm.provider :libvirt do |v|
        v.memory  = 1024
        v.nested  = true
        v.cpus    = 1
      end

      node.vm.provision "shell", path: "provision/vagrant/worker.sh"

    end

  end

end