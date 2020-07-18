module Embrace
  class Team < ApplicationRecord
    self.table_name = 'embrace_teams'

    include FilterConcern
    scope :with_game, ->(game_id = nil) { where(game_id: game_id) if game_id }
  end
end