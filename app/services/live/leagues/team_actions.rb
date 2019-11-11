module Live
  module Leagues
    module TeamActions

      def process_team(battle, team_info)
        if team = find_team(team_info["team_id"])
          update_team(team, team_info)
        else
          create_team(battle, team_info)
        end
      end

      def create_team(battle, team_info)
        Ohms::Team.create(
          battle_id: battle.id,
          steam_id:  team_info["team_id"],
          name:      team_info["team_name"]
        )
      end

      def update_team(team, team_info)
      end

      def find_team(steam_id)
        Ohms::Team.with(:steam_id, steam_id)
      end
    end
  end
end