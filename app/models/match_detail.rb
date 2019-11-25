class MatchDetail < ApplicationRecord
  belongs_to :match, class_name: "Hole::Match"
end