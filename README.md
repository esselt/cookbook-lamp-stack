Description
===========

Cookbook that sets up a traditional LAMP stack.

Requirements
------------

Chef version 11.0+

#### cookbooks
- `apache2` - Installs and configures Apache2 daemon
- `database` - Manages databases and users
- `mysql` - Installs and configures MySQL daemon
- `php` - Installs and configures PHP-CLI and CGI
- `memcached` - Installs and configures memcached daemon
- `logrotate` - Sets up configuration files for logrotate

## Platform

Supported platforms by platform family:

* debian (debian, ubuntu)

Attributes
----------

All attributes used in apache2, database, mysql, php, memcached and logrotate kan be used.

* `node['lamp-stack']['additional_packages']` - Extra packages installed, can be owerwritten
* `node['lamp-stack']['special_packages']` - Other special packages needed or wanted
* `node['lamp-stack']['start_gid']` - GID for first group (every website creates a group)
* `node['lamp-stack']['websites_path']` - Default path where websites should be placed
* `node['lamp-stack']['vhost_template']` - Template file to use for vhost
* `node['lamp-stack']['template_cookbook']` - Cookbook that holds template file
* `node['lamp-stack']['mysqld_options']` - Cookbook that holds template file

Usage
-----

#### lamp-stack::default

The default recipe installs and configures a complete LAMP stack (Linux, Apache, MySQL and PHP).
It also sets up virtual hosts and databases defined in the role file.

Runs the apache, mysql and php recipe.

Example role

      'lamp-stack' => {
        'mysqld_options' => {                        # OPTIONAL, add options under my.cnf section [mysqld]
            'option' => 'value'
        },
        'websites' => {
          'first.websi.te' => {
            'owners' => ['user1', 'user2'],          # Users on the webserver that should be in the website group
            'aliases' => ['www.websi.te'],           # OPTIONAL, Aliases that the webserver also answers to
            'listen_address' => '1.2.3.4',           # OPTIONAL, IP address to listen on, defaults to *
            'http_port' => 80,                       # OPTIONAL
            'https_port' => 443,                     # OPTIONAL
            'directory_options' => 'FollowSymLinks', # OPTIONAL, Apache2 directive
            'allow_override' => 'FileInfo',          # OPTIONAL, Apache2 directive
            'https_enabled' => true,                 # OPTIONAL
            'ssl_cert' => '/path/to/cert',           # SSL certificate file located locally
            'ssl_key' => '/path/to/key',             # SSL private key located locally
            'enabled' => true                        # OPTIONAL, Enable or disable the virtual host
          }
        },
        'databases' => {
          'first_database' => {
            'password' => 'YlI3vZNHdjhweSPrZvM',     # OPTIONAL
            'host' => 'localhost',                   # OPTIONAL, defaults to %
            'privileges' => [:all]                   # OPTIONAL, Read README for database cookbook, defaults to :all
          }
        }
      }

#### lamp-stack::apache

Installs and sets up Apache with vhosts.

#### lamp-stack::mysql

Installs and sets up MySQL server with users/databases.

#### lamp-stack::php

Installs and sets up PHP with modules.

License and Authors
===================
Author:: Boye Holden (<boye.holden@hist.no>)

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
