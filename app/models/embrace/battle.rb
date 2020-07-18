module Embrace
  class Battle < ApplicationRecord
    self.table_name = 'embrace_battles'

    include FilterConcern

    belongs_to :game
    belongs_to :tournament
    has_one :left_team,  class_name: 'Team'
    has_one :right_team, class_name: 'Team'
  end
end