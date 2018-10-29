# 根据当前比赛数据和上次请求到得比赛数据获取的log信息
#
module Dota2Live
  class LiveMatchLog < Ohm::Model

    extend MatchLog::Team
    extend MatchLog::Player
    extend MatchLog::Ability

    attribute :match_id
    attribute :radiant_gold
    attribute :radiant_xp
    attribute :dire_gold
    attribute :dire_xp
    attribute :radiant_abilities
    attribute :dire_abilities
    attribute :gold_diff
    attribute :xp_diff
    attribute :events
    attribute :items_map

    index :match_id

    def self.create_or_update(match)
      log = self.find(match_id: match['match_id']).first
      create_log(match) if log.nil?
      update_log(match, log) unless log.nil?
    end

    def self.create_log(match)
      self.create(
        match_id:           match['match_id'],
        radiant_gold:       [],
        radiant_xp:         [],
        radiant_abilities:  {0 => [], 1 => [], 2 => [], 3 => [], 4 => []}.to_json,
        dire_abilities:     {0 => [], 1 => [], 2 => [], 3 => [], 4 => []}.to_json,
        dire_gold:          [],
        dire_xp:            [],
        gold_diff:          [],
        xp_diff:            [],
        events:             [],
        items_map:          {}
      )
    end

    def self.update_log(match, log)
      # ---------------------------------------------------------------------------
      # Validation
      # ---------------------------------------------------------------------------
      prev_match = LiveMatch.find(match_id: match['match_id']).first
      return if prev_match.nil?
      return if prev_match.duration.to_i == match['scoreboard']['duration'].to_i

      # ----------------------------------------------------------------------------
      # 基础数据获取
      # ----------------------------------------------------------------------------
      duration = match['scoreboard']['duration'].to_i
      radiant_players = radiant_players(match)
      dire_players = dire_players(match)

      # ----------------------------------------------------------------------------
      # 队伍信息更新
      # ----------------------------------------------------------------------------
      radiant_data = update_team_info(log, radiant_players, true, duration)
      dire_data = update_team_info(log, dire_players, false, duration)
      update_team_diff(log, radiant_data, dire_data, duration)

      # -----------------------------------------------------------------------------
      # 选手信息更新
      # -----------------------------------------------------------------------------
      update_players_event(log, match, prev_match, radiant_players, 'radiant', duration)
      update_players_event(log, match, prev_match, dire_players, 'dire', duration)

      # --------------------------------------------------------------------------------
      # 技能信息更新
      # --------------------------------------------------------------------------------
      update_abilities(log, match, prev_match)
    end

  end
end