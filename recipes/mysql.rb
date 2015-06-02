#
# Cookbook Name:: lamp-stack
# Recipe:: mysql
#
# Copyright 2014, HiST AITeL
#
# All rights reserved - Do Not Redistribute
#

mysql2_chef_gem 'default' do
  action :install
end

node['lamp-stack']['mysql_packages'].each do |pkg|
  package pkg
end

unless node['mysql']['server_root_password']
  node.set['mysql']['server_root_password'] = ([nil]*24).map { ((48..57).to_a+(65..90).to_a+(97..122).to_a).sample.chr }.join
end

mysql_service 'default' do
  port '3306'
  initial_root_password node['mysql']['server_root_password']
  action [:create, :start]
end

mysql_connection = {
  :host     => '127.0.0.1',
  :username => 'root',
  :password => node['mysql']['server_root_password']
}
node['lamp-stack']['databases'].each do |name, params|
  mysql_database name do
    connection    mysql_connection
    action        :create
  end

  mysql_database_user name do
    connection    mysql_connection
    password      params['password']
    host          params['host'] || '%'
    action        :create
  end

  mysql_database_user name do
    connection    mysql_connection
    password      params['password']
    host          params['host'] || '%'
    database_name name
    privileges    params['privileges'] || [:all]
    action        :grant
  end
end