module Live
  class Battle < Ohm::Model

    attribute :stream_delay_s
    attribute :steam_id
    attribute :radiant_score
    attribute :dire_score
    attribute :lobby_id
    attribute :radiant_team_id
    attribute :dire_team_id

    unique :steam_id #唯一性索引、可以使用 with 方法查询

    collection(:matches, 'Live::Match')
    collection(:players, 'Live::Player')

    reference(:radiant_team, 'Live::Team')
    reference(:dire_team, 'Live::Team')

    # 返回两队伍的名字 & 缩写
    def teams
      [self.radiant_team.name, self.dire_team.name]
    end

    def team_steam_ids
      [self.radiant_team.steam_id, self.dire_team.steam_id]
    end

    def info
      self.attributes.merge({
        abc: "abc"
      })
    end
  end
end

# Slot 0 是 radiant