#
# Cookbook Name:: jboss
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'java'

remote_file "#{node['jboss']['jboss_package']}" do
	source "#{node['jboss']['jboss_url']}"
	checksum "0aece7899b54"
end

yum_package "unzip"

execute "unzip" do
	command "unzip #{node['jboss']['jboss_package']} -d #{node['jboss']['jboss_home']}"
	not_if { ::File.exists?("#{node['jboss']['jboss_home']}/jboss-as-7.1.1.Final")}
end

user "#{node['jboss']['jboss_user']}"

link "/opt/jboss" do
	to "#{node['jboss']['jboss_home']}/jboss-as-7.1.1.Final"
	owner "#{node['jboss']['jboss_user']}"
	group "#{node['jboss']['jboss_user']}"
end

#jboss_home = "#{node['jboss']['jboss_home']}/jboss"

execute "chown /opt/jboss" do
	command "chown -RL #{node['jboss']['jboss_user']}.#{node['jboss']['jboss_user']} #{node['jboss']['jboss_home_link']}"
	#not_if { ::File.
end

cookbook_file "jboss-as-standalone.sh" do
	path "/etc/init.d/jboss"
	owner "root"
	group "root"
	mode "0755"
end

directory "/etc/jboss-as"

template "/etc/jboss-as/jboss-as.conf" do
	source "jboss-as.conf.erb"
	owner "root"
	group "root"
	variables({
     :jboss_user => node['jboss']['jboss_user'],
     :jboss_home => node['jboss']['jboss_home_link']
     })
end

template "#{node['jboss']['jboss_home_link']}/standalone/configuration/standalone.xml" do
	source "standalone.xml.erb"
	owner "#{node['jboss']['jboss_user']}"
	group "#{node['jboss']['jboss_user']}"
	variables({
     :jboss_ip => node['jboss']['public_ip']
     })
end

include_recipe 'jboss::start'

include_recipe 'jboss::deploy'