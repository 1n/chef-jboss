#
# Cookbook Name:: web
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

web :server do
	provider "#{node[:web_server_type]}"
	action :install_server
end

