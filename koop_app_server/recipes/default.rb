include_recipe 'apt'

apt_repository 'apt.postgresql.org' do
  components ['main']
  distribution "#{node['lsb']['codename']}-pgdg"
  key 'http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc'
  notifies :run, 'execute[apt-get update]', :immediately
  uri 'http://apt.postgresql.org/pub/repos/apt'
end

execute 'add-apt-repo' do
  command 'add-apt-repository ppa:ubuntugis/ubuntugis-unstable'
  ignore_failure false
end

execute 'add-apt-repo' do
  command 'add-apt-repository ppa:ubuntu-toolchain-r/test'
  ignore_failure false
end

execute 'add-apt-repo' do
  command 'add-apt-repository ppa:mapnik/v2.2.0'
  ignore_failure false
end

execute 'apt-get-update' do
  command 'apt-get update -q'
  ignore_failure false
end

execute 'download/install pip' do
  command 'curl -o /get-pip.py https://bootstrap.pypa.io/get-pip.py && python /get-pip.py'
  ignore_failure false
end

execute 'install awscli' do
  command 'pip install awscli'
  ignore_failure false
end

execute 'set region on aws cli' do
  command 'aws configure set default.region us-east-1'
  ignore_failure false
end

package 'jq'
package 'zip'
package 'gdal-bin'
package 'pkg-config'
package 'libcairo2-dev'
package "pgdg-keyring"
package 'libgdal-dev'
package 'libpq-dev'
package 'postgresql-9.3'
package 'postgresql-client-9.3'
package 'postgresql-server-dev-all'
package 'libmapnik'
package 'libmapnik-dev'
package 'mapnik-utils'
package 'python-mapnik'
package 'libstdc++6'

execute 'install pm2' do
  command 'npm install -g pm2'
  ignore_failure false
end
