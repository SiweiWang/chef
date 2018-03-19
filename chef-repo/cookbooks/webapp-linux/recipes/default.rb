#
# Cookbook:: webapp-linux
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'yum::default'
include_recipe 'webapp-linux::user'
include_recipe 'firewall::disable_firewall'
include_recipe 'webapp-linux::webserver'
include_recipe 'webapp-linux::database'