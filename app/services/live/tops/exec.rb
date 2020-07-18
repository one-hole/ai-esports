require_relative './request'
require_relative './battle_actions'

module Live
  module Tops
    class Exec

      extend BattleActions

      def self.start

        @redis = Redis.new
        resp = Request.run
        battles = JSON.parse(resp.body, allow_nan: true)["game_list"]
        process(battles)
        return nil
      end

      def self.process(battles)
        battles.each { |battle| process_single(battle) if valid?(battle) } if battles
      end

      def self.process_single(battle_info)
        battle = find_battle(battle_info["match_id"])

        if battle
          battle = update_battle(battle, battle_info)
        else
          battle = create_battle(battle_info)
        end

        Ohms::Publish.new(battle).pub(@redis)
      end

      def self.valid?(battle)
        return false if (battle["team_id_radiant"].nil? || battle["team_id_dire"].nil?)
        return true
      end

    end
  end
end


# Live::Tops::Exec.start