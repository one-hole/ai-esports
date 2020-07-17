module Interface
  class TeamIndex < ActiveModel::Serializer
    attribute :id
    attribute :game_id
    attribute :image
    attribute :country
    attribute :name
    attribute :abbr
  end
end