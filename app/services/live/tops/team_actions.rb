module Live
  module Tops
    module TeamActions

      def process_team(battle_id, opts)
        team = find_team(opts[:steam_id])

        if team
          return update_team(team, opts)
        else
          return create_team(battle_id, opts)
        end
      end

      def create_team(battle_id, opts)
        Ohms::Team.create(
          battle_id: battle_id,
          steam_id:  opts[:steam_id],
          name:      opts[:name]
        )
      end

      def update_team(team, opts)
        team.update(opts)
      end

      def find_team(steam_id)
        Ohms::Team.with(:steam_id, steam_id)
      end

    end
  end
end