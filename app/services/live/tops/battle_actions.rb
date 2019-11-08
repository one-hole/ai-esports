require_relative "team_actions"
require_relative "match_actions"
require_relative "player_actions"

module Live
  module Tops
    module BattleActions

      include TeamActions
      include MatchActions
      include PlayerActions

      def create_battle(battle_info)
        battle = Ohms::Battle.create(
          steam_id:        battle_info["match_id"],
          server_steam_id: battle_info["server_steam_id"],
          created_at:      Time.now,
          updated_at:      Time.now
        )

        radiant_team = process_team(battle.id, {
          steam_id: battle_info["team_id_radiant"],
          name:     battle_info["team_name_radiant"]
        })

        dire_team = process_team(battle.id, {
          steam_id: battle_info["team_id_dire"],
          name:     battle_info["team_name_dire"]
        })

        match = process_match(battle.id, battle_info)
        process_players(battle.id, battle_info["players"])

        battle.update(
          radiant_team_id:  radiant_team.id,
          dire_team_id:     dire_team.id,
          match_id:         match.id
        )

        battle
      end

      # UpdateBattle 这里主要只能是
      # 如果 Battle 是 Leagues 先创建的, 这里 Update 就需要重新写了 TODO
      # Update Match
      # Update Player

      def update_battle(battle, battle_info)
        battle.update(updated_at: Time.now)
        process_match(battle.id, battle_info)
        process_players(battle.id, battle_info["players"])
      end

      def find_battle(steam_id)
        Ohms::Battle.with(:steam_id, steam_id)
      end
    end
  end
end
