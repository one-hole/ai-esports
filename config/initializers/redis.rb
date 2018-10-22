require 'connection_pool'

Redis::Objects.redis = ConnectionPool.new(size: 20, timeout: 10) do
  Redis.new(:host => '127.0.0.1', :port => 6379, :db => 0)
end
