# MatchSeries & 找到当前正在打的 Match

class LiveSerializer < ActiveModel::Serializer
  attributes :status, :left_radiant, :match_id, :duration, :league, :game_no
  attributes :left_lead, :left_team_first_blood, :left_team_ten_kills
  attributes :left_series_score, :right_series_score, :left_score, :right_score
  attributes :radiant_tower_state, :dire_tower_state
  attributes :radiant_barracks_state, :dire_barracks_state
  attributes :left_gold, :left_xp, :right_gold, :right_xp
  attributes :left_team, :right_team
  attributes :left_bans, :left_picks, :right_bans, :right_picks
  attributes :left_players, :right_players
  attributes :left_gold, :right_gold, :left_xp, :right_xp
  attributes :gold_diff, :xp_diff
  attributes :max_gold_diff, :max_xp_diff, :min_gold_diff, :min_xp_diff
  attributes :events, :radiant_lead
end
