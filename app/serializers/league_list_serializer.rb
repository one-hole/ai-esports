class LeagueListSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :name, :logo, :secondary_logo, :start_time, :end_time
  attributes :area, :award, :level, :category
end