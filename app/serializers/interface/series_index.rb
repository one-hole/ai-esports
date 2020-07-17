module Interface
  class SeriesIndex < ActiveModel::Serializer
    attribute :id
    attribute :name
    attribute :season
    attribute :game_id
    attribute :cn_name
    attribute :begin_at
    attribute :end_at
    attribute :year
  end
end