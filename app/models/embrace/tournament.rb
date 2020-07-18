module Embrace
  class Tournament < ApplicationRecord
    self.table_name = 'embrace_tournaments'

    include FilterConcern
    scope :with_series, ->(series_id = nil) { where(series_id: series_id) if series_id }
    scope :with_league, ->(league_id = nil) { where(league_id: league_id) if league_id }
    scope :with_game, ->(game_id = nil) { where(game_id: game_id) if game_id }

    belongs_to :game
    belongs_to :league
    belongs_to :series
  end
end