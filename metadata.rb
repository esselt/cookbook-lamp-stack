name             'lamp-stack'
maintainer       'Boye Holden'
maintainer_email 'boye.holden@hist.no'
license          'Apache 2.0'
description      'Installs/Configures lamp-stack'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.2.0'

%w(logrotate database mysql apache2 php memcached).each do |pkg|
  depends pkg
end

supports 'debian', '>= 6.0'
supports 'ubuntu', '>= 12.04'