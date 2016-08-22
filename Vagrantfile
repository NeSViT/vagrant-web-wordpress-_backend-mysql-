# Variables for VM: backend
backend_box = 'ubuntu/trusty64'
backend_hostname = 'backend'
backend_domain = 'devops.loc'
backend_ip_private = '10.10.100.10'
backend_cpus = '1'
backend_ram = '512'

# Variables for VM: web
web_box = 'ubuntu/trusty64'
web_hostname = 'web'
web_domain = 'devops.loc'
web_ip_private = '10.10.100.20'
web_cpus = '1'
web_ram = '512'

#START VAGRANT MULTIPLE MACHINE CONFIG

Vagrant.configure("2") do |config|

# START GLOBAL PROVISION SECTION
  config.vm.provision "shell", inline: <<-SHELL
     
     echo "UPDATE REPO"
     apt-get update
     
     echo "INSTALL COMMON SOFTWARE"
     apt-get install -y htop atop lsof
  
  SHELL
# FINISH GLOBAL PROVISION SECTION

# ==========================
# Start  Config for VM: backend

	config.vm.define "backend" do |backend|
		
		backend.vm.box = backend_box
  	backend.vm.hostname = backend_hostname +'.'+ backend_domain
  	backend.vm.network "private_network", ip: backend_ip_private
  		
		backend.vm.provider "virtualbox" do |backend|
     			backend.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          backend.cpus = backend_cpus
     			backend.memory = backend_ram
  	end
    
    # START backend PROVISION SECTION
    backend.vm.provision "shell", inline: <<-SHELL
        
        echo "INSTALLING MYSQL-SERVER with password root"
        echo "mysql-server mysql-server/root_password password root" | sudo debconf-set-selections
        echo "mysql-server mysql-server/root_password_again password root" | sudo debconf-set-selections
        sudo apt-get -y install mysql-server
        
        echo "CREATE DATABASE AND USER FOR WORDPRESS"
        /vagrant/backend/mysql/db_config.sh

        echo "COPY NEW MYSQL CONFIG"
        cp /vagrant/backend/mysql/my.cnf /etc/mysql/my.cnf

        echo "RESTART MYSQL"
        service mysql restart
    SHELL

    # FINISH backend PROVISION SECTION

  end

# End Config for VM: backend
# ==========================

# ==========================
# Start  Config for VM: web

	config.vm.define "web" do |web|
  		
		web.vm.box = web_box
  		web.vm.hostname = web_hostname +'.'+ web_domain
  		web.vm.network "private_network", ip: web_ip_private
  		web.vm.network "public_network", bridge: ["wlo1"]
  		web.vm.synced_folder "wordpress-sources", "/var/www/wordpress"
      #web.vm.synced_folder "web/apache2", "/etc/apache2/sites-available"
	
  		web.vm.provider "virtualbox" do |web|	
     			web.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
          web.cpus = web_cpus
		     	web.memory = web_ram
		  end

    # START web PROVISION SECTION
    web.vm.provision "shell", inline: <<-SHELL
       
       echo "INSTALLING APACHE2 AND PHP5"
       apt-get install -y apache2 php5 php5-mysql mysql-client
       
       echo "INSERT DIRECTORY ROOT TO DEFAULT APACHE CONFIG"
       sed -i 's/html/wordpress/g' /etc/apache2/sites-available/000-default.conf
       
       echo "AUTO SETUP INSTALL.PHP IN WORDPRESS and ADD 10 NEW POSTS"
       /vagrant/web/wordpress-configure.sh

       echo "RESTART APACHE2 SERVICE"
       service apache2 restart

    SHELL
    # FINISH web PROVISION SECTION
	
  end
# End Config for VM: web
# ==========================

end
# END VAGRANT MULTIPLE MACHINE CONFIG