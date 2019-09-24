module Live
  module Util
    module Process

      def process_currents(battle, redis)
        build_battle(battle)
        build_teams(battle)
        update_battle(battle)   # 这里更新是因为持久化队伍之后才能把队伍的数据更新到 Battle 里面
        build_players(battle)   # Player 会关联到队伍里面 0 是 radiant
        build_match(battle)     # 这里会更新或者创建 Live::Match (TODO 这里需要 DIFF 消息)
        update_players(battle["scoreboard"])

        @redis.publish("aiesports-dota2-websocket-v2", @battle.info.to_json)
      end

      # 这里应该是查找或者创建（通过 steam_id）
      def build_battle(battle)
        @battle = Battle.with(:steam_id, battle["match_id"])

        return if @battle

        @battle = Battle.create(
          steam_id: battle["match_id"],
          lobby_id: battle["lobby_id"],
          stream_delay_s: battle["stream_delay_s"],
          radiant_score:  battle["radiant_series_wins"],
          dire_score:     battle["dire_series_wins"],
        ) unless @battle
      end

      def build_players(battle)

        battle["players"].each do |player|
          @player = nil
    
          if player["team"] == 0
            @team = @radiant_team
          elsif player["team"] == 1
            @team = @dire_team
          else
            next
          end

          @player = Player.with(:account_id, player["account_id"])

          Player.create(
            name:       player["name"],
            account_id: player["account_id"],
            team_id:    @team.id,
            battle_id:  @battle.id
          ) unless @player
        end
      end
      
      def update_battle(battle)
        @battle.update({
          radiant_team_id: @radiant_team.id,
          dire_team_id:    @dire_team.id,
          radiant_score:  battle["radiant_series_wins"],
          dire_score:     battle["dire_series_wins"],
        })
      end

      # 这里应该是查找或者创建（通过 steam_id）
      def build_teams(battle)

        @radiant_team = Team.with(:steam_id, battle["radiant_team"]["team_id"])

        @radiant_team = Team.create(
          name: battle["radiant_team"]["team_name"],
          logo: battle["radiant_team"]["team_logo"],
          steam_id:   battle["radiant_team"]["team_id"],
          battle_id:  @battle.id
        ) unless @radiant_team

        @dire_team = Team.with(:steam_id, battle["dire_team"]["team_id"])

        @dire_team = Team.create(
          name: battle["dire_team"]["team_name"],
          logo: battle["dire_team"]["team_logo"],
          steam_id:   battle["dire_team"]["team_id"],
          battle_id:  @battle.id
        ) unless @dire_team
      end 

      def build_match(battle)
        @cur_match = Live::Match.find(battle_id: @battle.id, game_no: (@battle.radiant_score + @battle.dire_score + 1)).first

        @cur_match = Match.create(
          game_no:                (@battle.radiant_score + @battle.dire_score + 1),
          status:                 "ongoing",
          battle_id:              @battle.id,
          duration:               battle["scoreboard"]["duration"],
          roshan_respawn_timer:   battle["scoreboard"]["roshan_respawn_timer"],
          radiant_score:          battle["scoreboard"]["radiant"]["score"],
          radiant_tower_state:    battle["scoreboard"]["radiant"]["tower_state"],
          radiant_barracks_state: battle["scoreboard"]["radiant"]["barracks_state"],
          radiant_picks: battle["scoreboard"]["radiant"]["picks"].map { |item| item.values  }.flatten,
          radiant_bans:  battle["scoreboard"]["radiant"]["bans"].map { |item| item.values  }.flatten,
          dire_score:          battle["scoreboard"]["dire"]["score"],
          dire_tower_state:    battle["scoreboard"]["dire"]["tower_state"],
          dire_barracks_state: battle["scoreboard"]["dire"]["barracks_state"],
          dire_picks: battle["scoreboard"]["dire"]["picks"].map { |item| item.values  }.flatten,
          dire_bans:  battle["scoreboard"]["dire"]["bans"].map { |item| item.values  }.flatten
        ) unless @cur_match

        @cur_match.update(
          game_no:                (@battle.radiant_score + @battle.dire_score + 1),
          status:                 "ongoing",
          battle_id:              @battle.id,
          duration:               battle["scoreboard"]["duration"],
          roshan_respawn_timer:   battle["scoreboard"]["roshan_respawn_timer"],
          radiant_score:          battle["scoreboard"]["radiant"]["score"],
          radiant_tower_state:    battle["scoreboard"]["radiant"]["tower_state"],
          radiant_barracks_state: battle["scoreboard"]["radiant"]["barracks_state"],
          radiant_picks: battle["scoreboard"]["radiant"]["picks"].map { |item| item.values  }.flatten,
          radiant_bans:  battle["scoreboard"]["radiant"]["bans"].map { |item| item.values  }.flatten,
          dire_score:          battle["scoreboard"]["dire"]["score"],
          dire_tower_state:    battle["scoreboard"]["dire"]["tower_state"],
          dire_barracks_state: battle["scoreboard"]["dire"]["barracks_state"],
          dire_picks: battle["scoreboard"]["dire"]["picks"].map { |item| item.values  }.flatten,
          dire_bans:  battle["scoreboard"]["dire"]["bans"].map { |item| item.values  }.flatten
        ) if @cur_match
      end

      def update_players(scoreboard)
        (scoreboard["radiant"]["players"] + scoreboard["dire"]["players"]).map do |info|
          @player = Player.with(:account_id, info["account_id"])

          @player.update(
            player_slot: info["player_slot"],
            kills:       info["kills"],
            death:       info["death"],
            assists:     info["assists"],
            last_hits:   info["last_hits"],
            denies:      info["denies"],
            gold:        info["gold"],
            level:       info["level"],
            gold_per_min: info["gold_per_min"],
            xp_per_min:   info["xp_per_min"],
            ultimate_state:    info["ultimate_state"],  
            ultimate_cooldown: info["ultimate_cooldown"],
            item0:             info["item0"],
            item1:             info["item1"],
            item2:             info["item2"],
            item3:             info["item3"],
            item4:             info["item4"],
            item5:             info["item5"],
            respawn_timer:     info["respawn_timer"],
            position_x:        info["position_x"],
            position_y:        info["position_y"],
            net_worth:         info["net_worth"]
          )
        end
      end
    end
  end
end