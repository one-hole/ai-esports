puts '------> Use Production'
puts '------> User branch tencent'
puts '------> User tencent server'

set :port, '22'
set :user, 'ubuntu'
set :branch, 'master'
set :domain, '106.52.184.239'
set :rails_env, 'production'
set :keep_releases, 5
set :deploy_to, '/home/ubuntu/rails/ai-esports'
