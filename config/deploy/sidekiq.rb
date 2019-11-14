namespace :sidekiq do

  set :sidekiq, -> { "#{fetch(:bundle_prefix)} sidekiq" }
  set :sidekiqctl, -> { "#{fetch(:bundle_prefix)} sidekiqctl" }
  set :sidekiq_pid, -> { "#{fetch(:shared_path)}/tmp/pids/sidekiq.pid" }
  set :sidekiq_log, -> { "#{fetch(:current_path)}/log/sidekiq.log" }
  set :sidekiq_config, -> { "#{fetch(:current_path)}/config/sidekiq.yml" }
  set :sidekiq_timeout, 10
  set :sidekiq_processes, 1
  set :sidekiq_concurrency, 10

  def for_each_process(&block)
    fetch(:sidekiq_processes).times do |idx|
      pid_file = if idx == 0
        fetch(:sidekiq_pid)
      else
        "#{fetch(:sidekiq_pid)}-#{idx}"
      end
      yield(pid_file, idx)
    end
  end

  desc "Start"
  task :start => :remote_environment do
    comment "-------> Starting Sidekiq"
    in_path(fetch(:current_path)) do
      for_each_process do |pid_file, idx|
        sidekiq_concurrency = fetch(:sidekiq_concurrency)
        concurrency_arg = sidekiq_concurrency.nil? ? "" : "-c #{sidekiq_concurrency}"
        command %[#{fetch(:sidekiq)} -d #{concurrency_arg} -C #{fetch(:sidekiq_config)} -i #{idx} -P #{pid_file} -L #{fetch(:sidekiq_log)}]
      end
    end
    
    run(:local) do
      comment %{ "#{fetch(:current_path)}" }
      comment %{ "#{fetch(:sidekiq)}" }
      sidekiq_concurrency = fetch(:sidekiq_concurrency)
      concurrency_arg = sidekiq_concurrency.nil? ? "" : "-c #{sidekiq_concurrency}"
      comment %{ "#{concurrency_arg}" }
    end
    
  end

  desc "Stop sidekiq"
  task :stop => :remote_environment do
    comment "-------> Stoping sidekiq"
    in_path(fetch(:current_path)) do
      for_each_process do |pid_file, idx|
        command %{
          if [ -f #{pid_file} ] && kill -0 `cat #{pid_file}`> /dev/null 2>&1; then
            #{fetch(:sidekiqctl)} stop #{pid_file} #{fetch(:sidekiq_timeout)}
          else
            echo 'Skip stopping sidekiq (no pid file found)'
          fi
        }.strip
      end
    end
  end

  desc "Quiet sidekiq (stop accepting new work)"
  task :quiet => :environment do
    comment 'Quiet sidekiq (stop accepting new work)'
    in_path(fetch(:current_path)) do
      for_each_process do |pid_file, idx|
        command %{
          if [ -f #{pid_file} ] && kill -0 `cat #{pid_file}` > /dev/null 2>&1; then
            #{fetch(:sidekiqctl)} quiet #{pid_file}
          else
            echo 'Skip quiet command (no pid file found)'
          fi
        }.strip
      end
    end
  end

  desc "Restart sidekiq"
  task :restart do
    invoke :'sidekiq:stop'
    invoke :'sidekiq:start'
  end

  desc "Tail log from server"
  task :log => :remote_environment do
    command %[tail -f #{fetch(:sidekiq_log)}]
  end
end
