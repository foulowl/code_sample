$site_name = 'code_sample'

default[$site_name]['nginx']['user'] = "deploy"
default[$site_name]['nginx']['port'] = "8000"

#helper attribute
default[$site_name]['nginx']['web_root'] = "/home/#{node[$site_name]['nginx']['user']}/sites/#{$site_name}"

