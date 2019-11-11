module Live
  module Leagues
    module BattleActions

      def process_battle(battle_info)
        if battle = find_battle(battle_info["match_id"])
          update_battle(battle, battle_info)
        else

          binding.pry

          battle = create_battle(battle_info)
        end
      end

      def find_battle(steam_id)
        Ohms::Battle.with(:steam_id, steam_id)
      end

      def create_battle(battle_info)
        # TODO Clean Teams
        battle = Ohms::Battle.create(
          steam_id: battle_info["match_id"],
        )
      end

      def update_battle(battle, battle_info)

      end

    end
  end
end