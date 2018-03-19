#
# Cookbook:: webapp-linux
# Recipe:: webserver
#
# Copyright:: 2018, The Authors, All Rights Reserved.


# Install Apache and start the Apache service
httpd_service 'customers' do
    mpm 'prefork'
    action [:create, :start]
end

httpd_config 'customers' do
    instance 'customer'
    source 'customers.conf.erb'
    notifies :restart, 'httpd_service[customers]'
end

# Create the document root directory
directory '/var/www/customers/public_html' do
    recursive true
end

file '/var/www/customers/public_html/index.php' do
    content '<html>This is a temporary page</html>'
    owner 'root'
    group 'root'
    mode '0644'
    action :create
end