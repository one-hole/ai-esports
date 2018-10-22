class MatchSeries < ApplicationRecord
  include ArcWardenDbConcern
  self.table_name = "match_series"
end
