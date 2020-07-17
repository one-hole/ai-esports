module Interface
  class LeagueIndex < ActiveModel::Serializer
    attribute :id
    attribute :name
    attribute :image
    attribute :game_id
    attribute :cn_name
  end
end