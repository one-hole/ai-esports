require_relative "team_actions"
require_relative "match_actions"

module Live
  module Tops
    module BattleActions

      include TeamActions
      include MatchActions

      def create_battle(battle_info)
        battle = Ohms::Battle.create(
          steam_id: battle_info["match_id"],
          server_steam_id: battle_info["server_steam_id"],
          created_at: Time.now,
          updated_at: Time.now
        )

        left_team = process_team(battle.id, {
          steam_id: battle_info["team_id_radiant"],
          name:     battle_info["team_name_radiant"]
        })

        right_team = process_team(battle.id, {
          steam_id: battle_info["team_id_dire"],
          name:     battle_info["team_name_dire"]
        })

        match = process_match(battle.id, battle_info)

        battle.update(
          left_team_id:  left_team.id,
          right_team_id: right_team.id,
          match_id:      match.id
        )

        battle
      end

      def update_battle(battle)

      end

      def find_battle(steam_id)
        Ohms::Battle.with(:steam_id, steam_id)
      end
    end
  end
end
