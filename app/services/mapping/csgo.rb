# 有个全局的线程来做这个事情
#
# 如果 CSGO 有 Live 、那么全部由 Live 来更新
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
            battle = CsgoBattle.find_by(official_id: info["id"])  # 这里是已经 Map 上的

            if battle
              info["id"] = battle.id
              new_redis = Redis.new
              new_redis.publish("aiesports-csgo-websocket", info.to_json)
              write_detail(battle, info)
            else
              mapping(info)
            end
          end

          # 日志那么就直接去找
          if info.keys.include?("logs")
            battle = CsgoBattle.where(official_id: info["id"]).last

            if battle
              info["id"] = battle.id
              new_redis = Redis.new
              new_redis.publish("aiesports-csgo-websocket", info.to_json)
            end
          end
        end
      end
    end

    def self.write_detail(battle, info)
      # 这里就存在问题了
      pre_match = battle.pre_match
      match = battle.current_match

      return unless pre_match
      return unless match

      if pre_match.over?

        match.handler(info)
        # detail = match.detail
      else
        # detail = pre_match.detail
        pre_match.handler(info)
      end
    end

    def self.mapping(message)
      CsgoBattle.for_hltv.each do |battle|
        if judge(battle.team_official_infos, abstract(message))
          battle.official_id = message["id"]
          battle.has_live = true
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