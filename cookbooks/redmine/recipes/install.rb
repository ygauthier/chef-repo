include_recipe "redmine::rails"
include_recipe "apache2"
include_recipe "apache2::mod_rewrite"
include_recipe "passenger_apache2::mod_rails"


case node[:redmine][:db][:type]
when "sqlite"
    include_recipe "redmine::database_sqlite"
when "mysql"
    include_recipe "redmine::database_mysql"
end


template "#{node[:redmine][:install_path]}/config/database.yml" do
    source "database.yml.erb"
    owner "vagrant"
    group "vagrant"
    variables :database_server => node[:redmine][:db][:hostname]
    mode "0664"
end


# Generate session stuff (new installation and upgrades)
execute "rake generate_session_store" do
    user "root"
    cwd "#{node[:redmine][:install_path]}"
end


# Migrate database (new installation and upgrades)
execute "rake db:migrate RAILS_ENV='production'" do
    user "root"
    cwd "#{node[:redmine][:install_path]}"
    not_if {File.exists?("#{node[:redmine][:install_path]}/db/schema.rb") }
end

# Load default data the first time only !
# Contains a *hack* for not failing when rdoc is not installed.
# FIXME maybe this *hack* should be somewhere else
execute "rake redmine:load_default_data RAILS_ENV=production REDMINE_LANG=#{node[:redmine][:lang]}" do 
    user "root"
    cwd "#{node[:redmine][:install_path]}"
    not_if {File.symlink?("#{node[:redmine][:install_path]}")}
end

# Linking redmine version to /opt/redmine (at the end)
#link "/opt/redmine" do
#    to "/opt/#{redmine_version}"
#end

web_app "#{node[:domain]}" do
    docroot "#{node[:redmine][:install_path]}/public"
    template "redmine.conf.erb"
    server_name "#{node[:domain]}"
    rails_env "production"
end

execute "a2dissite default" do
    command "a2dissite default" 
    user "root"
    cwd "#{node[:apache][:dir]}/site-enabled"
    only_if {File.exists?("#{node[:apache][:dir]}/site-enabled/000-default")}
end


execute "/etc/init.d/apache2 reload" do
    user "root"
end