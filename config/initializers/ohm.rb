require 'ohm'

redis_host = ENV['OHM_HOST'] || '127.0.0.1'
redis_port = ENV['OHM_PORT'] || '6380'

Ohm.redis = Redic.new("redis://#{redis_host}:#{redis_port}")
