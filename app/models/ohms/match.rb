# 目前来看是没有必要存储 Match 的
module Ohms
  class Match < Ohm::Model

    attribute :battle_id                  # 对应的 Battle
    attribute :dire_score                 # Dire 小比分
    attribute :radiant_score              # Radiant 小比分
    attribute :dire_tower_state           # Dire 的塔状态
    attribute :radiant_tower_state        # Radiant 的塔状态
    attribute :dire_barracks_state
    attribute :radiant_barracks_state
    attribute :duration
    attribute :radiant_lead               # Radiant 领先的经济
    attribute :building_state             # 所有的建筑物的状态

    attribute :radiant_picks
    attribute :radiant_bans
    attribute :dire_picks
    attribute :dire_bans

    attribute :created_at
    attribute :updated_at

    unique :battle_id
    reference(:battle, "Ohms::Battle")

    def as_info
      {
        dire_score:             self.dire_score,
        radiant_score:          self.radiant_score,
        dire_tower_state:       self.dire_tower_state,
        radiant_tower_state:    self.radiant_tower_state,
        dire_barracks_state:    self.dire_barracks_state,
        radiant_barracks_state: self.radiant_barracks_state,
        duration:               self.duration,
        radiant_lead:           self.radiant_lead
      }
    end
  end
end


=begin
  game_time => duration
  last_update_time
=end