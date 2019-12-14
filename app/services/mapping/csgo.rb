# 有个全局的线程来做这个事情
#
module Mapping
  class Csgo

    def self.run
      thread = Thread.new(&method(:subhltv))
    end

    def self.subhltv
      @redis = Redis.new
      @redis.subscribe("aiesports-csgo-websocket-to-back") do |on|
        on.message do |channel, message|
          info = JSON.parse(message)

          # 如果是 data 。 先找到 Maped 的 Battle .没有找到那就去 Mapping .找到了直接推送
          if info.keys.include?("data")
            battle = CsgoBattle.find_by(official_id: info["id"])

            if battle
              info["id"] = battle.id
              new_redis = Redis.new
              new_redis.publish("aiesports-csgo-websocket", info.to_json)
            else
              mapping(info)
            end

          end

          # 日志那么就直接去找
          if info.keys.include?("logs")
            battle = CsgoBattle.find_by(official_id: info["id"])

            if battle
              info["id"] = battle.id
              new_redis = Redis.new
              new_redis.publish("aiesports-csgo-websocket", info.to_json)
            end
          end
        end
      end
    end

    def self.mapping(message)
      CsgoBattle.for_hltv.each do |battle|
        if judge(battle.team_official_infos, abstract(message))
          battle.official_id = message["id"]
          battle.save
        end
      end
    end

    def self.abstract(message)
      return [message["data"]["ctTeamId"], message["data"]["tTeamId"]], [message["data"]["ctTeamName"].downcase, message["data"]["terroristTeamName"].downcase] rescue [[], []]
    end

    def self.judge(source, target)
     if source[0].to_set.intersect?(target[0].to_set)
       return true
     end

      if source[1].to_set.intersect?(target[1].to_set)
        return true
      end

      return false
    end
  end
end