# encoding: utf-8
# 队伍需要有名字

class Hole::Team < ApplicationRecord

  include FilterConcern
  include Hole::TeamTransferConcern
  include Hole::TeamFetchT2Concern

  IdGameMap = {
    1 => "Dota2Team",
    2 => "CsgoTeam",
    3 => "LolTeam",
    4 => "KogTeam"
  }

  scope :with_name, ->(name) { where("name = ? or abbr = ?", name, name) }
  scope :with_game, ->(game_id = nil) { where(type: IdGameMap[game_id.to_i]) if game_id }
end
