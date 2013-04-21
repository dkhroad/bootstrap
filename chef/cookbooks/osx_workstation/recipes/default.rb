#
# Cookbook Name:: osx_workstation
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

directory "#{WS_HOME}/bin" do
   owner "#{WS_USER}"
end

dmg_package "Virtualbox"  do
   source "http://download.virtualbox.org/virtualbox/4.2.12/VirtualBox-4.2.12-84980-OSX.dmg"
   action :install
   type   "pkg"
end

dmg_package "Vagrant" do 
  source "http://files.vagrantup.com/packages/a7853fe7b7f08dbedbc934eb9230d33be6bf746f/Vagrant-1.2.1.dmg"
  action :install
  type "pkg" 
  only_if { !File.exists?("/Applications/Vagrant") }
end

dmg_package "Sublime Text" do
   source "http://c758482.r82.cf2.rackcdn.com/Sublime%20Text%20Build%203021.dmg"
   action :install
   type "pkg"
end

link "#{WS_HOME}/bin/subl" do
   to "/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl"
   owner "#{WS_USER}"
end

#execute "install ack" do
#command "brew install ack"
#end
