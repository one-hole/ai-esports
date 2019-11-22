class Team < ApplicationRecord
  include ArcWardenDbConcern
  include FilterConcern

  self.table_name = "teams"
  self.inheritance_column = nil

  scope :with_game_id, -> (game_id = nil) { where(game_id: game_id) if game_id.present? }
end
