nginx = "nginx"

action :install_server do  
  cookbook_file "nginx.repo" do
  	path "/etc/yum.repos.d/nginx.repo"
    owner "root"
		group "root"
	end
  package "#{nginx}"
end

action :setup_web_server do
  template "#{node[:nginx][:conf]}" do
	source "default.conf.erb"
	cookbook "web_nginx"
	variables(
	  :port => node[:nginx][:port],
	  :interface => node[:nginx][:interface]
     )
	end
end

action :start do
	service "#{nginx}" do
	  supports :status => true, :restart => true, :reload => true
	  action   :start
	end
end

action :stop do
	service "#{nginx}" do
	  action   :stop
	end
end

action :restart do
	service "#{nginx}" do
	  action   :restart
	end
end

action :reload do
	service "#{nginx}" do
	  action   :reload
	end
end