module Live
  module Realtime
    module TeamActions

      def process_team(team_info, battle_id)
        # team = Ohms::Team[team_info["team_id"]]
        unless battle_id
          puts "BattleID Nil"
        end
        team = Ohms::Team.load_by(team_info["team_id"], battle_id)
        team.update(
          logo: team_info["team_logo_url"]
        )
        process_players(team, team_info["players"])
      end


      def process_players(team, players)
        players.each do |player_info|
          player = find_or_create_player(team.battle_id, player_info["accountid"])
          process_player(team, player, player_info)
        end
      end

      def find_or_create_player(battle_id, account_id)
        player = Ohms::Player.load_by(battle_id, account_id)
        return player if player
        return Ohms::Player.create(account_id: account_id, battle_id: battle_id) unless player
      end

      # 这里还真的不一定需要判定大小
      def process_player(team, player, player_info)
        player.update(
          team_id:        team.id,
          battle_id:      team.battle_id,
          name:           player_info["name"],
          hero_id:        player_info["heroid"],
          level:          [player_info["level"],         player.level.to_i].max,
          kill_count:     [player_info["kill_count"],    player.kill_count.to_i].max,
          death_count:    [player_info["death_count"],   player.death_count.to_i].max,
          assists_count:  [player_info["assists_count"], player.assists_count.to_i].max,
          denies_count:   [player_info["denies_count"],  player.denies_count.to_i].max,
          last_hit_count: [player_info["lh_count"],      player.last_hit_count.to_i].max,
          gold:           player_info["gold"],
          net_worth:      [player_info["net_worth"],     player.net_worth.to_i].max,
          abilities:      player_info["abilities"],
          items:          player_info["items"],
          x:              player_info["x"] * 20000,
          y:              player_info["y"] * 20000
        )
      end
    end
  end
end