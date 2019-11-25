# encoding: utf-8

class Hole::Battle < ApplicationRecord

  belongs_to :left_team,  foreign_key: "left_team_id",  class_name: "Hole::Team"
  belongs_to :right_team, foreign_key: "right_team_id", class_name: "Hole::Team"

  has_many :matches

  enum status: {
    upcoming: 1,
    ongoing:  2,
    finished: 3
  }

  def team_official_infos
    [
      [left_team.official_id.to_i, right_team.official_id.to_i],
      [left_team.name.downcase, left_team.abbr.downcase, right_team.name.downcase, right_team.abbr.downcase]
    ]
  end
  
  # 最近的比赛（1. 未开始但是开始时间在一个小时内的）
  scope :recents, -> { self.upcoming.merge(self.where("start_at < ?", Time.now + 45.minutes)) }
end
