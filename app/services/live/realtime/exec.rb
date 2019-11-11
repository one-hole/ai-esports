require_relative "./match_actions.rb"

module Live
  module Realtime
    class Exec

      extend MatchActions

      def self.start(server_steam_id)
        resp = Request.run(server_steam_id)
        begin
          @battle_info = JSON.parse(resp.body)
          process
        rescue => e
          puts e
          return
        end

        binding.pry
      end


      def self.process

        battle = load_battle(@battle_info["match"])

        binding.pry

        if battle
          update_battle(battle)
          process_match(battle.match)

        else
          return
        end
      end

      def self.load_battle(match_info)
        Ohms::Battle.with(:steam_id, match_info["matchid"])
      end

      def self.update_battle(battle)

      end

      def self.update_match()

      end
    end
  end
end

# Live::Realtime::Exec.start()