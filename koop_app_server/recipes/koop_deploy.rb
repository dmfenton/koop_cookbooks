include_recipe 'deploy'

directory node[:koop][:data_dir] do
  mode 0755
  action :create
end

node[:deploy].each do |application, deploy|
  template 'default.json' do
    cookbook 'koop_app_server'
    path "#{deploy[:current_path]}/config/default.json"
    source 'default.json.erb'
    owner 'root'
    group 'root'
    mode 0644
  end

  execute 'stop monit' do
    cwd "/"
    command 'monit stop node_web_app_koop'
    ignore_failure true
  end

  execute 'stop koop' do
    group 'root'
    user 'root'
    cwd "#{deploy[:current_path]}"
    command 'pm2 kill'
    ignore_failure false
  end

  execute 'start koop' do
    cwd "#{deploy[:current_path]}"
    command "pm2 start server.js"
    ignore_failure false
  end


end
