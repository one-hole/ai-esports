puts '------> Use Production'
puts '------> User branch tencent'
puts '------> User tencent server'

set :port, '22'
set :user, 'ubuntu'
set :branch, 'master'
set :domain, '129.204.236.11'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/home/ubuntu/rails/ai-esports'
