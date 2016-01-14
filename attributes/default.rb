#
# Cookbook Name:: lamp-stack
# Attribute:: default
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

default['lamp-stack']['php_packages']       = %w(php5-gd php5-odbc php5-mysql php5-pgsql php5-geoip curl php5-curl php5-intl php5-mcrypt php5-xmlrpc php5-memcached php-mail php-apc)
default['lamp-stack']['apache_packages']    = []
default['lamp-stack']['mysql_packages']     = []
default['lamp-stack']['start_gid']          = 600
default['lamp-stack']['websites_path']      = '/var/www'
default['lamp-stack']['vhost_template']     = 'vhost.erb'
default['lamp-stack']['template_cookbook']  = 'lamp-stack'
default['lamp-stack']['databases']          = {}
default['lamp-stack']['websites']           = {}
default['lamp-stack']['mysqld_options']     = {}