class Dota2Series < MatchSeries
  has_many :matches, foreign_key: 'match_series_id', class_name: 'Dota2Match'
end
