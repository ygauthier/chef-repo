# Get redmine
execute "git clone" do
  command "git clone #{node[:redmine][:git]} #{node[:redmine][:install_path]}"
  not_if { File.exists?("#{node[:redmine][:install_path]}/.git/")}
  user "vagrant"
  group "vagrant"
end


execute "git checkout" do
  command "git checkout #{node[:redmine][:version]}"
  cwd "#{node[:redmine][:install_path]}"
  user "vagrant"
  group "vagrant"
end


#change mode for directory

execute "chmod" do
  command "sudo chmod -R 0777 #{node[:redmine][:install_path]}"
  user "vagrant"
  group "vagrant"
end

execute "chown" do
  command "sudo chown -R vagrant:vagrant #{node[:redmine][:install_path]}"
end