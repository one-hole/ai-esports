# TOP 里面有哪些信息可以统计一下

module Live
  module Tops
    module PlayerActions

      def process_players(battle_id, players_info)
        players_info.each { |player_info| process_player(battle_id, player_info) }
      end

      def process_player(battle_id, player_info)
        if player = Ohms::Player.load_by(battle_id, player_info["account_id"])
          update_player(player, player_info)
        else
          create_player(battle_id, player_info)
        end
      end

      def create_player(battle_id, player_info)
        Ohms::Player.create(
          account_id: player_info["account_id"],
          hero_id:    player_info["hero_id"],
          battle_id:  battle_id
        )
      end

      def update_player(player, player_info)
        player.update(
          hero_id:  player_info["hero_id"]
        )
      end
    end
  end
end