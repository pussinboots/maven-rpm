# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

   config.vm.define :web do |web_config|
	  # Every Vagrant virtual environment requires a box to build off of.
	  web_config.vm.box = "centos64"
	  web_config.vm.host_name = "helloworld"
   end
   
   config.vm.define :apache do |db_config|
	  # Every Vagrant virtual environment requires a box to build off of.
	  db_config.vm.box = "centos64"
	  db_config.vm.host_name = "apache" 
   end
   
    config.vm.share_folder "local-yumrepo", "/yum-repo", "yum-repo"
	  # Enable the Puppet provisioner
	  config.vm.provision :puppet do |puppet|
	    puppet.options = "--verbose --debug"
	    puppet.manifest_file  = "site.pp"
	  end
end

