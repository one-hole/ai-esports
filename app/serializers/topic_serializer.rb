class TopicSerializer < ActiveModel::Serializer
  attributes :id

  class BetSerializer < ActiveModel::Serializer
    attributes :id, :name, :value, :type, :handicap
    attributes :left_odd, :right_odd
  end

  has_many :bet_topics, serializer: BetSerializer, key: "topics"

end