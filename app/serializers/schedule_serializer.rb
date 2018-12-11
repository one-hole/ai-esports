class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :round, :start_time, :status

  attributes :hltv_id

  def hltv_id
    return "" unless ("CsgoSeries" != object.type)
    object.extern_id.gsub('hltv_', '')
  end

  def start_time
    Time.at(object.start_time)
  end

  class TeamSerializer < ActiveModel::Serializer
    attributes :id, :tag, :logo, :country, :region
  end

  class LeagueSerializer < ActiveModel::Serializer
    attributes :id, :name
  end

  belongs_to :left_team,  serializer: TeamSerializer
  belongs_to :right_team, serializer: TeamSerializer
  belongs_to :league, serializer: LeagueSerializer
end
