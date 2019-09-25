module Live
  class Battle < Ohm::Model

    attribute :db_id
    attribute :stream_delay_s
    attribute :steam_id
    attribute :radiant_score
    attribute :dire_score
    attribute :lobby_id
    attribute :radiant_team_id
    attribute :dire_team_id
    attribute :format
    attribute :created_at # 创建的时间
    attribute :updated_at # 最后更新的时间

    unique :steam_id #唯一性索引、可以使用 with 方法查询

    collection(:matches, 'Live::Match')
    collection(:players, 'Live::Player')

    reference(:radiant_team, 'Live::Team')
    reference(:dire_team, 'Live::Team')

    def destroy

    end

    # 返回两队伍的名字 & 缩写
    def teams
      [self.radiant_team.name, self.dire_team.name]
    end

    def team_steam_ids
      [self.radiant_team.steam_id, self.dire_team.steam_id]
    end

    def info
      {
        data: self.attributes.reject { |k, v| [:steam_id, :stream_delay_s, :lobby_id, :radiant_team_id, :dire_team_id].include?(k) }.merge({ matches: match_infos})
      }
    end

    def match_infos
      infos = []
      matches.each do |match|
        infos << match.info
      end
      return infos
    end
  end
end

# Slot 0 是 radiant
