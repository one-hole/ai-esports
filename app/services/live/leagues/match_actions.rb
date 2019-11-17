# encoding: utf-8

module Live
  module Leagues
    module MatchActions
      def process_match(battle, battle_info)
        match = load_match(battle.id)

        if match
        else
          match = build_match(battle, battle_info)
        end
      end

      def load_match(battle_id)
        Ohms::Match.with(:battle_id, battle_id)
      end

    end
  end
end