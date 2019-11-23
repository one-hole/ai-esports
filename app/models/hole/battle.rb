class Hole::Battle < ApplicationRecord
  belongs_to :left_team,  foreign_key: "left_team_id",  class_name: "Hole::Team"
  belongs_to :right_team, foreign_key: "right_team_id", class_name: "Hole::Team"

  enum status: {
    upcoming: 1,
    ongoing:  2,
    finished: 3
  }
end
