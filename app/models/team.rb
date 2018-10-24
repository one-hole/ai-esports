class Team < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "teams"
end
