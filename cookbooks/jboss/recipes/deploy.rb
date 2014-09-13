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
	owner "#{node['jboss']['jboss_user']}"
	group "#{node['jboss']['jboss_user']}"
end

execute "unzip" do
	command "unzip -u #{node['jboss']['sample_app']} -d #{node['jboss']['deployment_dir']}"
	user "#{node['jboss']['jboss_user']}"
	notifies :restart, "service[jboss]"
end