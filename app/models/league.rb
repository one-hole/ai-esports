class League < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "leagues"
end
