module Embrace
  class Game < ApplicationRecord
    self.table_name = 'embrace_games'

    has_many :leagues

  end
end