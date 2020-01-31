module V2
  class LeaguesIndexSerializer < ActiveModel::Serializer

    attribute :id
    attribute :game_id
    attribute :name
    attribute :logo

  end
end