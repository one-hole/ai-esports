# encoding: utf-8

class Hole::Battle < ApplicationRecord

  include FilterConcern

  default_scope { where(hidden: false) }

  Types = {
    1 => 'Dota2Battle',
    2 => 'CsgoBattle',
    3 => 'LolBattle',
    4 => 'KogBattle'
  }

  belongs_to :left_team,  foreign_key: "left_team_id",  class_name: "Hole::Team"
  belongs_to :right_team, foreign_key: "right_team_id", class_name: "Hole::Team"

  belongs_to :league, optional: true
  has_many :matches

  enum status: {
    canceled: 0,
    upcoming: 1,
     ongoing: 2,
    finished: 3,
      hidden: 9
  }

  def team_official_infos
    [
      [left_team.official_id.to_i, right_team.official_id.to_i],
      [left_team.name ? left_team.name.downcase : "" , left_team.abbr ? left_team.abbr.downcase : "",  right_team.name ? right_team.name.downcase : "" , right_team.abbr ? right_team.abbr.downcase : ""]
    ]
  end

  def current_game_no
    left_score + right_score + 1
  end

  # 最近的比赛（1. 未开始但是开始时间在一个小时内的）
  scope :recents,     -> { self.upcoming.merge(self.where("start_at < ?", Time.now + 45.minutes)) }
  scope :with_game,   -> (game = nil) { where(type: Types[game.to_i]) if game }
  scope :with_from,   -> (from = nil) { where("start_at >= ?", from) if from }
  scope :with_to,     -> (to  = nil)  { where("start_at <= ?", to) if to }
  scope :with_date,   -> (date = nil) { where("DATE(start_at) = ?", date) if date}
  scope :with_status, -> (status = nil)  { where(status: status) if status}
end
