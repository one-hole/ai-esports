puts '------> Use Production'
puts '------> User branch master'

set :port, '22'
set :user, 'deployer'
set :branch, 'master'
set :domain, '47.99.180.88'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/home/deployer/rails/old-data-api'
