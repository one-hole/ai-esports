module Ohms
  class Publish
    def initialize(battle)
      @battle = battle
    end

    def pub(redis)

      if @battle
        redis.publish("aiesports-dota2-websocket-v2", @battle.as_info.to_json)
      end

    end
  end
end

# Publish 把一场系列赛发布到 Redis 或者 RabbitMQ 里面去