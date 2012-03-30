maintainer       "Alexandre Assouad"
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures symfony"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.0"

recipe "symfony", "Installs and configures symfony LAMP stack on a single system"

depends "apache2", ">= 0.99.4"
depends "mysql", ">= 1.0.5"
depends "php", ">= 5.3.2"

%w{ debian ubuntu redhat centos fedora }.each do |os|
  supports os
end

attribute "symfony/version",
  :display_name => "symfony download version",
  :description => "Version of symfony to download from the symfony site.",
  :default => "2.0.6"
  
attribute "symfony/dir",
  :display_name => "Symfony installation directory",
  :description => "Location to place symfony files.",
  :default => "/var/www"
  