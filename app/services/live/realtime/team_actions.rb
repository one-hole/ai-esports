module Live
  module Realtime
    module TeamActions

      def process_team(team_info)
        team = Ohms::Team[team_info["team_id"]]
        team.update(
          logo: team_info["team_logo_url"]
        )
        process_players(team, team_info["players"])
      end


      def process_players(team, players)
        players.each do |player_info|
          player = find_or_create_player(player_info["accountid"])
          process_player(team, player, player_info)
        end
      end

      def find_or_create_player(account_id)
        player = Ohms::Player.with(:account_id, account_id)
        return player if player
        return Ohms::Player.create(account_id: account_id) unless player
      end

      # 这里还真的不一定需要判定大小
      # TODO 这里的 Update 还是需要判定大小
      def process_player(team, player, player_info)
        player.update(
          team_id:        team.id,
          battle_id:      team.battle_id,
          name:           player_info["name"],
          hero_id:        player_info["heroid"],
          level:          player_info["level"],
          kill_count:     player_info["kill_count"],
          death_count:    player_info["death_count"],
          assists_count:  player_info["assists_count"],
          denies_count:   player_info["denies_count"],
          last_hit_count: player_info["lh_count"],
          gold:           player_info["gold"],
          net_worth:      player_info["net_worth"],
          abilities:      player_info["abilities"],
          items:          player_info["items"],
          x:              player_info["x"],
          y:              player_info["y"]
        )
      end
    end
  end
end