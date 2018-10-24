class ScheduleSerializer < ActiveModel::Serializer
  attributes :id, :round

  belongs_to :left_team
  belongs_to :right_team
end
