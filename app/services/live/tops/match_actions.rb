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

      private

      def find_match(battle_id)
        Ohms::Match.with(:battle_id, battle_id)
      end

      def create_match(battle_id, battle_info)
        match = Ohms::Match.create(
          battle_id:      battle_id,
          duration:       battle_info["game_time"],
          dire_score:     battle_info["dire_score"],
          radiant_score:  battle_info["radiant_score"],
          radiant_lead:   battle_info["radiant_lead"],
          created_at:     Time.now,
          updated_at:     Time.at(battle_info["last_update_time"]),
          building_state: battle_info["building_state"],
          radiant_picks:  [],
          radiant_bans:   [],
          dire_picks:     [],
          dire_bans:      []
        )

        match.add_diff
        return match
      end

      # 这里的 UPDATE 需要有几个条件
      # 1. BP 数据都必须全
      def update_match(match, battle_info)

        match.update(
          updated_at:       Time.at(battle_info["last_update_time"]),
          building_state:   battle_info["building_state"],
          duration:         get_duration(match, battle_info),
          dire_score:       battle_info["dire_score"],
          radiant_score:    battle_info["radiant_score"],
          radiant_lead:     battle_info["radiant_lead"]
        )

        match.add_diff
        return match
      end

      def get_duration(match, battle_info)        
        if can_update?(match)
          return battle_info["game_time"]
        end
        return 0
      end


      def can_update?(match)
        return match.bp_over?
      end

    end
  end
end
