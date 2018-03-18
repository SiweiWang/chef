#!/bin/bash

# Ensure password authentication is turned on
sudo sed -i "s/^PasswordAuthentication no/PasswordAuthentication yes/g" /etc/ssh/sshd_config

cat /etc/hosts
sudo yum update
sudo yum install -y net-tools wget python

# Chef Server install and config
# Chef version
CHEF_VERSION=12.17.33

# Download Chef
sudo wget -P /tmp https://packages.chef.io/files/stable/chef-server/${CHEF_VERSION}/el/7/chef-server-core-12.17.33-1.el7.x86_64.rpm

# install chef from the downloaded package
sudo rpm -Uvh chef-server-core-${CHEF_VERSION}-1.el7.x86_64.rpm

# configure Chef server
sudo  chef-server-ctl reconfigure

# create a chef user
sudo mkdir -p /homec/chef/certs
sudo chef-server-ctl user-create admin Test Admin admin@chef.io 'admin123' --filename /homec/chef/certs/admin.pem

# Install chef management console
sudo chef-server-ctl install opscode-manage && chef-server-ctl reconfigure && opscode-manage-ctl reconfigure

# Install and configure chef reporting
sudo chef-server-ctl install opscode-reporting && chef-server-ctl reconfigure && opscode-manage-ctl reconfigure

# Chef DK install and 
CHEF_DK_VERSION=2.5.3-1

# download Chef DK
sudo wget -P /tmp  https://packages.chef.io/files/stable/chefdk/2.5.3/el/7/chefdk-${CHEF_DK_VERSION}.el7.x86_64.rpm

# install Chef DK
sudo rpm -Uvh chefdk-2.5.3-1.el7.x86_64.rpm
