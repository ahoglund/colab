# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  config.vm.box = "ubuntu/xenial64"
  config.vm.network :private_network, ip: "192.168.10.10"
  config.vm.provision "shell", inline: <<-SHELL
    sudo apt-get install -y software-properties-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt-get update -y
    sudo apt-get install -y ansible
    sudo ansible-galaxy install -r /vagrant/requirements.yml
    ansible-playbook /vagrant/playbook.yml
  SHELL
end
