#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

web "server" do
	provider "#{node[:web_server_type]}"
	action :install_server
end

web "server" do
	action :setup_web_server
end

web "server" do
	action :start
end

web "server" do
	action :restart
end