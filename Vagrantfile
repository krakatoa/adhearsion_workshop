# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "debian-73-x64"
  # config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/debian-73-x64-virtualbox-puppet.box"

  config.ssh.forward_agent = true
  config.vm.host_name = "fs.adhearsion-demo.com"
  config.vm.synced_folder "manifests/templates", "/tmp/vagrant-puppet-1/templates"

  config.vm.network :public_network

  config.vm.provision :shell do |shell|
    shell.path = "manifests/bootstrap.sh"
  end
  
  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = "manifests"
    puppet.manifest_file  = "site.pp"
    puppet.options = ["--verbose", "--debug", "--templatedir", "/tmp/vagrant-puppet-1/templates", "--parser", "future"]
    puppet.facter = {
    }
  end

  config.vm.synced_folder "manifests/templates", "/tmp/vagrant-puppet-1/templates"

end
