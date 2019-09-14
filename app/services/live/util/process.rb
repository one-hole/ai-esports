module Live
  module Util
    module Process

      def process_currents(battle)
        build_battle(battle)
        build_teams(battle)
        update_battle(battle) # 这里更新是因为持久化队伍之后才能把队伍的数据更新到 Battle 里面
        build_players(battle) # Player 会关联到队伍里面 0 是 radiant
        # build_match(battle)
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
            puts "here"
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
        # @cur_match = Match.create(
        #   game_no:    (@battle.radiant_score + @battle.dire_score + 1),
        #   status:     "ongoing",
        #   battle_id:  @battle.id,
        # )
      end

      def update_previous_match
        
      end

    end
  end
end