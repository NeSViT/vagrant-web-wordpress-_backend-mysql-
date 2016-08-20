# Variables for VM: backend
backend_box = 'debian/jessie64'
backend_hostname = 'backend'
backend_domain = 'devops.loc'
backend_ip_private = '10.10.100.10'
backend_cpus = '1'
backend_ram = '512'

# Variables for VM: web
web_box = 'debian/jessie64'
web_hostname = 'web'
web_domain = 'devops.loc'
web_ip_private = '10.10.100.20'
web_cpus = '1'
web_ram = '512'


# Config for VM: backend
Vagrant.configure("2") do |backend|
  backend.vm.box = backend_box
  backend.vm.hostname = backend_hostname +'.'+ backend_domain
  backend.vm.network "private_network", ip: backend_ip_private
  backend.vm.provider "virtualbox" do |backend|
     backend.cpus = backend_cpus
     backend.memory = backend_ram
   end
end

# Config for VM: web
Vagrant.configure("2") do |web|
  web.vm.box = web_box
  web.vm.hostname = web_hostname +'.'+ web_domain
  web.vm.network "private_network", ip: web_ip_private
  web.vm.network "public_network"
  web.vm.synced_folder "./www/wordpress", "/var/www"

  web.vm.provider "virtualbox" do |web|
     # Display the VirtualBox GUI when booting the machine
     # web.gui = true
     
     web.cpus = web_cpus
     # Customize the amount of memory on the VM:
     web.memory = web_ram
   end

   # Enable provisioning	
   web.vm.provision "shell", inline: <<-SHELL
     apt-get update
     apt-get install -y apache2
   SHELL
end
