module V2
  class BattlesIndexSerializer < ActiveModel::Serializer
    attributes :id, :status
    attributes :start_at
    attributes :round
    attributes :game

    belongs_to :league

    attributes :left_team, :right_team

    class LeagueSerializer < ActiveModel::Serializer
      attributes :id, :name, :abbr, :logo
    end

    def round
      object.format
    end

    def game
      Hole::Battle::Types.invert[object.type]
    end

    def left_team
      {
        id:       object.left_team.id,
        abbr:     object.left_team.abbr,
        logo:     object.left_team.logo,
        country:  object.left_team.country
      }
    end

    def right_team
      {
        id:       object.right_team.id,
        abbr:     object.right_team.abbr,
        logo:     object.right_team.logo,
        country:  object.right_team.country
      }
    end
  end
end