# install gem into chefdk using chef
execute "chef gem install kitchen-digitalocean" do
  not_if("chef gem list kitchen-digitalocean -i")
end

directory "#{node['jenkins']['master']['home']}/.kitchen" do
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['user']
  mode 0755
end

# write out digital ocean kitchen override
template "#{node['jenkins']['master']['home']}/.kitchen/config.yml" do
  cookbook 'pipeline'
  source "config.yml.erb"
  owner node['jenkins']['master']['user']
  group node['jenkins']['master']['group']
  mode 0644
end