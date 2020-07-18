module Embrace
  class League < ApplicationRecord
    self.table_name = 'embrace_leagues'

    include FilterConcern
    scope :with_game, ->(game_id = nil) { where(game_id: game_id) if game_id }

    belongs_to :game
  end
end

# params = {
#   game: 1
# }