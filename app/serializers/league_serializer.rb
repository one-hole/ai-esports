class LeagueSerializer < LeagueListSerializer

  class SeriesSerializer < ActiveModel::Serializer
    attributes :id, :left_team_id, :right_team_id, :start_time, :status
    attributes :left_score, :right_score, :round

    def start_time
      return Time.at(object.start_time) if object.start_time
      return ''
    end
  end

  has_many :series, serializer: SeriesSerializer
  has_many :teams
end
