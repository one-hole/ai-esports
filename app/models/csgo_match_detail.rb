class CsgoMatchDetail < ApplicationRecord
  belongs_to :match, class_name: "Hole::Match", foreign_key: "match_id"
end