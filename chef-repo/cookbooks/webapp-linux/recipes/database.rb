#
# Cookbook:: webapp-linux
# Recipe:: database
#
# Copyright:: 2018, The Authors, All Rights Reserved.

# Configure mysql2 Ruby gem
mysql2_chef_gem 'default' do
    action :install
end

# Configurate MySql client
mysql_client 'default' do
    action :create
end

# Load the secrets file
password_secret = Chef::EncryptedDataBagItem.load_secret(node['webapp-linux']['password']['secret_path'])
root_password_databag_item = Chef::EncryptedDataBagItem.load('credentials', 'sql_server_root_password', password_secret)

# Configure MySQL service.
mysql_service 'default' do
    initial_root_password root_password_databag_item['password']
    action [:create, :start]
end

# Create database
mysql_database node['webapp-linux']['database']['dbname'] do
    connection(
        :host => node['webapp-linux']['database']['host'],
        :username => node['webapp-linux']['database']['username'],
        :password => root_password_databag_item['password']
    )
    action :create
end

# Load data bag item for user password
user_password_databag_item = Chef::EncryptedDataBagItem.load('credentials', 'db_admin_password', password_secret)


# Create a database user

mysql_database_user node['webapp-linux']['database']['app']['username'] do
    connection(
        :host => node['webapp-linux']['database']['host'],
        :username => node['webapp-linux']['database']['username'],
        :password => root_password_databag_item['password']
    )
    password user_password_databag_item['password']
    database_name node['webapp-linux']['database']['dbname']
    host node['webapp-linux']['database']['host']
    action [:create, :grant]
end

# Write seed file to filesystem
cookbook_file node['webapp-linux']['database']['seed_file'] do
    source 'create-tables.sql'
    owner 'root'
    group 'root'
    mode '0600'
    action :create
end

# Seed MySql database and test data.
execute 'init database' do
    command "mysql -h #{node['webapp-linux']['database']['host']} -u #{node['webapp-linux']['database']['app']['username']} -p#{user_password_databag_item['password']} -D #{node['webapp-linux']['database']['dbname']} < #{node['webapp-linux']['database']['seed_file']}"
    not_if     command "mysql -h #{node['webapp-linux']['database']['host']} -u #{node['webapp-linux']['database']['app']['username']} -p#{user_password_databag_item['password']} -D #{node['webapp-linux']['database']['dbname']} -e 'describe_customer;'"
    action :run
end