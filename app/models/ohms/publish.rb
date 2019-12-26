module Ohms
  class Publish
    def initialize(battle)
      @battle, @tag = battle, false
      @battle_ids   = [battle.radiant_team.steam_id.to_i, battle.dire_team.steam_id.to_i]
      @dire_name, @radiant_name = @battle.dire_team.name, @battle.radiant_team.name
    end

    def pub(redis)
      
      if @battle.db_id
        @flag = true
      end

      live_battles

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
      # match.async_fetch_detail
    end

    # 1. 先匹配队伍的 ID
    # 2. 然后匹配队伍的 名字
    def live_battles
      Dota2Battle.ongoing.each do |live_battle|
        @ids, @names = live_battle.team_official_infos
        
        unless @flag
          if @ids.to_set.intersect?(@battle_ids.to_set)
            @flag = true
            @battle.db_id = live_battle.id
            @battle.save

            if @flag

              if live_battle.left_team.info.to_set.intersect?(@battle.radiant_team.info.to_set)
                match = @battle.match
                match.left_radiant = 1
                match.save
                @battle.radiant_team.db_id    = live_battle.left_team.id
                @battle.dire_team.db_id       = live_battle.right_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: true)
                end
              elsif live_battle.left_team.info.to_set.intersect?(@battle.dire_team.info.to_set)
                match = @battle.match
                match.left_radiant = 0
                match.save
                @battle.radiant_team.db_id    = live_battle.right_team.id
                @battle.dire_team.db_id       = live_battle.left_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: false)
                end
              elsif live_battle.right_team.info.to_set.intersect?(@battle.radiant_team.info.to_set)
                match = @battle.match
                match.left_radiant = 0
                match.save
                @battle.radiant_team.db_id    = live_battle.right_team.id
                @battle.dire_team.db_id       = live_battle.left_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: false)
                end

              elsif live_battle.right_team.info.to_set.intersect?(@battle.dire_team.info.to_set)
                match = @battle.match
                match.left_radiant = 1
                match.save
                @battle.radiant_team.db_id    = live_battle.left_team.id
                @battle.dire_team.db_id       = live_battle.right_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: true)
                end
              end
            end

          end
        end

        unless @flag
          if @names.to_set.intersect?([@dire_name.downcase, @radiant_name.downcase].to_set)
            @flag = true
            @battle.db_id = live_battle.id
            @battle.save

            if @flag

              if live_battle.left_team.info.to_set.intersect?(@battle.radiant_team.info.to_set)
                match = @battle.match
                match.left_radiant = 1
                match.save
                @battle.radiant_team.db_id    = live_battle.left_team.id
                @battle.dire_team.db_id       = live_battle.right_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: true)
                end
              elsif live_battle.left_team.info.to_set.intersect?(@battle.dire_team.info.to_set)
                match = @battle.match
                match.left_radiant = 0
                match.save
                @battle.radiant_team.db_id    = live_battle.right_team.id
                @battle.dire_team.db_id       = live_battle.left_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: false)
                end
              elsif live_battle.right_team.info.to_set.intersect?(@battle.radiant_team.info.to_set)
                match = @battle.match
                match.left_radiant = 0
                match.save
                @battle.radiant_team.db_id    = live_battle.right_team.id
                @battle.dire_team.db_id       = live_battle.left_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: false)
                end

              elsif live_battle.right_team.info.to_set.intersect?(@battle.dire_team.info.to_set)
                match = @battle.match
                match.left_radiant = 1
                match.save
                @battle.radiant_team.db_id    = live_battle.left_team.id
                @battle.dire_team.db_id       = live_battle.right_team.id
                @battle.radiant_team.save
                @battle.dire_team.save

                do_match_check unless live_battle.current_match

                if live_battle.current_match
                  live_battle.current_match.detail.update(left_radiant: true)
                end
              end
            end
          end
        end        

        # 匹配上了


      end
    end

    def set_team_id(ohm_team, db_team)
      
    end

    def upcoming_battles
      Dota2Battle.recents.each do |upcoming_battle|
        
      end
    end
  end
end

# Publish 把一场系列赛发布到 Redis 或者 RabbitMQ 里面去