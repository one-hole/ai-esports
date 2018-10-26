class KogSeries < MatchSeries
  has_many :matches, foreign_key: 'match_series_id', class_name: 'KogMatch'
end
