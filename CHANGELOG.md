CHANGELOG
=========

This file is used to list changes made in each version of the lamp-stack cookbook.

0.2.8
-----
- [Boye Holden] - Added ability to use mysqld_options

0.2.7
-----
- [Boye Holden] - Specific template for ubuntu 14.04 (apache2)

0.2.6
-----
- [Boye Holden] - Removed RewriteLog which is no longer active in Apache 2.4

0.2.5
-----
- [Boye Holden] - Added default attributes for websites and databases

0.2.4
-----
- [Boye Holden] - Added logrotate for mysql

0.2.3
-----
- [Boye Holden] - Updated to use mysql2_chef_gem for mysql database creation

0.2.2
-----
- [Boye Holden] - Updated to match new mysql_service provider

0.2.1
-----
- [Boye Holden] - Cleaned up the code a bit

0.2.0
-----
- [Boye Holden] - Added the posibility to run perticular services, and use vhost templates from other cookbooks

0.1.0
-----
- [Boye Holden] - Initial release of lamp-stack