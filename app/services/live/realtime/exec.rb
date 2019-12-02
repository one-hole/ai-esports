require_relative "./match_actions.rb"

module Live
  module Realtime
    class Exec

      extend MatchActions

      def self.start(server_steam_id)
        resp = Live::Realtime::Request.run(server_steam_id)
        begin
          @battle_info = JSON.parse(resp.body, allow_nan: true)
          process
        rescue => e
          puts e
          return
        end
      end


      def self.process

        battle = load_battle(@battle_info["match"])
        if battle
          process_match(battle.match)
        else
          return
        end
      end

      def self.load_battle(match_info)
        Ohms::Battle.with(:steam_id, match_info["matchid"])
      end

    end
  end
end

# Live::Realtime::Exec.start()