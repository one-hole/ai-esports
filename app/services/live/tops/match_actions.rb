module Live
  module Tops
    module MatchActions
      def process_match(battle_id, battle_info)
        match = find_match(battle_id)

        if match
          match = update_match(match, battle_info)         
        else
          match = create_match(battle_id, battle_info)
        end        
        match
      end

      def find_match(battle_id)
        Ohms::Match.with(:battle_id, battle_id)
      end

      def create_match(battle_id, battle_info)
        Ohms::Match.create(
          battle_id:     battle_id,
          duration:      battle_info["game_time"],
          dire_score:    battle_info["dire_score"],
          radiant_score: battle_info["radiant_score"],
          radiant_lead:  battle_info["radiant_lead"],
          created_at:    Time.now,
          updated_at:    Time.at(battle_info["last_update_time"]),
          building_state: battle_info["building_state"]
        )
      end

      def update_match(match, battle_info)
      end
    end
  end
end
