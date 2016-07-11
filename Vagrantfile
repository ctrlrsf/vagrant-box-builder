# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
#
#
Vagrant.configure("2") do |config|
  config.vm.box = "gbarbieru/xenial"
  config.ssh.insert_key = false
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get dist-upgrade -y
    apt-get clean -y

    # Disable apt-daily service on boot
    # Conflicts with apt-get update ran by Vagrant when bringing up a new box
    # Causes dpkg lock error
    systemctl disable apt-daily.service
    systemctl disable apt-daily.timer
  SHELL
end
