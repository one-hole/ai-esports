module Ohms
  class Publish
    def initialize(battle)
      @battle, @tag = battle, false
      @battle_ids   = [battle.radiant_team_id.to_i, battle.dire_team_id.to_i]
      @dire_name, @radiant_name = @battle.dire_team.name, @battle.radiant_team.name
    end

    def pub(redis)
      
      if @battle.db_id
        @flag = true
      end

      live_battles unless @flag
      upcoming_battles unless @flag
      
      if @flag
        redis.publish("aiesports-dota2-websocket-v2", @battle.as_info.to_json)
      end

      if @flag
        do_match_check
      end

    end


    # 1. 需要检查数据库里面的比赛是否存在
    # 2. 需要请求 MatchDetail 判定比赛是否接触（但是比赛结束这个事情不应该是又这个事情判定的 - UNIQ）
    def do_match_check
      match = Dota2Match.build(@battle)
      match.async_fetch_detail
    end

    # 1. 先匹配队伍的 ID
    # 2. 然后匹配队伍的 名字
    def live_battles
      Dota2Battle.ongoing.each do |live_battle|
        @ids, @names = live_battle.team_official_infos
        
        if @ids.to_set.intersect?(@battle_ids.to_set)
          @flag = true
          @battle.db_id = live_battle.id
          @battle.save
          return
        end

        if @names.to_set.intersect?([@dire_name.downcase, @radiant_name.downcase].to_set)
          @flag = true
          @battle.db_id = live_battle.id
          @battle.save
          return
        end

      end
    end

    def upcoming_battles
      Dota2Battle.recents.each do |upcoming_battle|
        
      end
    end
  end
end

# Publish 把一场系列赛发布到 Redis 或者 RabbitMQ 里面去