class BetTopic < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "bet_topics"
  self.inheritance_column = :_type_disabled

  belongs_to :topic, foreign_key: :topic_id, class_name: "Topic"

  delegate :match_series, to: :topic
  delegate :name, :value, :type, :handicap, to: :topic
  
end