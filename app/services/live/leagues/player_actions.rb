# encoding: utf-8

module Live
  module Leagues
    module PlayerActions

      def process_player(team, player_info)
                
        player = load_player(player_info["account_id"])

        if player
          player = update_player(team, player_info)
        else
          player = build_player(team, player_info)
        end
      end

      def build_player(team, player_info)
        Ohms::Player.create(
          account_id: player_info["account_id"],
          # name:       player_info["name"],
          hero_id:    player_info["hero_id"],
          team_id:    team.id,
          battle_id:  team.battle_id
        )
      end

      def update_player(team, player_info)
        binding.pry
      end

      def load_player(account_id)
        Ohms::Player.with(:account_id, account_id)
      end
    end
  end
end