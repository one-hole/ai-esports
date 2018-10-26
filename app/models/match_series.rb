class MatchSeries < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "match_series"

  belongs_to :league, optional: true
  belongs_to :left_team,  foreign_key: :left_team_id,  class_name: 'Team'
  belongs_to :right_team, foreign_key: :right_team_id, class_name: 'Team'
  
  # delegate :name, to: :league, prefix: :league, allow_nil: true

  scope :non_pending, -> { where.not(status: 'pending') }
  scope :non_hidden,  -> { joins(:league).where('leagues.hidden = ?', false) }
  scope :around_date, -> (date = Date.today) { where(start_time: (date - 1.day).to_time.to_i...(date + 7.days).to_time.to_i) }
  scope :with_game,   -> (game_id) { where(game_id: game_id) }

  scope :ongoing,     -> { where(status: 1) }
  scope :finished,    -> { where(status: 2) }

  scope :today_or_yesterday, ->  { where(start_time: (Date.yesterday.beginning_of_day.to_i)...(Date.tomorrow.beginning_of_day.to_i)) }
  scope :prev_3_days,  -> (date) { where(start_time: (date.yesterday.yesterday.to_time.to_i)...(date.tomorrow.to_time.to_i))}

  scope :for_live_index,   ->(game_id) { ongoing.today_or_yesterday.non_hidden.with_game(game_id) }
  scope :for_result_index, ->(game_id = 1) { finished.non_hidden.prev_3_days(Date.today).with_game(game_id) }
end
