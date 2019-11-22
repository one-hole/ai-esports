# 队伍需要有名字

class Hole::Team < ApplicationRecord

  Games = ["Dota2Team", "CsgoTeam", "LolTeam", "KogGame"]

  def self.transfer_winter
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