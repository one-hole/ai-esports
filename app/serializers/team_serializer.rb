class TeamSerializer < ActiveModel::Serializer
  attributes :id, :game_id, :tag, :name, :logo, :country, :region
end
