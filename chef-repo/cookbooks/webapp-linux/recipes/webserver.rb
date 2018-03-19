#
# Cookbook:: webapp-linux
# Recipe:: webserver
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Install Apache and start the Apache service
httpd_service 'customers' do
    mpm 'prefork'
    version '2.4'
    action [:create, :start]
end

# Add customer site configuration
httpd_config 'customers' do
    instance 'customers'
    source 'customers.conf.erb'
    notifies :restart, 'httpd_service[customers]'
end

# Create the document root directory
directory node['webapp-linux']['document_root'] do
    recursive true
end

# Create a default root directory
file "#{node['webapp-linux']['document_root']}/index.php" do
    content '<html>This is a temporary page</html>'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end

# # Open TCP port 80 for web traffic
# firewall_rule 'http' do
#     port 80
#     protocol :tcp
#     action :create
# end
