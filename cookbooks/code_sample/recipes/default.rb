package 'nginx' 
package 'git'

#Remove the symlink to default that listens on port 80
file '/etc/nginx/sites-enabled/default' do
	action :delete 
	notifies :restart, "service[nginx]"
end 

#once we remove the symlink above and create the symlink for 
service 'nginx' do
	action [:start, :enable]
end

template "/etc/nginx/sites-available/#{$site_name}" do
	source 'code_sample.erb'
	owner 'root'
  group 'root'
  mode '0644'
	variables(node[$site_name]['nginx'])
	notifies :restart, "service[nginx]"
end

link "/etc/nginx/sites-enabled/#{$site_name}" do
  to "/etc/nginx/sites-available/#{$site_name}"
  link_type :symbolic
end

directory node[$site_name]['nginx']['web_root'] do
  owner node[$site_name]['nginx']['user']
  group node[$site_name]['nginx']['user']
  mode '0755'
  action :create
	recursive true 
end

git node[$site_name]['nginx']['web_root'] do
  repository "https://github.com/puppetlabs/exercise-webpage"
  reference "master"
  action :sync
end
