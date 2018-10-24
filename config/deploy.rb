require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'  # for rbenv support. (https://rbenv.org)

if ENV['on'].nil?
  require File.expand_path('../deploy/development.rb', __FILE__)
else
  require File.expand_path("../deploy/#{ENV['on']}.rb", __FILE__)
end

set :application_name, 'old-data-api'
set :repository, 'git@gitee.com:oneholes/little-ai.git'
set :forward_agent, true
# set :shared_files, fetch(:shared_files, []).push('config/master.key', 'config/puma.rb', 'config/database.yml', 'config/database_aw.yml')
set :shared_files, fetch(:shared_files, [])

task :remote_environment do
  invoke :'rbenv:load'
end

# Put any custom commands you need to run at setup
# All paths in `shared_dirs` and `shared_paths` will be created on their own.
task :setup do
  command %{rbenv install 2.5.3 --skip-existing}
  command %{mkdir -p "#{fetch(:shared_path)}/tmp/sockets"}
  command %{mkdir -p "#{fetch(:shared_path)}/tmp/pids"}
end

desc "Deploys the current version to the server."
task :deploy do
  # uncomment this line to make sure you pushed your local branch to the remote origin
  # invoke :'git:ensure_pushed'
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        command %{mkdir -p tmp/}
        command %{touch tmp/restart.txt}
      end
    end
  end

  # you can use `run :local` to run tasks on local machine before of after the deploy scripts
  # run(:local){ say 'done' }
end

# For help in making your deploy script, see the Mina documentation:
#
#  - https://github.com/mina-deploy/mina/tree/master/docs
