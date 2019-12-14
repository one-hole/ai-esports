class Hole::Match < ApplicationRecord
  # has_one    :detail, class_name: "MatchDetail"
  belongs_to :battle


  # delegate :left_first_blood, :left_first_tower, :left_five_kills, :left_ten_kills, :left_lead, to: :detail



end