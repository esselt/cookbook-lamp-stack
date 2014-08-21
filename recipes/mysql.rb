#
# Cookbook Name:: lamp-stack
# Recipe:: mysql
#
# Copyright 2014, HiST AITeL
#
# All rights reserved - Do Not Redistribute
#

%w(mysql::server database::mysql).each do |recipe|
  include_recipe recipe
end

node['lamp-stack']['mysql_packages'].each do |pkg|
  package pkg
end

mysql_connection = {
  :host     => 'localhost',
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