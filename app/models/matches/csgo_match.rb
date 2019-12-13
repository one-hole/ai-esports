class CsgoMatch < Hole::Match
  has_one :detail, foreign_key: "match_id", class_name: "CsgoMatchDetail"
end
