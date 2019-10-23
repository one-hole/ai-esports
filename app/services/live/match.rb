# 最后的实时信息应该从这里出
# 这里每次完成 Persist 之后需要清除自己的信息
# 这里需要真实的关注 天辉 和 夜魇

module Live
  class Match < Ohm::Model

    attribute :game_no
    attribute :status
    attribute :battle_id
    attribute :reverse
    attribute :duration
    attribute :roshan_respawn_timer
    attribute :radiant_score
    attribute :radiant_tower_state
    attribute :radiant_barracks_state
    attribute :radiant_picks
    attribute :radiant_bans

    attribute :dire_score
    attribute :dire_tower_state
    attribute :dire_barracks_state
    attribute :dire_picks
    attribute :dire_bans

    attribute :team_reversed

    index :battle_id
    index :game_no

    reference(:battle, 'Live::Battle')

    # 因为队伍会交换 TODO 这里的逻辑不对
    def radiant_team
      if team_reversed
        @radiant_team ||= battle.dire_team
      else
        @radiant_team ||= battle.radiant_team
      end
    end

    def dire_team
      if team_reversed
        @dire_team ||= battle.radiant_team
      else
        @dire_team ||= battle.dire_team
      end
    end

    def radiant_players
      @radiant_players = radiant_team.players
    end

    def radiant_player_infos
      infos = []
      radiant_players.each { |p| infos << p.info }
      return infos
    end

    def dire_player_infos
      infos = []
      dire_players.each { |p| infos << p.info }
      return infos
    end

    def dire_players
      @dire_players = dire_team.players
    end

    def radiant_gold
      @radiant_gold = 0
      radiant_players.each { |p| @radiant_gold += p.net_worth.to_i }
      return @radiant_gold
    end

    def dire_gold
      @dire_gold = 0
      dire_players.each { |p| @dire_gold += p.net_worth.to_i }
      return @dire_gold
    end

    def radiant_xp
      @radiant_xp = 0
      radiant_players.each { |p| @radiant_xp += p.xp_per_min.to_i }
      return (@radiant_xp * duration.to_i / 60).to_i
    end

    def dire_xp
      @dire_xp = 0
      dire_players.each { |p| @dire_xp += p.xp_per_min.to_i }
      return (@dire_xp * duration.to_i / 60).to_i
    end

    # 这里持久化到数据库里面
    def persist
    end

    def info
      self.attributes.reject { |k, v| [:battle_id].include?(k) }.merge({
        radiant_gold: radiant_gold,
        radiant_xp:   radiant_xp,
        dire_gold:    dire_gold,
        dire_xp:      dire_xp,
        radiant_team: radiant_team.info,
        dire_team:    dire_team.info,
        radiant_players: radiant_player_infos,
        dire_players:    dire_player_infos
      })
    end
  end
end
