gem_package "rails" do
  version node[:rails][:version] if node[:rails][:version]
  gem_binary "/usr/local/bin/gem" if ::File.exists?("/usr/local/bin/ree-version")
  ignore_failure true
end

template "/etc/profile.d/rails.sh" do
  source "rails-profile.d.sh.erb"
end


#install other gems needed for redmine...
gem_package "rake" do
  version "0.8.7"
  ignore_failure true
end


gem_package "rake" do
  version "0.9.2.2"
  action :remove
  ignore_failure true
end

gem_package "i18n" do
  version "0.4.2"
  action :install
  ignore_failure true
end

package "libonig-dev" do
   action :install
end

if node[:redmine][:extra_gems] == "true"
   include_recipe "redmine::extra_gems"
end