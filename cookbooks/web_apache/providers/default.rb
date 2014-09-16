httpd = "httpd"

action :install_server do
  package "#{httpd}"
end

action :setup_web_server do
  template "#{node[:apache][:conf]}" do
	source "httpd.conf.erb"
	cookbook "web_apache"
	variables(
	  :port => node[:apache][:port],
	  :interface => node[:apache][:interface]
     )
	end
end

action :start do
	service "#{httpd}" do
	  supports :status => true, :restart => true, :reload => true
	  action   :start
	end
end

action :stop do
	service "#{httpd}" do
	  action   :stop
	end
end

action :restart do
	service "#{httpd}" do
	  action   :restart
	end
end

action :reload do
	service "#{httpd}" do
	  action   :reload
	end
end