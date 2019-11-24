module Hole
  module TeamTransferConcern
    extend ActiveSupport::Concern

    class_methods do
      Games = ["Dota2Team", "CsgoTeam", "LolTeam", "KogGame"]

      def transfer_winter
        ::Team.find_each do |winter_team|

          if Games.include?(winter_team.type)
            self.create(
              name:        winter_team.name,
              abbr:        winter_team.tag,
              logo:        winter_team.logo,
              type:        winter_team.type,
              country:     (winter_team.country.downcase rescue nil),
              official_id: (winter_team.extern_id.nil? ? nil : winter_team.extern_id.to_s)
            )
          end
        end
      end
    end
  end
end