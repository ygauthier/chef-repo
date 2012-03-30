# 
# Cookbook Name:: redmine
# Recipe:: database_mysql
#
# Author:: Vincent Demeester <vincent@demeester.fr>
#
# Copyright 2011, Vincent Demeester
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "mysql::server"

gem_package "mysql" do
  action :install
  ignore_failure true
end


grants_path = "/opt/redmine_create_database.mysql.sql"

template grants_path do
    source "redmine_create_database.mysql.sql.erb"
    owner "root"
    group "root"
    mode "0600"
    action :create
end

execute "mysql-install-application-privileges" do
    mysql_password = node[:mysql][:server_root_password]
    command "mysql -u root #{mysql_password.empty? ? '': '-p'}#{mysql_password} < #{grants_path}"
end
