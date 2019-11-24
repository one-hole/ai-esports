# encoding: utf-8
# 队伍需要有名字

class Hole::Team < ApplicationRecord
  include Hole::TeamTransferConcern
  include Hole::TeamFetchT2Concern

  scope :with_name, ->(name) { where("name = ? or abbr = ?", name, name) }
end