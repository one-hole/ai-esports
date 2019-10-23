module Live
  module Tops
    module Util
      module BattleActions

        def create_battle(battle)
          return Battle.create(
            stream_delay_s:  battle["delay"]
            server_steam_id: battle["server_steam_id"],
            steam_id:        battle["match_id"],
            building_state:  battle["building_state"],
            radiant_lead:    battle["radiant_lead"],
            radiant_score:   battle["radiant_score"],
            dire_score:      battle["dire_score"],
            lobby_id:        battle["lobby_id"],
            created_at:      Time.now,
            updated_at:      Time.now
          )
        end

        def update_battle(battle)
        end

        def create_match(battle)
          @match = Match.find(battle_id: @battle.id).first
        end

      end
    end
  end
end

# team_id_radiant
# team_id_dire
# team_name_radiant
# team_name_dire
