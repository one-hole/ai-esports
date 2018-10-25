class CsgoSeries < MatchSeries
  has_many :matches, foreign_key: 'series_id', class_name: 'CsgoMatch', dependent: :destroy
end
