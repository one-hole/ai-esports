module Dota2Constant
  class Ability < ApplicationRecord
    self.table_name = "dota2_abilities"

    def load_yml(filepath = nil)
    end
  end
end
