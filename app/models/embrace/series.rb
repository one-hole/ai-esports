module Embrace
  class Series < ApplicationRecord
    self.table_name = 'embrace_series'

    include FilterConcern
    scope :with_league, ->(league_id = nil) { where(league_id: league_id) if league_id }
    scope :with_game, ->(game_id = nil) { where(game_id: game_id) if game_id }

    belongs_to :game
    belongs_to :league
  end
end