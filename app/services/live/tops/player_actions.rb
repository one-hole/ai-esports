module Live
  module Tops
    module PlayerActions

      def process_players(battle_id, players_info)
        players_info.each { |player_info| process_player(battle_id, player_info) }
      end

      def process_player(battle_id, player_info)
        if find_player(player_info["account_id"])
          update_player(player_info)
        else
          create_player(battle_id, player_info)
        end
      end

      private

      def find_player(account_id)
        Ohms::Player.with(:account_id, account_id)
      end

      def create_player(battle_id, player_info)
        Ohms::Player.create(
          account_id: player_info["account_id"],
          hero_id:    player_info["hero_id"],
          battle_id:  battle_id
        )
      end

      def update_player(player_info)

      end
    end
  end
end