require 'ohm'

redis_host = ENV['REDIS_HOST'] || '127.0.0.1'
redis_port = ENV['REDIS_PORT'] || '6379'

Ohm.redis = Redic.new("redis://#{redis_host}:#{redis_port}")
