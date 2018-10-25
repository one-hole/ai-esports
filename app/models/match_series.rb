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
  scope :today_or_yesterday, -> { where(start_time: (Date.yesterday.beginning_of_day.to_i)...(Date.tomorrow.beginning_of_day.to_i)) }

  scope :for_live_index, ->(game_id) { ongoing.today_or_yesterday.non_hidden.with_game(game_id) }

end

# t.index ["extern_id"], name: "index_match_series_on_extern_id"
# t.index ["game_id"], name: "index_match_series_on_game_id"
