#
# Cookbook Name:: lamp-stack
# Recipe:: apache
#
# Copyright 2014, HiST AITeL
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

node.set['apache']['mpm'] = 'prefork'

%w(logrotate apache2 apache2::mod_php5 apache2::mod_rewrite).each do |recipe|
  include_recipe recipe
end

node['lamp-stack']['apache_packages'].each do |pkg|
  package pkg
end

start_gid = node['lamp-stack']['start_gid']
web_path = node['lamp-stack']['websites_path']
web_user = node['apache']['user']
node['lamp-stack']['websites'].each do |url, params|
  include_recipe 'apache2::mod_ssl' if !!params['https_enabled']

  members = []
  params['owners'].each do |member|
    members << member if node[:etc][:passwd].has_key?(member)
  end

  web_group = url.gsub(/[.]/, '-')
  group web_group do
    gid     start_gid
    members members
  end
  start_gid += 1

  directory "#{web_path}/#{url}" do
    owner     web_user
    group     web_group
    mode      '2770'
    recursive true
  end

  directory "#{web_path}/#{url}/log" do
    owner 'root'
    group web_group
    mode  '2750'
  end

  directory "#{web_path}/#{url}/web" do
    owner web_user
    group web_group
    mode  '2770'
  end

  web_app url do
    template params['vhost_template'] || node['lamp-stack']['vhost_template']
    cookbook params['vhost_cookbook'] || node['lamp-stack']['template_cookbook']

    http_port         params['http_port']
    server_name       url
    server_aliases    params['aliases']
    listen_address    params['listen_address']
    docroot           "#{web_path}/#{url}/web"
    logroot           "#{web_path}/#{url}/log"
    directory_options params['directory_options']
    allow_override    params['allow_override']
    https_enabled     !!params['https_enabled']
    https_port        params['https_port']
    ssl_cert          params['ssl_cert']
    ssl_key           params['ssl_key']
    other             params['other']
    enable            !!params['enable'] unless params['enable'].is_a?(NilClass)
  end

  logrotate_app "apache2-#{url}" do
    path          "#{web_path}/#{url}/log/*.log"
    create        "640 root #{web_group}"
    su            "root #{web_group}"
    frequency     'daily'
    rotate        30
    options       %w{missingok compress delaycompress notifempty}
    sharedscripts true
    postrotate    ['service apache2 reload > /dev/null']
  end

  execute "correct-ownership-#{web_group}" do
    cwd "#{web_path}/#{url}"
    command "chgrp -R #{web_group} web/ && chmod -R g+w web/ && chown -R root:#{web_group} log/"
  end
end