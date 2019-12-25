# Battle 只有系列赛的信息
# Match  只有当前正在打的信息
# LeftTeam RightTeam 应该在赛程的时候就已经有了定论

module Ohms
  class Battle < Ohm::Model

    attribute :steam_id           # 对应的就是 Steam APi 里面的 MatchID
    attribute :radiant_team_id    # 初始化的时候为 radiant (存储的是 Ohm 里面的 TeamID)
    attribute :dire_team_id       # 初始化的时候为 dire
    attribute :radiant_score      # 大比分
    attribute :dire_score         # 大比分
    attribute :server_steam_id    # Steam 服务器的 ID
    attribute :format
    attribute :created_at
    attribute :updated_at
    attribute :match_id
    attribute :db_id

    unique :steam_id
    index :db_id

    reference(:match, "Ohms::Match")
    reference(:radiant_team, "Ohms::Team")
    reference(:dire_team, "Ohms::Team")
    collection(:players, "Ohms::Player")

    def teams_has_dbid?      
      return (radiant_team.db_id.present? && dire_team.db_id.present?)
      return false
    end

    def team_ids
      [radiant_team.steam_id, dire_team.steam_id]
    end

    def as_info
      {
        steam_id:        steam_id,
        db_id:           self.db_id,
        radiant_score:   self.radiant_score,
        dire_score:      self.dire_score,
        radiant_team:    self.radiant_team.as_info,
        dire_team:       self.dire_team.as_info,
        match:           match.as_info
      }
    end

    # TODO 暂时留一个接口
    def destroy
      puts "Deleting #{self.id}"
    end
  end
end
