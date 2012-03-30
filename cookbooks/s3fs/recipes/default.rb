%w{ build-essential pkg-config libcurl4-openssl-dev libfuse-dev fuse-utils libfuse2 libxml2-dev mime-support }.each do |pkg|
  package pkg
end

# install fuse
remote_file "/tmp/fuse-#{ node[:fuse][:version] }.tar.gz" do
  source "http://downloads.sourceforge.net/project/fuse/fuse-2.X/#{ node[:fuse][:version] }/fuse-#{ node[:fuse][:version] }.tar.gz"
  mode 0644
end

script "install_fuse" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
  tar zxvf fuse-#{ node[:fuse][:version] }.tar.gz
  cd fuse-#{ node[:fuse][:version] }
  ./configure --prefix=/usr
  make
  sudo make install

  EOH
  user "root"
  not_if { File.exists?("/usr/bin/fusermount") }
end

remote_file "/tmp/s3fs-#{ node[:s3fs][:version] }.tar.gz" do
  source "http://s3fs.googlecode.com/files/s3fs-#{ node[:s3fs][:version] }.tar.gz"
  mode 0644
end

script "install_s3fs" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
  tar zxvf s3fs-#{ node[:s3fs][:version] }.tar.gz
  cd s3fs-#{ node[:s3fs][:version] }
  ./configure --prefix=/usr
  make
  sudo make install
  EOH
  user "root"
  not_if { File.exists?("/usr/bin/s3fs") }
end


script "create_mount_point" do
  interpreter "bash"
  cwd "/tmp"
  code <<-EOH
  sudo mkdir -p #{ node[:s3fs][:mount] } 
  EOH
  user "root"
  not_if { File.exists?("#{ node[:s3fs][:mount]}") }
end

#configure ours access

template "/etc/passwd-s3fs" do
  source "passwd-s3fs.erb"
  owner "root"
  group "root"
  mode 0640
end


template "/etc/init/s3.conf" do
  source "s3.upstart.conf.erb"
  owner "root"
  group "root"
end


service "s3" do
  provider Chef::Provider::Service::Upstart
  action [:enable, :start, :restart]
end