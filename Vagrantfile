# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  #config.vm.network :private_network, ip: "192.168.33.4"

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "puppet/manifests"
    puppet.manifest_file  = "base.pp"
    puppet.module_path    = "puppet/modules"
  end
end
### GRANT ALL PRIVILEGES ON *.* TO 'roman'@'192.168.33.1'    IDENTIFIED BY 'dummy' WITH GRANT OPTION;