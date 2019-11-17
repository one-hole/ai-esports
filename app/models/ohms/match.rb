# 目前来看是没有必要存储 Match 的
module Ohms
  class Match < Ohm::Model

    attribute :steam_id
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

    attribute :radiant_net_worth
    attribute :dire_net_worth

    attribute :game_no  # 当前进行的是第几场

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
        radiant_lead:           self.radiant_lead,
        radiant_picks:          self.radiant_picks,
        radiant_bans:           self.radiant_bans,
        dire_picks:             self.dire_picks,
        dire_bans:              self.dire_bans,
        radiant_net_worth:      self.radiant_net_worth,
        dire_net_worth:         self.dire_net_worth
        # radiant_team:           self.radiant_team.as_info,
        # dire_team:              self.dire_team.as_info
      }
    end

    def radiant_team
      self.battle.radiant_team
    end

    def dire_team
      self.battle.dire_team
    end
  end
end

# 之前的理解是存在偏差的：真实的情况是 Match 有 SteamID Battle 没有 SteamID