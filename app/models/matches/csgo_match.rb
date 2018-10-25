class CsgoMatch < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "csgo_matches"
end