puts '------> Use Sg Production'
puts '------> User branch master'

set :port, '22'
set :user, 'ctao'
set :branch, 'master'
set :domain, '47.74.211.118'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/opt/cellar/rails/old-data-api'
