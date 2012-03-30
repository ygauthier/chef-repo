#install other rails gems ....
include_recipe "imagemagick::rmagick"

gem_package "rack" do
   action :install
   version "1.1.3"
end


gem_package "gruff" do
   action :install
   version "0.3.6"
end


gem_package "prawn" do
   action :install
   version "0.12.0"
end


gem_package "rdoc" do
   action :install
   version "3.12"
end


gem_package "rdoc-data" do
   action :install
   version "3.12"
end


gem_package "vpim" do
   action :install
   version "0.695"
end


gem_package "ruby-openid" do
   action :install
   version "2.1.8"
end


gem_package "ruby-openid-apps-discovery" do
   action :install
   version "1.2.0"
end


gem_package "acts-as-taggable-on" do
   action :install
   version "2.0.6"
end


gem_package "spreadsheet" do
   action :install
   version "0.6.8"
end


gem_package "fastercsv" do
   action :install
   version "1.5.4"
end


gem_package "state_machine"


#gem "icalendar" do
#   action :install
#   version "1.1.6"
#end


gem_package "ttfunk" do
   action :install
   version "1.0.3"
end


gem_package "system_timer" do
   action :install
   version "1.2.4"
end


gem_package "ri_cal" do
   action :install
   version "0.8.8"
end


%w{ money aasm block_helpers pdfkit}.each do |gem|
  gem_package gem do
    action :install
  end
end

