class Topic < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "topics"
  self.inheritance_column = :_type_disabled
  
  belongs_to :match_series, foreign_key: :series_id, class_name: "MatchSeries"
  has_many :bet_topics, foreign_key: :topic_id, class_name: "BetTopic"
end