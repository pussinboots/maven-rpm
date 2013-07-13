# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

   config.vm.define :web do |web_config|
	  web_config.vm.box = "CentOS64_201307"
	  web_config.vm.host_name = "helloworld.com"
   end
   
   #config.vm.define :apache do |apache_config|
	  #apache_config.vm.box = "CentOS64_201307"
	  #apache_config.vm.host_name = "apache.com" 
   #end
   
   config.vm.share_folder "local-yumrepo", "/yum-repo", "yum-repo"
    # Enable the Puppet provisioner
   config.vm.provision :puppet do |puppet|
	puppet.options = "--verbose --debug"
	puppet.manifest_file  = "site.pp"
   end
end

