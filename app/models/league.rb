class League < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "leagues"

  has_many :series, foreign_key: :league_id, class_name: 'MatchSeries'

  has_many :left_teams,  through: :series
  has_many :right_teams, through: :series

  def teams
    return (left_teams + right_teams).uniq
  end

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

# league = League.significant.no_hidden.last