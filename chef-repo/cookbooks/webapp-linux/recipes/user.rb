#
# Cookbook:: webapp-linux
# Recipe:: user
#
# Copyright:: 2018, The Authors, All Rights Reserved.

group node['webapp-linux']['group']

user node['webapp-linux']['user'] do
  group node['webapp-linux']['group']
  system true
  shell '/bin/bash'
end