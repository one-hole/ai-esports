class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :round, :start_time
  attributes :league_name

  def start_time
    Time.at(object.start_time)
  end

  class TeamSerializer < ActiveModel::Serializer
    attributes :id, :tag, :logo, :country, :region
  end

  belongs_to :left_team,  serializer: TeamSerializer
  belongs_to :right_team, serializer: TeamSerializer
end
