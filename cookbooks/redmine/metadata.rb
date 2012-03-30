maintainer          "Vincent Demeester"
maintainer_email    "vincent@demeester.fr"
license             "Apache 2.0"
description         "Install gitolite from package or source"
long_description    IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version             "0.1.0"

%w{ ubuntu debian }.each do |os|
    supports os
end

%w{ git rails apache2 }.each do |dep|
    depends dep
end
