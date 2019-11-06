# Battle 只有系列赛的信息
# Match  只有当前正在打的信息

module Live
  class Battle < Ohm::Model

    attribute :db_id
    attribute :stream_delay_s
    attribute :steam_id         # 对应的就是 Steam APi 里面的 MatchID
    attribute :left_score       # 大比分
    attribute :right_score      # 大比分
    attribute :lobby_id         # 暂时不知道有什么作用
    attribute :server_steam_id  # Steam 服务器的 ID
    attribute :left_team_id     # 初始化的时候为 radiant
    attribute :right_team_id    # 初始化的时候为 dire
    attribute :format           # 赛制
    attribute :created_at       # 创建的时间
    attribute :updated_at       # 最后更新的时间

    # attribute :building_state   # 建筑物的状态
    # attribute :radiant_lead     # radiant 经济领先的值

    unique :steam_id #唯一性索引、可以使用 with 方法查询

    reference(:match, 'Live::Match')
    collection(:players, 'Live::Player')

    def radiant_team
      Live::Team[self.radiant_team_id]
    end

    def dire_team
      Live::Team[self.dire_team_id]
    end

    def destroy
      players.each do |p|
        p.destroy
      end

      matches.each do |m|
        m.delete
      end

      self.radiant_team.delete if self.radiant_team
      self.dire_team.delete if self.dire_team
      self.delete
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
