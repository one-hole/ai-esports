class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :round, :start_time, :status

  attributes :hltv_id

  def hltv_id
    # binding.pry
    return "" if ("CsgoSeries" != object.type)
    if object.extern_id
      return object.extern_id.gsub('hltv_', '')
    else
      return " "
    end
  end

  def start_time
    return Time.at(object.start_time) if object.start_time
    return ""
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
