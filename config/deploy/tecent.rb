puts '------> Use Production'
puts '------> User branch tencent'
puts '------> User tencent server'

set :port, '22'
set :user, 'deploy'
set :branch, 'tecent'
set :domain, '106.13.78.132'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/home/deploy/rails/ai-esports'
