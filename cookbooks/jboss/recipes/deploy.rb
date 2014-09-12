#
# Cookbook Name:: jboss
# Recipe:: deploy
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

remote_file "#{node['jboss']['sample_app']}" do
	source "#{node['jboss']['sample_app_url']}"
end

deploymentdir = "#{jboss_home}/standalone//deployments"

execute "unzip" do
	command "unzip #{node['jboss']['sample_app']} -d #{deploymentdir}"
end