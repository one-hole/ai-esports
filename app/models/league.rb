class League < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "leagues"

  scope :no_hidden, -> { where(:hidden => false)}
  scope :with_game, -> (game_id = nil) { where(game_id: game_id.to_i) unless game_id == nil }
  scope :significant, -> {
    where.not(start_time: nil)
      .where.not(end_time: nil)
      .where.not(award: '')
      .where.not(area: '')
      .where.not(category: '')
      .where.not(secondary_logo: '')
  }
end
