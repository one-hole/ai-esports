require_relative "battle_actions"

module Live
  module Tops
    module Process

      include BattleActions

      def process(battles)
        battles.each { |battle| process_single(battle) if valid?(battle) }
      end

      def process_single(battle_info)
        battle = find_battle(battle_info["match_id"])

        if battle
          battle = update_battle(battle_info)
        else
          battle = create_battle(battle_info)
        end
      end



      def valid?(battle)
        return false if (battle["team_id_radiant"].nil? || battle["team_id_dire"].nil?)
        return true
      end
    end
  end
end