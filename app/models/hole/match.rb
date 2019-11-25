class Hole::Match < ApplicationRecord
  has_one    :detail, class_name: "MatchDetail"
  belongs_to :battle
end