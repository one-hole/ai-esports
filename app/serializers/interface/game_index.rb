module Interface
  class GameIndex < ActiveModel::Serializer
    attribute :id
    attribute :en_name
    attribute :name
    attribute :abbr
  end
end