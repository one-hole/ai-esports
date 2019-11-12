module Ohms
  class Publish
    def initialize(ohm_battle_id)
      @battle = Ohms::Battle[ohm_battle_id]
    end

    def pub(redis)
      redis.publish(

      )
    end
  end
end

# Publish 把一场系列赛发布到 Redis 或者 RabbitMQ 里面去