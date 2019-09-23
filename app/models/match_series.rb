class MatchSeries < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "match_series"

  belongs_to :league, optional: true
  belongs_to :left_team,  foreign_key: :left_team_id,  class_name: 'Team'
  belongs_to :right_team, foreign_key: :right_team_id, class_name: 'Team'

  has_many :all_topics, foreign_key: :series_id, class_name: "Topic"
  has_many :bet_topics, through: :all_topics

  # delegate :name, to: :league, prefix: :league, allow_nil: true

  default_scope { where(deleted_at: nil) }

  scope :non_pending, -> { where.not(status: -3) }
  scope :non_hidden,  -> { joins(:league).where('leagues.hidden = ?', false) }
  scope :around_date, -> (date = Date.today) { where(start_time: (date - 1.day).to_time.to_i...(date + 7.days).to_time.to_i) }
  scope :with_date,   -> (date)    { where(start_time: (date.beginning_of_day - 8.hours).to_i...(date.end_of_day - 8.hours).to_i) }
  scope :with_game,   -> (game_id) { where(game_id: game_id) }

  scope :ongoing,     -> { where(status: 1) }
  scope :finished,    -> { where(status: 2) }

  scope :today_or_yesterday, ->  { where(start_time: (Date.yesterday.beginning_of_day.to_i)...(Date.tomorrow.beginning_of_day.to_i)) }
  scope :prev_3_days,  -> (date) { where(start_time: (date.yesterday.yesterday.to_time.to_i)...(date.tomorrow.to_time.to_i))}

  scope :for_live_index,   ->(game_id = 1) { ongoing.today_or_yesterday.non_hidden.with_game(game_id) }
  scope :for_result_index, ->(game_id = 1) { finished.non_hidden.prev_3_days(Date.today).with_game(game_id) }

  def ongoing?
    return self.status == 1
  end

  def finished?
    return self.status == 2
  end

  def names
    [left_team.name, right_team.name]
  end

  def ids
    [left_team.rw_id, right_team.rw_id]
  end

  # 如果比赛还没有开始 & 那就不存在 current_match
  # 所以这里的隐藏条件是比赛正在进行中
  def current_match
    self.matches.find_by(game_no: (self.left_score + self.right_score + 1))
    # self.matches.find_by(game_no: (self.left_score + self.right_score))
  end
end
