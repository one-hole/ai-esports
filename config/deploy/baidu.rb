puts '------> Use Production'
puts '------> User branch baidu'
puts '------> User baidu server'

set :port, '22'
set :user, 'deploy'
set :branch, 'baidu'
set :domain, '106.13.78.132'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/home/deploy/rails/old-data-api'