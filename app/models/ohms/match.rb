# 目前来看是没有必要存储 Match 的
module Ohms
  class Match < Ohm::Model

    attribute :battle_id                  # 对应的 Battle
    attribute :left_dire                  # 左边队伍是否是 Dire
    attribute :dire_score                 # Dire 小比分
    attribute :radiant_score              # Radiant 小比分
    attribute :dire_tower_state           # Dire 的塔状态
    attribute :radiant_tower_state        # Radiant 的塔状态
    attribute :dire_barracks_state
    attribute :radiant_barracks_state
    attribute :duration
    attribute :radiant_lead               # Radiant 领先的经济
    attribute :building_state             # 所有的建筑物的状态

    attribute :created_at
    attribute :updated_at

    unique :battle_id
    reference(:battle, "Ohms::Battle")
  end
end


=begin
  game_time => duration
  last_update_time
=end